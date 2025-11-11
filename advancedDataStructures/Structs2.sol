// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/// @author 0x71pp17
/// @notice A simple contract demonstrating struct usage to store payment data
/// @dev Uses a struct to group related data: sender address and amount received
contract Structs {
    /// @notice Struct to store payment details: who sent it and how much
    struct PaymentReceivedStruct {
        address from;   // Address of the sender
        uint amount;    // Amount of Ether received in Wei
    }

    /// @notice Public variable to hold the latest payment data
    /// @dev Automatically generates a getter function due to `public` visibility
    PaymentReceivedStruct public payment;

    /// @notice Accepts Ether and records the sender and amount in the struct
    /// @dev Uses positional arguments to initialize the struct
    /// @dev Overwrites previous payment data on each call
    function payContract() public payable {
        payment = PaymentReceivedStruct(msg.sender, msg.value);
    }
}   
