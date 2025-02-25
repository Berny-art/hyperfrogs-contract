require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("dotenv").config();

require("./tasks/deploy");
require("./tasks/toggle-minting");
require("./tasks/batch-add-whitelist");
require("./tasks/withdraw-funds");
require("./tasks/add-freelist");
require("./tasks/free-mint");
require("./tasks/check-freelist");
require("./tasks/dev-mint");
require("./tasks/set-whitelist-duration");
require("./tasks/set-max-mint-per-wallet");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.28",
    settings: {
      optimizer: {
        enabled: true,
        runs: 500, // Higher value for smaller bytecode
      },
      viaIR: true,
    },
  },
  networks: {
    hyperliquid_testnet: {
      url: "https://rpc.hyperliquid-testnet.xyz/evm",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 998,
    },
    hyperliquid_mainnet: {
      url: "https://rpc.hyperliquid.xyz/evm",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 999, 
    },
    'hyperliquid-evm': {
      url: 'https://rpc.hyperliquid.xyz/evm'
    },
  },
  etherscan: {
    apiKey: {
      'hyperliquid-evm': 'empty'
    },
    customChains: [
      {
        network: "hyperliquid-evm",
        chainId: 999,
        urls: {
          apiURL: "https://hyperliquid.cloud.blockscout.com/api",
          browserURL: "https://hyperliquid.cloud.blockscout.com"
        }
      }
    ]
  }
};