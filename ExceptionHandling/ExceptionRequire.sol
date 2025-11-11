// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @author 0x71pp17
/// @notice Tracks user balances with deposit and withdrawal functionality
contract ExceptionRequire {

    // State variable: Maps user addresses to their deposited balances
    mapping(address => uint) public balanceReceived;

    /// @notice Accepts ETH and adds it to the sender's balance
    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    /// @notice Withdraws a specified amount to a given address
    /// @param _to Recipient address
    /// @param _amount Amount to withdraw
    /// @dev Uses if condition without revert — **vulnerable**: fails silently if balance insufficient
    function withdrawMoney(address payable _to, uint _amount) public {
        if (_amount <= balanceReceived[msg.sender]) {
            balanceReceived[msg.sender] -= _amount;
            _to.transfer(_amount);
        }
    }
}   
