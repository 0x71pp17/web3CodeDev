// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @author 0x71pp17
/// @notice Demonstrates advanced struct usage: nesting, arrays, memory vs storage
contract StructsAdv {

    // Nested struct: Represents a payment with sender, amount, and timestamp
    struct Payment {
        address from;
        uint amount;
        uint timestamp;
    }

    // Main struct: Contains user details and dynamic array of payments
    struct User {
        address addr;
        string name;
        Payment[] payments; // Dynamic array of nested structs
    }

    // State variable: Public instance of User
    // Note: Cannot be 'public' if struct contains arrays (compiler error)
    User private user;

    /// @notice Custom getter to return user data (since struct has arrays)
    /// @return addr The user's address
    /// @return name The user's name
    /// @return payments All recorded payments
    function getUser() public view returns (address, string memory, Payment[] memory) {
        return (user.addr, user.name, user.payments);
    }

    /// @notice Initializes the user with name and address
    /// @dev Uses memory for temporary struct before assigning to storage
    /// @param _name The user's name
    function createUser(string memory _name) public {
        user = User({
            addr: msg.sender,
            name: _name,
            payments: new Payment[](0) // Initialize empty payment array
        });
    }

    /// @notice Accepts ETH and records payment in user's history
    /// @dev Modifies storage via memory reference to avoid gas inefficiency
    function payContract() public payable {
        require(msg.value > 0, "Must send ETH");
        
        // Get storage reference to avoid copying entire struct
        User storage usr = user;
        // Push new payment directly to storage array
        usr.payments.push(Payment(msg.sender, msg.value, block.timestamp));
    }

    /// @notice Returns count of payments made by the user
    /// @return Count of payments
    function getPaymentCount() public view returns (uint) {
        return user.payments.length;
    }
}   
