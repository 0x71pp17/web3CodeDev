// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @author 0x71pp17
/// @notice A contract that demonstrates a function reverting with an error message
contract WillThrow {
    /// @notice Function that always reverts with a custom error message
    /// @dev Uses `require(false)` to force a revert, simulating a failure condition
    function aFunction() public pure {
        require(false, "Error message");
    }
}

/// @title TryCatchErrorHandling
/// @author 0x71pp17
/// @notice A contract that handles errors from external calls using try/catch
contract TryCatchErrorHandling {
    /// @notice Event emitted when an error is caught
    /// @param reason The error message from the failed external call
    event ErrorLogging(string reason);

    /// @notice Demonstrates catching an error from an external contract call
    /// @dev Deploys `WillThrow` and calls `aFunction()`, catching the revert and logging the reason
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // Action on success (none in this case)
        } catch Error(string memory reason) {
            emit ErrorLogging(reason); // Log the error message
        }
    }
}   
