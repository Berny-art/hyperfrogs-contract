//SPDX-License-Identifier: MIT  
pragma solidity ^0.8.20;

import "../@openzeppelin/contracts/access/AccessControl.sol";
import "../@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "../@openzeppelin/contracts/utils/Strings.sol";
import "../@openzeppelin/contracts/utils/Base64.sol";
import "../erc721a/contracts/ERC721A.sol";

// Trait contracts
import "./traits/FrogsBody.sol";
import "./traits/FrogsHats.sol";
import "./traits/FrogsEyesA.sol";
import "./traits/FrogsEyesB.sol";
import "./traits/FrogsMouth.sol";
import "./traits/FrogsFeet.sol";
import "./traits/FrogsBackdrop.sol";
import "./traits/FrogsOneOfOne.sol";

contract HyperFrogs is ERC721A, AccessControl, ReentrancyGuard {
    using Strings for uint256;

    // Roles
    bytes32 public constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");

    // Custom errors for gas efficiency.
    error MintNotActive();
    error ExceedsMaxPerTx();
    error IncorrectEthSent();
    error WalletLimitReached();
    error SoldOut();
    error NoContracts();
    error FreeMintNotActive();
    error NotOnWhitelist();
    error NoMoreFreeFrogs();
    error TransferFailed();

    /// Mint Settings
    uint public constant maxSupply = 2222;
    uint public mintPrice = 1 ether; // is 1 HYPE
    uint public maxFree = 200;
    uint public freeCount = 0;
    bool public mintEnabled = false;
    bool public freeMintEnabled = false;

    /// Mint Rules
    uint public maxMintPerTrans = 5;
    uint public maxMintPerWallet = 5;

    /// One-of-one settings
    uint public constant maxOneOfOne = 2;
    uint public mintedOneOfOne = 0;

    /// Whitelist Settings
    mapping(address => bool) public freeList;
    mapping(address => bool) public whitelist;
    mapping(address => uint) public mintAmount;
    uint public whitelistEndTime;

    /// Trait structure (note: eyes now uses a combined selection from EyesA and EyesB)
    struct TraitStruct {
        bool oneOfOne;
        uint oneOfOneIndex;
        uint backdrop;
        uint hat;
        uint eyesIndex; // The chosen index from the eyes contract
        bool eyesIsA;  // true if selected from EyesA; false if from EyesB
        uint mouth;
        uint body;
        uint feet;
    }

    mapping(uint => TraitStruct) public tokenTraits;

    // Immutable external trait contracts
    FrogsBody public immutable frogsBody;
    FrogsHats public immutable frogsHats;
    FrogsEyesA public immutable frogsEyesA;
    FrogsEyesB public immutable frogsEyesB;
    FrogsMouth public immutable frogsMouth;
    FrogsFeet public immutable frogsFeet;
    FrogsBackdrop public immutable frogsBackdrop;
    FrogsOneOfOne public immutable frogsOneOfOne;

    constructor(
        address _body,
        address _hats,
        address _eyesA,
        address _eyesB,
        address _mouth,
        address _feet,
        address _backdrop,
        address _oneOfOne
    ) ERC721A("HyperFrogs", "HYF") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(CONTROLLER_ROLE, msg.sender);
        frogsBody = FrogsBody(_body);
        frogsHats = FrogsHats(_hats);
        frogsEyesA = FrogsEyesA(_eyesA);
        frogsEyesB = FrogsEyesB(_eyesB);
        frogsMouth = FrogsMouth(_mouth);
        frogsFeet = FrogsFeet(_feet);
        frogsBackdrop = FrogsBackdrop(_backdrop);
        frogsOneOfOne = FrogsOneOfOne(_oneOfOne);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721A, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // Override to start token IDs at 1.
    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    function shouldMintOneOfOne(uint256 randomValue) internal view returns (bool) {
        uint256 totalMinted = _totalMinted();
        uint256 remainingSupply = maxSupply - totalMinted;
        uint256 availableOneOfOne = maxOneOfOne - mintedOneOfOne;
        // Probability: availableOneOfOne/remainingSupply.
        return (availableOneOfOne > 0 && (randomValue % remainingSupply) < availableOneOfOne);
    }

    // Standard minting function using custom errors.
    function mint(uint256 quantity) external payable {
        if (!mintEnabled) revert MintNotActive();

        // During the whitelist phase, only addresses in paidWhitelist can mint.
        // Assume that if whitelistEndTime is set (non-zero) and current time is before it, the paid whitelist applies.
        if (whitelistEndTime != 0 && block.timestamp < whitelistEndTime) {
            if (!whitelist[msg.sender]) revert NotOnWhitelist();
        }
        
        if (quantity > maxMintPerTrans) revert ExceedsMaxPerTx();
        if (msg.value != quantity * mintPrice) revert IncorrectEthSent();

        uint256 totalMintedByWallet = mintAmount[msg.sender] + quantity;
        if (totalMintedByWallet > maxMintPerWallet) revert WalletLimitReached();

        mintAmount[msg.sender] = totalMintedByWallet;
        _internalMint(quantity);
    }

    function free_mint() external {
        if (!freeList[msg.sender]) revert NotOnWhitelist();
        if (!freeMintEnabled) revert FreeMintNotActive();
        if (freeCount + 1 > maxFree) revert NoMoreFreeFrogs();

        freeList[msg.sender] = false;
        freeCount++;
        _internalMint(1);
    }

    /// Generates traits for a given token.
    function _generateTraits(uint256 tokenId, bytes32 blockHash) internal returns (TraitStruct memory) {
        uint[5] memory randomSeeds = _randomSeed(blockHash, tokenId);
         uint backdropTrait = 0;

        // Decide if the token is a one-of-one
        if (shouldMintOneOfOne(randomSeeds[0])) {
            mintedOneOfOne++;
            uint oneOfOneIndex = randomSeeds[1] % frogsOneOfOne.totalOneOfOne();
            return TraitStruct({
                oneOfOne: true,
                oneOfOneIndex: oneOfOneIndex,
                backdrop: backdropTrait,
                hat: 0,
                eyesIndex: 0,
                eyesIsA: true,
                mouth: 0,
                body: 0,
                feet: 0
            });
        }

        // Generate normal traits
        uint hatTrait = _pickTraitCumulative(randomSeeds[0], frogsHats.getHatsProbability(), 0);
        uint mouthTrait = _pickTraitCumulative(randomSeeds[1], frogsMouth.getMouthProbability(), 0);
        uint bodyTrait = _pickTraitCumulative(randomSeeds[2], frogsBody.getBodyProbability(), 0);
        uint feetTrait = _pickTraitCumulative(randomSeeds[3], frogsFeet.getFeetProbability(), 0);

        // Combined eyes trait selection:
        uint eyesRandom = (randomSeeds[4] % 100) + 1; // Random number in [1, 100]
        bool eyesIsA;
        uint eyesIndex;
        // EyesA cumulative probability is assumed to have a ceiling of 43.
        if (eyesRandom <= 43) {
            eyesIsA = true;
            eyesIndex = _pickTraitCumulative(eyesRandom, frogsEyesA.getEyesAProbability(), 0);
        } else {
            eyesIsA = false;
            uint adjustedRandom = eyesRandom - 43; // Adjust for EyesB range (total remaining 57)
            eyesIndex = _pickTraitCumulative(adjustedRandom, frogsEyesB.getEyesBProbability(), 43);
        }

        return TraitStruct({
            oneOfOne: false,
            oneOfOneIndex: 0,
            backdrop: backdropTrait,
            hat: hatTrait,
            eyesIndex: eyesIndex,
            eyesIsA: eyesIsA,
            mouth: mouthTrait,
            body: bodyTrait,
            feet: feetTrait
        });
    }

    /// Helper: Iterates over a cumulative probability array.
    /// The `offset` is used to normalize the thresholds.
    function _pickTraitCumulative(uint randomValue, uint[] memory cumulativeArray, uint offset) internal pure returns (uint) {
        for (uint i = 0; i < cumulativeArray.length; i++) {
            if (randomValue <= cumulativeArray[i] - offset) {
                return i;
            }
        }
        return cumulativeArray.length - 1;
    }

    function _internalMint(uint256 quantity) internal {
        uint256 totalMinted = _totalMinted();
        if (totalMinted + quantity > maxSupply) revert SoldOut();
        if (msg.sender != tx.origin) revert NoContracts();

        uint256 startTokenID = _startTokenId() + totalMinted;
        bytes32 currentBlockHash = blockhash(block.number - 1);
        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = startTokenID + i;
            tokenTraits[tokenId] = _generateTraits(tokenId, currentBlockHash);
        }
        _safeMint(msg.sender, quantity);
    }

    /// Generates an array of 5 random seeds.
    function _randomSeed(bytes32 _lastBlockHash, uint256 _tokenId) internal view returns (uint[5] memory _randomSeeds) {
        bytes32 combinedSeed = keccak256(abi.encodePacked(_lastBlockHash, _tokenId, msg.sender, block.prevrandao, block.timestamp));
        for (uint i = 0; i < 5; i++) {
            unchecked {
                _randomSeeds[i] = uint256(keccak256(abi.encodePacked(combinedSeed, i))) % 101;
            }
        }
        return _randomSeeds;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory image = buildSVG(tokenId);
        string memory base64Image = Base64.encode(bytes(image));
        string memory json = string(
            abi.encodePacked(
                '{"name": "Hyper Frog #', tokenId.toString(), '",',
                '"description": "Hyper Frogs are pure ASCII art frogs and live 100% onchain on Hyperliquid.",',
                '"attributes": [', _getFrogTraits(tokenId), '],',
                '"image": "data:image/svg+xml;base64,', base64Image, '"}'
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));
    }

    function buildSVG(uint tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        TraitStruct memory traits = tokenTraits[tokenId];

        if (traits.oneOfOne) {
            return string(
                abi.encodePacked(
                    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 90 90" shape-rendering="crispEdges" width="512" height="512">',
                    '<style>',
                    'svg {',
                        'width: 100%;',
                        'height: 100%;',
                        'margin: 0;',
                        'padding: 0;',
                        'overflow: hidden;',
                        'display: flex;',
                        'justify-content: center;',
                        'background:', frogsBackdrop.getBackdropData(traits.backdrop), ';',
                    '}',
                    '</style>',
                    '<rect width="90" height="90" fill="', frogsBackdrop.getBackdropData(traits.backdrop), '"/>',
                    _getSVGTraitData(frogsOneOfOne.getOneOfOneData(traits.oneOfOneIndex)),
                    '</svg>'
                )
            );
        }

        return string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 90 90" shape-rendering="crispEdges" width="512" height="512">',
                '<style>',
                'svg {',
                    'width: 100%;',
                    'height: 100%;',
                    'margin: 0;',
                    'padding: 0;',
                    'overflow: hidden;',
                    'display: flex;',
                    'justify-content: center;',
                    'background:', frogsBackdrop.getBackdropData(traits.backdrop), ';',
                '}',
                '</style>',
                '<rect width="90" height="90" fill="', frogsBackdrop.getBackdropData(traits.backdrop), '"/>',
                _getSVGTraitData(frogsBody.getBodyData(traits.body)),
                _getSVGTraitData(frogsHats.getHatsData(traits.hat)),
                // Choose eyes data from the appropriate trait contract.
                _getSVGTraitData(traits.eyesIsA ? frogsEyesA.getEyesAData(traits.eyesIndex) : frogsEyesB.getEyesBData(traits.eyesIndex)),
                _getSVGTraitData(frogsMouth.getMouthData(traits.mouth)),
                _getSVGTraitData(frogsFeet.getFeetData(traits.feet)),
                '</svg>'
            )
        );
    }

    function trimTrailingZeros(bytes memory data) internal pure returns (bytes memory) {
        uint256 len = data.length;
        // Find the last index that is not zero.
        while (len > 0 && data[len - 1] == 0) {
            len--;
        }
        // Create a new bytes array of the trimmed length.
        bytes memory trimmed = new bytes(len);
        for (uint256 i = 0; i < len; i++) {
            trimmed[i] = data[i];
        }
        return trimmed;
    }

    function _getSVGTraitData(bytes memory data) internal pure returns (string memory) {
        if (data.length == 0) return "";
        // Trim trailing zero bytes before converting to string.
        bytes memory trimmedData = trimTrailingZeros(data);
        return string(trimmedData);
    }

    function _getFrogTraits(uint tokenId) internal view returns (string memory) {
        TraitStruct memory traits = tokenTraits[tokenId];

        // If this token is a one-of-one, return only its one-of-one trait.
        if (traits.oneOfOne) {
            string memory traitName = frogsOneOfOne.getOneOfOneTrait(traits.oneOfOneIndex);
            return string(
                abi.encodePacked(
                    '{"trait_type":"Backdrop", "value":"', frogsBackdrop.getBackdropTrait(traits.backdrop), '"},',
                    '{"trait_type":"Hat", "value":"', traitName, '"},',
                    '{"trait_type":"Eyes", "value":"', traitName, '"},',
                    '{"trait_type":"Mouth", "value":"', traitName, '"},',
                    '{"trait_type":"Body", "value":"', traitName, '"},',
                    '{"trait_type":"Feet", "value":"', traitName, '"}'
                )
            );
        }

        // Otherwise, return the standard traits.
        string memory eyesTrait = traits.eyesIsA
            ? frogsEyesA.getEyesATrait(traits.eyesIndex)
            : frogsEyesB.getEyesBTrait(traits.eyesIndex);
        return string(
            abi.encodePacked(
                '{"trait_type":"Backdrop", "value":"', frogsBackdrop.getBackdropTrait(traits.backdrop), '"},',
                '{"trait_type":"Hat", "value":"', frogsHats.getHatsTrait(traits.hat), '"},',
                '{"trait_type":"Eyes", "value":"', eyesTrait, '"},',
                '{"trait_type":"Mouth", "value":"', frogsMouth.getMouthTrait(traits.mouth), '"},',
                '{"trait_type":"Body", "value":"', frogsBody.getBodyTrait(traits.body), '"},',
                '{"trait_type":"Feet", "value":"', frogsFeet.getFeetTrait(traits.feet), '"}'
            )
        );
    }

    // --- Admin Functions (protected by DEFAULT_ADMIN_ROLE) ---

    function toggleMinting() external onlyRole(DEFAULT_ADMIN_ROLE) {
        mintEnabled = !mintEnabled;
    }

    function toggleFreeMinting() external onlyRole(DEFAULT_ADMIN_ROLE) {
        freeMintEnabled = !freeMintEnabled;
    }

    function setMaxFree(uint _newMaxFree) external onlyRole(DEFAULT_ADMIN_ROLE) {
        maxFree = _newMaxFree;
    }

    function devMint(uint _quantity) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _internalMint(_quantity);
    }

    function setWhitelistDuration(uint _whitelistDuration) external onlyRole(DEFAULT_ADMIN_ROLE) {
        whitelistEndTime = block.timestamp + _whitelistDuration;
    }

    function addToWhitelist(address[] calldata addresses) external onlyRole(CONTROLLER_ROLE) nonReentrant {
        for (uint i = 0; i < addresses.length; i++) {
            whitelist[addresses[i]] = true;
        }
    }

    function addToFreeList(address[] calldata addresses) external onlyRole(CONTROLLER_ROLE) nonReentrant {
        for (uint i = 0; i < addresses.length; i++) {
            freeList[addresses[i]] = true;
        }
    }

    function withdraw() external onlyRole(DEFAULT_ADMIN_ROLE) nonReentrant {
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        if (!success) revert TransferFailed();
    }

    function setMintPrice(uint _newPrice) external onlyRole(DEFAULT_ADMIN_ROLE) {
        mintPrice = _newPrice;
    }
}