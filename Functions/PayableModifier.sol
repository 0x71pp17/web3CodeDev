// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// @author 0x71pp17
/// @notice A contract that updates a string only if exactly 1 ETH is sent; refunds otherwise
/// @dev Uses `payable` and `msg.value` for value-based access control
contract PayableModifier {
    string public myString = "Hello World";

    /// @notice Updates `myString` only if exactly 1 ETH is sent
    /// @dev Uses `payable` to accept Ether, enabling value-based access control
    /// @dev Uses `msg.value` to check amount sent, `msg.sender` to identify caller
    /// @dev Refunds sender if value is not exactly 1 ether
    function updateString(string memory _newString) public payable {
        if (msg.value == 1 ether) {
            myString = _newString;  // Update state only when correct amount is paid
        } else {
            // `payable(msg.sender)` ensures address can receive Ether
            // `.transfer(msg.value)` sends back the full amount received
            payable(msg.sender).transfer(msg.value);  // Refund any incorrect amount
        }
    }
}   
