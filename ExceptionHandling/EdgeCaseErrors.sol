// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @author 0x71pp17
/// @notice Contract demonstrating edge cases in Solidity error handling
/// @dev Covers missing return data, type mismatches, and low-level call failures
contract EdgeCaseErrors {
    /// @notice Emitted when a low-level revert or decoding failure occurs
    event LowLevelError(bytes data);
    /// @notice Emitted on successful operation (for testing/debugging)
    event Success(bool indexed success);

    /// @notice Simulates a function with no return data
    /// @dev External calls to this function return empty `data`
    ///      This can cause decoding errors if not checked
    function noReturn() external pure {
        // No return statement — results in empty response
    }

    /// @notice Simulates a type mismatch (returns address instead of uint256)
    /// @dev If called via interface expecting uint256, this returns raw address bytes
    ///      which may be misinterpreted without proper validation
    function badType() external view returns (address) {
        return msg.sender;
    }

    /// @notice Handles external call that returns no data
    /// @dev Uses low-level `.call` to invoke `noReturn()`
    ///      Checks both `success` and `data.length` to detect missing returns
    ///      Emits `LowLevelError` if call fails or returns empty data
    function catchMissingReturn(address ext) external {
        (bool success, bytes memory data) = ext.call(abi.encodeWithSignature("noReturn()"));
        if (!success || data.length == 0) {
            emit LowLevelError(data); // Handle missing or failed responses
        }
    }

    /// @notice Safely decodes return data despite potential type mismatch
    /// @dev Calls `badType()` which returns `address`, but attempts to decode as `uint256`
    ///      Wraps `abi.decode` in `try/catch` to prevent revert on type mismatch
    ///      Emits `LowLevelError` if decoding fails
    function catchTypeMismatch(address ext) external {
        (bool success, bytes memory data) = ext.call(abi.encodeWithSignature("badType()"));
        if (!success) {
            emit LowLevelError(data);
            return;
        }
        try abi.decode(data, (uint256)) returns (uint256) {
            emit Success(true);
        } catch {
            emit LowLevelError(data); // Catch invalid type or decode error
        }
    }

    /// @notice Performs low-level Ether transfer
    /// @dev `.call` returns `success` and `data`; does NOT revert on failure
    ///      Must explicitly check `success` to detect failure
    ///      Using `require(success, ...)` enforces revert if transfer fails
    function lowLevelTransfer(address payable to) external payable {
        (bool success, ) = to.call{value: msg.value}("");
        require(success, "Transfer failed");
    }
}   
