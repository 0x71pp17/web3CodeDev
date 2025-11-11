// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// @author 0x71pp17
/// @notice A contract allowing users to deposit and withdraw only their own funds
contract SmartMoney {
    /// @notice Tracks the amount deposited by each address
    mapping(address => uint) public userBalance;

    /// @notice Records total deposits (optional, for tracking)
    uint public totalDeposits;

    /// @notice Deposits Ether into the contract, credited to the sender's balance
    /// @dev Increases userBalance[msg.sender] and totalDeposits by msg.value
    /// @dev Reverts if no Ether is sent (implicit)
    function deposit() public payable {
        userBalance[msg.sender] += msg.value;
        totalDeposits += msg.value;
    }

    /// @notice Gets the contract's current Ether balance
    /// @dev Uses address(this).balance to return total contract balance in Wei
    /// @return The contract's Ether balance in Wei
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Withdraws the sender's own deposited funds
    /// @dev Transfers user's balance via .transfer() which limits gas to prevent reentrancy
    /// @dev Resets user balance to zero after withdrawal
    /// @dev Reverts if user has no balance
    function withdraw() public {
        uint userBal = userBalance[msg.sender];            // Get the user's current balance
        require(userBal > 0, "No balance to withdraw");    // Revert if balance is zero
        payable(msg.sender).transfer(userBal);             // Send Ether to user (fails if recipient is a contract that can't receive Ether)
        totalDeposits -= userBal;                          // Deduct withdrawn amount from total
        userBalance[msg.sender] = 0;                       // Reset user balance to zero to prevent re-withdrawal   
    }
}   
