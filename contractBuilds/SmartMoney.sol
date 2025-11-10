// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

/// @author 0x71pp17
/// @notice A contract to handle depositing and withdrawing Ether
contract SendWithdrawMoney {

    // The total balance received by the contract
    uint public balanceReceived;

    /// @notice Deposits Ether into the contract
    /// @dev Updates the `balanceReceived` state variable with the amount sent
    /// @dev This function is payable, allowing it to receive Ether
    function deposit() public payable {
        balanceReceived += msg.value;
    }

    /// @notice Gets the current Ether balance of the contract
    /// @dev Uses `address(this).balance` to retrieve the contract's balance
    /// @return The contract's current balance in Wei
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Withdraws the entire contract balance to the caller
    /// @dev Transfers all funds to `msg.sender` using the `transfer` method
    /// @dev Be cautious: this function sends all available funds
    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    /// @notice Withdraws the entire contract balance to a specified address
    /// @dev Transfers all funds to the provided address using `transfer`
    /// @param to The address to which the funds will be sent
    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }
}   
