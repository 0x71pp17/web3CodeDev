// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @author 0x71pp17
/// @notice Implements secure deposit and withdrawal using mappings to track user balances
/// @dev Uses Checks-Effects-Interactions pattern to prevent reentrancy
contract MappingsAngSecurity {
    
    /// @notice Tracks the amount of Ether each address has deposited
    mapping(address => uint) public balanceReceived;

    /// @notice Returns the current contract balance in Wei
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Allows users to deposit Ether into the contract
    /// @dev Updates balanceReceived[msg.sender] by msg.value
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    /// @notice Withdraws a specified amount to a given address
    /// @dev Checks user has sufficient balance before updating state and sending Ether
    /// @param _to Address to receive the funds
    /// @param _amount Amount in Wei to withdraw
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        balanceReceived[msg.sender] -= _amount; // Update state before external call
        _to.transfer(_amount); // Use transfer for safe Ether send (2300 gas stipend)
    }

    /// @notice Withdraws all deposited funds to a specified address
    /// @dev Resets user balance to zero before transferring to prevent reentrancy
    /// @param _to Address to receive the full balance
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0; // Critical: reset balance before transfer
        _to.transfer(balanceToSend);
    }
}   
