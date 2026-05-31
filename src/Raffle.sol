//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title a sample Raffle contract
 * @author Henri Debaene
 * @notice A simple raffle contract where users can enter by sending Ether, and a winner is randomly selected.
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle {
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee){
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public {}

    function pickWinner() public {}

    /** Getter Functions */
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }
}

