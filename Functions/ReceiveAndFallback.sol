// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// @author 0x71pp17
/// @notice Demonstrates the use of receive() and fallback() functions
/// @dev receive() is called when Ether is sent with empty calldata
/// @dev fallback() is called when function selector doesn't match or calldata is non-empty without matching function
contract ReceiveAndFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;

    /// @notice Executed when Ether is received with empty calldata
    /// @dev Has no input data; triggered by plain Ether transfers (e.g., wallet sends)
    /// @dev Takes precedence over fallback() when msg.data is empty
    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    /// @notice Executed when no function matches the call or receive() is absent
    /// @dev Triggered when calldata is non-empty but doesn't match any function
    /// @dev Also handles plain Ether transfers if receive() is not defined
    /// @dev Reverts if not payable and value is sent
    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}   
