// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public timestamps;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        deposits[msg.sender] = msg.value;
        timestamps[msg.sender] = block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(
            msg.sender == seller,
            "TimelockEscrow: Only seller can withdraw."
        );
        require(
            block.timestamp >= timestamps[buyer] + 3 days,
            "TimelockEscrow: Seller cannot withdraw yet."
        );
        uint256 amount = deposits[buyer];
        require(amount > 0, "TimelockEscrow: No deposit found.");
        require(
            address(this).balance >= amount,
            "TimelockEscrow: Insufficient balance."
        );
        (bool success, ) = payable(seller).call{value: amount}("");
        require(success, "TimelockEscrow: Transfer not successful.");
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(
            block.timestamp < timestamps[msg.sender] + 3 days,
            "TimelockEscrow: Escrow has ended."
        );
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "TimelockEscrow: No deposit found.");
        require(
            address(this).balance >= amount,
            "TimelockEscrow: Insufficient balance."
        );
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "TimelockEscrow: Transfer not successful.");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return deposits[buyer];
    }
}
