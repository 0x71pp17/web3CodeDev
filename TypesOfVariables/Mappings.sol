// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @author 0x71pp17
/// @notice Demonstrates how mappings store and retrieve data by key (uint or address)
/// @dev Mappings are efficient for lookups; values are stored at virtual initial value of 0
contract SimpleMappingExample {

    /// @notice Maps unsigned integers to boolean flags (e.g., task completion)
    mapping(uint => bool) public myMapping;

    /// @notice Maps Ethereum addresses to boolean flags (e.g., user registration status)
    mapping(address => bool) public myAddressMapping;

    /// @notice Sets a boolean flag to true for a given index
    /// @dev Updates myMapping[_index] to true
    /// @param _index The key in the mapping to set
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    /// @notice Registers the caller's address as active in the mapping
    /// @dev Uses msg.sender as the key and sets value to true
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}   
