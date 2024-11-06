// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount{

	uint256 private balance;
	address private accOwner;

	constructor() payable {
		balance = msg.value;
		accOwner = msg.sender;
	}

	modifier onlyOwner() {
		require(accOwner == msg.sender,"Only account owner can perform this action.");
		_;
	}

	function deposit(uint256 _amount) public onlyOwner payable {
		require(_amount > 0,"Amount deposited must be more than 0 Wei");
		balance += _amount;
	}

	function withdraw(uint256 _amount) public onlyOwner payable {
		require(_amount <= balance && balance > 0, "Insufficient Balance");
		balance -= _amount;
		payable(msg.sender).transfer(_amount);
	}

	function getBalance() public view onlyOwner returns (uint256){
		return balance;
	}

}