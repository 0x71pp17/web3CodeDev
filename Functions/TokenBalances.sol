// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

/**
 * @title Balances Library
 * @author 0x71pp17 
 * @dev Library to manage and transfer balances in a mapping.
 * Functions are internal and used via `using Balances for mapping(address => uint256)`.
 */
library Balances {
    /**
     * @dev Safely moves tokens from one address to another.
     * @param balances Storage reference to the balance mapping.
     * @param from Address to transfer from.
     * @param to Address to transfer to.
     * @param amount Amount of tokens to transfer.
     * Requirements:
     * - `from` must have sufficient balance.
     * - Arithmetic overflow/underflow is prevented.
     */
    function move(
        mapping(address => uint256) storage balances,
        address from,
        address to,
        uint256 amount
    ) internal {
        require(balances[from] >= amount, "Insufficient balance");
        balances[from] -= amount;
        balances[to] += amount;
    }
}

/**
 * @title Token Contract
 * @dev ERC20-like token with balance transfers that use arithmetic operations and validation logic from the library
 */
contract TokenBalances {
    // Attach the Balances library to all mappings of type address => uint256
    using Balances for mapping(address => uint256);

    // Stores balances for each address
    mapping(address => uint256) public balances;

    // Allowance mapping for delegated transfers (spender -> owner -> amount)
    mapping(address => mapping(address => uint256)) public allowed;

    // Events to log transfers and approvals
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    /**
     * @dev Transfer tokens to another address.
     * @param to Recipient address.
     * @param amount Amount to transfer.
     * @return success Boolean indicating success.
     */
    function transfer(address to, uint256 amount) external returns (bool success) {
        balances.move(msg.sender, to, amount); // Use library function
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    /**
     * @dev Transfer tokens from another address (with allowance).
     * @param from Owner of the tokens.
     * @param to Recipient address.
     * @param amount Amount to transfer.
     * @return success Boolean indicating success.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool success) {
        require(allowed[from][msg.sender] >= amount, "Allowance exceeded");
        allowed[from][msg.sender] -= amount;
        balances.move(from, to, amount); // Use library function
        emit Transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Approve another address to spend tokens on your behalf.
     * @param spender Address to grant allowance to.
     * @param tokens Amount to approve.
     * @return success Boolean indicating success.
     */
    function approve(address spender, uint256 tokens) external returns (bool success) {
        require(allowed[msg.sender][spender] == 0, "Allowance already set");
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    /**
     * @dev Query the balance of a given address.
     * @param tokenOwner Address to query.
     * @return balance Token balance of the address.
     */
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return balances[tokenOwner];
    }
}   
