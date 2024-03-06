// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Voting {
    uint256 public votesForTeamA;
    uint256 public votesForTeamB;
    uint256 public votesForTeamC;
    address public owner;
    mapping(address => bool) authorizedVoters;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyAuthorizedVoter(){
        require(
            authorizedVoters[msg.sender] == true,
            "You are not authorize to vote"
        );
        _;
    
    }
    modifier onlyOwner(){
        require(msg.sender == owner,"Only owner can call this contract");
        _;
    }
    function vote(uint256 team) public onlyAuthorizedVoter{
        if (team == 1){
            votesForTeamA +=1;
        }else if (team == 2){
            votesForTeamB += 1;
        }else if (team ==3){
            votesForTeamC += 1;
        }
    }
    function addVoter(address voter) public onlyOwner{
        require(msg.sender == owner, "Only owner can add a voter");
        authorizedVoters[voter]=true;
    }
    function getWinner() public view returns (string memory result){
        if (votesForTeamA > votesForTeamB && votesForTeamA > votesForTeamC){
            result = "Team A is the winner!";
        }else if( votesForTeamB > votesForTeamA && votesForTeamB > votesForTeamC){
             result = "Team B is the winner!";
        }else if( votesForTeamC > votesForTeamA && votesForTeamC > votesForTeamB){
            result = "Team C is the winner!";
        }else{
            result = "There is a tie!";
        }
    }
    function getTotalVotes() public view returns (uint256){
         return votesForTeamA + votesForTeamB + votesForTeamC;
    } 

}