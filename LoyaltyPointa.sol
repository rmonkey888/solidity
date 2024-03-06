// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoyaltyPoints {
    address public owner;
    mapping(address => uint) public pointsBalance;

    event PointsEarned(address indexed account, uint amount);
    event PointsSpent(address indexed account, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function earnPoints(uint amount) external {
        pointsBalance[msg.sender] += amount;
        emit PointsEarned(msg.sender, amount);
    }

    function spendPoints(uint amount) external {
        require(pointsBalance[msg.sender] >= amount, "Insufficient points balance");

        pointsBalance[msg.sender] -= amount;
        emit PointsSpent(msg.sender, amount);
    }
    
}