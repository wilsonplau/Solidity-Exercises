// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    uint256 lastBet = 0;
    address highestDepositAddr = address(0);
    uint256 highestDeposit = 0;

    function bet() public payable {
        // your code here
        if (msg.value > highestDeposit) {
            highestDeposit = msg.value;
            highestDepositAddr = msg.sender;
            lastBet = block.timestamp;
        }
    }

    function claimPrize() public {
        require(
            block.timestamp >= lastBet + 1 hours,
            "IdiotBetting: Betting period not over."
        );
        require(
            msg.sender == highestDepositAddr,
            "IdiotBetting: Only winner can claim prize."
        );
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "IdiotBetting: Transfer not successful.");
    }
}
