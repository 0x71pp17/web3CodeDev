// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

/// @author 0x71pp17
/// @notice Holds deposits and tracks balances per address
contract ContractOne {
    /// @notice Maps user addresses to their deposited balance
    mapping(address => uint) public addressBalances;

    /// @notice Returns the contract's current Ether balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    /// @notice Accepts Ether and credits sender's balance
    /// @dev Must be payable to receive Ether
    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }
}

/// @title ContractTwo
/// @notice Demonstrates external contract function calls
contract ContractTwo {
    /// @notice Accepts Ether (used for forwarding)
    function deposit() public payable {}

    /// @notice Calls deposit() on ContractOne with Ether and gas
    /// @dev Uses external call syntax: ContractOne(_addr).function{value, gas}()
    /// @dev Creates a new message call (not internal jump)
    /// @param _contractOne Address of the target ContractOne instance
    function depositOnContractOne(address _contractOne) public { 
        ContractOne one = ContractOne(_contractOne);
        // Sends 10 wei and forwards 100,000 gas to the external call
        one.deposit{value: 10, gas: 100000}(); 
    }
}   
