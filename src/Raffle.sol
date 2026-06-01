
// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions


//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/**
 * @title a sample Raffle contract
 * @author Henri Debaene
 * @notice A simple raffle contract where users can enter by sending Ether, and a winner is randomly selected.
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle {
    /* errors */
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /* events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee){
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable{
        //require(msg.value >= i_entranceFee, "Not enough ETH send!");
        //require(msg.value >= i_entranceFee, SendMoreToEnterRaffle());
        if(msg.value < i_entranceFee){
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
        
    }

    function pickWinner() public {}

    /*Getter Functions */
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }
}

