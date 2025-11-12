// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

/// @author 0x71pp17
/// @notice Tracks deposits with strict internal invariants using assert
/// @dev Uses assert to enforce data integrity and prevent overflow/underflow (pragma set behind 0.8.0)
contract ExceptionAssert {

    // State variable: Maps user addresses to their balance (uint8, limited range)
    mapping(address => uint8) public balanceReceived;

    /// @notice Accepts ETH and updates sender's balance
    /// @dev Uses assert to ensure no overflow and valid state transitions
    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value)); // Ensure value fits in uint8
        uint8 value = uint8(msg.value);
        balanceReceived[msg.sender] += value;
        assert(balanceReceived[msg.sender] >= value); // Balance should not underflow (always true)
    }

    /// @notice Withdraws ETH from user's balance
    /// @param _to Recipient address
    /// @param _amount Amount to withdraw
    /// @dev Uses assert to check internal invariants before updating state
    /// @dev Reverts with Panic if assertion fails (e.g., underflow)
    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        assert(balanceReceived[msg.sender] >= _amount); // Ensure sufficient balance before subtraction
        balanceReceived[msg.sender] -= uint8(_amount);
        _to.transfer(_amount);
    }
}   
