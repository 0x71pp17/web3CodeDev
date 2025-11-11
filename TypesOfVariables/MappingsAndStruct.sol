// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @author 0x71pp17
/// @notice Combines mappings and structs to track detailed balance history per user
/// @dev Uses nested mappings inside struct to store deposits and withdrawals by index
contract MappingsAndStruct {
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) deposits;     // Stores each deposit by index
        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;  // Stores each withdrawal by index
    }

    /// @notice Maps each address to their balance and transaction history
    mapping(address => Balance) public balanceReceived;

    /// @notice Returns the total balance of a given address
    function getBalance(address _addr) public view returns(uint) {
        return balanceReceived[_addr].totalBalance;
    }

    /// @notice Records a deposit with amount and timestamp
    /// @dev Increases totalBalance and stores transaction in deposits mapping
    function depositMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numDeposits] = deposit;
        balanceReceived[msg.sender].numDeposits++;
    }

    /// @notice Withdraws a specified amount and records the transaction
    /// @dev Decreases totalBalance and logs withdrawal in withdrawals mapping
    /// @param _to Recipient address
    /// @param _amount Amount to withdraw in Wei
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender].totalBalance, "Insufficient balance");

        balanceReceived[msg.sender].totalBalance -= _amount;

        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numWithdrawals] = withdrawal;
        balanceReceived[msg.sender].numWithdrawals++;

        _to.transfer(_amount);
    }
}   
