// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YieldFarm {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public rewards;

    uint256 public rewardRate = 10; // 10% yield

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Stake tokens into the farm
    function stake() external payable {
        require(msg.value > 0, "Stake must be greater than 0");
        balances[msg.sender] += msg.value;
        rewards[msg.sender] += (msg.value * rewardRate) / 100;
    }

    // Withdraw staked tokens and earned rewards
    function withdraw() external {
        uint256 balance = balances[msg.sender];
        uint256 reward = rewards[msg.sender];
        require(balance > 0, "No funds to withdraw");

        balances[msg.sender] = 0;
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(balance + reward);
    }

    // View staked balance and pending rewards
    function checkStake() external view returns (uint256 staked, uint256


