// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title FunctionsViewPure
/// @author 0x71pp17
/// @notice Demonstrates stateless and state-reading functions using view and pure modifiers
contract FunctionsViewPure {

    // State variable: Stores a number accessible by all functions within the contract
    // 'public' generates a getter function automatically
    uint public myStorageVariable;

    /// @notice Retrieves the current value of myStorageVariable
    /// @return The stored unsigned integer value
    /// @dev This function reads from contract storage, so it's marked as 'view'
    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    /// @notice Adds two numbers without accessing or modifying contract state
    /// @param a First number
    /// @param b Second number
    /// @return Sum of a and b
    /// @dev Pure functions rely only on inputs and perform no state operations
    function getAddition(uint a, uint b) public pure returns(uint) {
        return a + b;
    }

    /// @notice Updates the value of myStorageVariable
    /// @param _newVar The new value to store
    /// @return The new value that was set
    /// @dev This function modifies state and thus must not be view or pure
    /// @dev Note: Return value is only accessible in contract-to-contract calls
    ///      off-chain callers (e.g., wallets, scripts) cannot access it.
    ///      Use events to notify external consumers of state changes.
    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }
}   
