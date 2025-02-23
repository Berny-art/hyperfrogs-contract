// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FrogsBackdrop {
    // Data for the backdrop trait
    string[] internal backdrop_data = [
        "#12221F" // Hyper
    ];

    string[] internal backdrop_traits = [
        'Hyper'
    ];

    // Getter functions
    function getBackdropTrait(uint index) external view returns (string memory) {
        return backdrop_traits[index];
    }

    function getBackdropData(uint index) external view returns (string memory) {
        return backdrop_data[index];
    }

    function totalBackdrop() external view returns (uint) {
        return backdrop_traits.length;
    }
}
