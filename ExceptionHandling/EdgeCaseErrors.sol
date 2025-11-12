// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract EdgeCaseDemo {
    event LowLevelError(bytes data);
    event Success(bool indexed success);

    // Simulates missing return data
    function noReturn() external pure {
        // No return statement
    }

    // Simulates type mismatch (returns address instead of uint256)
    function badType() external view returns (address) {
        return msg.sender;
    }

    // Handles external call with missing/invalid return data
    function catchMissingReturn(address ext) external {
        (bool success, bytes memory data) = ext.call(abi.encodeWithSignature("noReturn()"));
        if (!success || data.length == 0) {
            emit LowLevelError(data); // Handle empty response
        }
    }

    // Handles type mismatch during decoding
    function catchTypeMismatch(address ext) external {
        (bool success, bytes memory data) = ext.call(abi.encodeWithSignature("badType()"));
        if (!success) {
            emit LowLevelError(data);
            return;
        }
        try abi.decode(data, (uint256)) returns (uint256) {
            emit Success(true);
        } catch {
            emit LowLevelError(data); // Catch invalid type
        }
    }

    // Uses low-level call with explicit success check
    function lowLevelTransfer(address payable to) external payable {
        (bool success, ) = to.call{value: msg.value}("");
        require(success, "Transfer failed");
    }
}   
