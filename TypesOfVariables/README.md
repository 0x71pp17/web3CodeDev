## Solidity Types of Variables

A focused project area for variable types in Solidity, covering state, local, and global variables, along with core data types.


### Key Concepts
- **State Variables**: Permanently stored in contract storage (e.g., `uint256 myVar;`).
- **Local Variables**: Exist only during function execution (e.g., variables declared inside functions).
- **Global Variables**: Special built-in variables like `msg.sender`, `block.timestamp`, and `tx.origin` that provide blockchain context.
- **Data Types**: Includes `bool`, `uint/int`, `address`, `string`, `bytes`, and complex types like arrays and structs.

### Usage
Each `.sol` file includes NatSpec comments (`@title`, `@notice`, `@dev`, `@param`, `@return`) that provide standardized documentation directly within the code and clarify implementation details.

These comments explain the purpose, behavior, and usage of contracts and functions, making the code self-documenting and easier to understand.
