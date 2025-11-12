// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @author 0x71pp17
/// @notice Comprehensive error handling demo with require, assert, and custom revert
contract TryCatchErrors.sol {
    /// @dev Custom error for low-level reverts (gas-efficient)
    error CustomError(string message);

    /// @notice Emitted when require() fails with a message
    event RequireError(string reason);
    /// @notice Emitted when assert() triggers a panic
    event AssertError(uint errorCode);
    /// @notice Fallback for raw revert data (catch-all)
    event LowLevelError(bytes data);

    /// @notice Reverts via require - used for invalid input/conditions
    /// @dev Triggers catch Error(string) - ideal for user-facing validation
    function throwErrorRequire() external pure {
        require(false, "Require failed: Invalid input or state");
    }

    /// @notice Reverts via assert - used for internal invariants
    /// @dev Triggers catch Panic(uint) - indicates a bug in the code
    function throwErrorAssert() external pure {
        assert(false);
    }

    /// @notice Reverts with custom error - gas-efficient and descriptive
    /// @dev Triggers catch (bytes) - must decode selector to identify error
    function throwErrorRevert() external pure {
        revert CustomError("Low-level revert: Custom error thrown");
    }

    /// @notice Catches high-level errors (require/revert with string)
    /// @dev Also captures low-level data as fallback
    function catchRequire() external {
        try this.throwErrorRequire() {
        } catch Error(string memory reason) {
            emit RequireError(reason); // Human-readable message
        } catch (bytes memory data) {
            emit LowLevelError(data); // Raw data if decoding fails
        }
    }

    /// @notice Catches system-level panics (assert failures)
    /// @dev Panic codes indicate specific internal errors (e.g., 0x11 = assertion failed)
    function catchAssert() external {
        try this.throwErrorAssert() {
        } catch Panic(uint errorCode) {
            emit AssertError(errorCode);
        } catch (bytes memory data) {
            emit LowLevelError(data); // Fallback for unknown panics
        }
    }

    /// @notice Catches custom errors via low-level data
    /// @dev Custom errors return encoded selector + args in bytes
    function catchRevert() external {
        try this.throwErrorRevert() {
        } catch Error(string memory reason) {
            emit RequireError(reason); // Handles string-based reverts
        } catch (bytes memory data) {
            emit LowLevelError(data); // Required to catch CustomError
        }
    }
}   
