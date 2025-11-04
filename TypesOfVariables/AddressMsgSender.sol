// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/// @title AddressMsgSender
/// @author 0x71pp17
/// @notice Demonstrates address manipulation and balance querying
contract AddressMsgSender {
    // Public state variable to store an Ethereum address
    address public someAddress;

    /// @notice Set the stored address to msg.sender address
    function setSomeAddress() public {
        someAddress = msg.sender;
    }
}   
