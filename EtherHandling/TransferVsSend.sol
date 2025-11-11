// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/// @author 0x71pp17
/// @notice Demonstrates the difference between .transfer and .send for Ether transfers
/// @dev .transfer reverts on failure; .send returns false and allows execution to continue
contract TransferVsSend {
    // Accept incoming Ether
    receive() external payable {}

    /// @notice Sends 10 wei using .transfer
    /// @dev Reverts entire transaction if transfer fails (e.g., recipient out of gas)
    /// @param _to Recipient address
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    /// @notice Sends 10 wei using .send
    /// @dev Returns false if transfer fails; does not revert
    /// @param _to Recipient address
    /// @return success Whether the transfer succeeded
    function withdrawSend(address payable _to) public returns(bool) {
        bool sentSuccessful = _to.send(10);
        return sentSuccessful;
    }
}

/// @title ReceiverNoAction
/// @notice Basic receiver that accepts Ether but performs no action
contract ReceiverNoAction {
    /// @notice Returns the contract's current balance
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    // Accept incoming Ether
    receive() external payable {}
}

/// @title ReceiverAction
/// @notice Receiver that logs received Ether amount
contract ReceiverAction {
    /// @notice Tracks total Ether received
    uint public balanceReceived;

    /// @notice Returns the contract's current balance
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Updates balanceReceived when Ether is received
    receive() external payable {
        balanceReceived += msg.value;
    }
}   
