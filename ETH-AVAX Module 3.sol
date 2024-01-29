// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    address owner;
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
        // Mint initial supply to the contract owner
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    modifier checkAmount(uint amount) {
        require(amount > 0, "Transfer amount must be greater than 0");
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the Owner");
        _;
    }

    function mint(address to, uint amount) external onlyOwner {
        // Allowing only the owner to mint new tokens
        _mint(to, amount);
    }

    function burn(uint amount) external checkAmount(amount) {
        // Allowing any user to burn their own tokens
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint amount) public checkAmount(amount) override returns (bool) {
        // Overriding transfer function
        return super.transfer(to, amount);
    }
}
