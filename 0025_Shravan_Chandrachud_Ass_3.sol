// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    uint256 private balance;

    // Payable constructor to allow deposits on deployment (if desired)
    constructor() payable {
        balance = msg.value; // Initialize balance with the deployment value
    }

    function deposit(uint256 amount) public payable {
        balance += amount;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balance, "Insufficient funds");
        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }
}
