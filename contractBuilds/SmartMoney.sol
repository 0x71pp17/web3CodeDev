// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

/// @author 0x71pp17
/// @notice A contract allowing users to deposit and withdraw only their own funds
contract SendWithdrawMoney {
    /// @notice Tracks the amount deposited by each address
    mapping(address => uint) public userBalance;

    /// @notice Records total deposits (optional, for tracking)
    uint public totalDeposits;

    /// @notice Deposits Ether into the contract, credited to the sender's balance
    function deposit() public payable {
        userBalance[msg.sender] += msg.value;
        totalDeposits += msg.value;
    }

    /// @notice Gets the contract's current Ether balance
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Withdraws the sender's own deposited funds
    function withdraw() public {
        uint userBal = userBalance[msg.sender];
        require(userBal > 0, "No balance to withdraw");
        payable(msg.sender).transfer(userBal);
        totalDeposits -= userBal;
        userBalance[msg.sender] = 0;
    }
}   
