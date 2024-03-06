// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarAuction {
    address payable public owner;
    uint public startBlock;
    uint public endBlock;
    string public carName;
    uint public minPrice;
    address public highestBidder;
    uint public highestBid;

    mapping(address => uint) public bids;

    enum AuctionState { Active, Inactive }
    AuctionState public state;

    constructor(
        string memory _carName,
        uint _startBlock,
        uint _endBlock,
        uint _minPrice
    ) {
        owner = payable(msg.sender);
        carName = _carName;
        startBlock = _startBlock;
        endBlock = _endBlock;
        minPrice = _minPrice;
        state = AuctionState.Active;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyActive() {
        require(block.number >= startBlock && block.number <= endBlock, "Auction is not active");
        _;
    }

    modifier onlyInactive() {
        require(block.number > endBlock, "Auction is still active");
        _;
    }

    function bid() external payable onlyActive {
        require(msg.value > minPrice, "Bid amount must be greater than min price");
        require(msg.value > highestBid, "Bid amount must be greater than current highest bid");

        if (highestBid != 0) {
            // Refund the previous highest bidder
            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        bids[msg.sender] += msg.value;
    }

    function endAuction() external onlyOwner onlyInactive {
        state = AuctionState.Inactive;
        owner.transfer(address(this).balance);
    }

   
}