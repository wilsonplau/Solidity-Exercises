// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Fibonacci {
    /*
        This exercise assumes you understand what Fibonacci sequence is.
        1. Function `fibonacci` takes a uint256 as argument and returns nth fibonacci number.
        
        Fibonacci sequence are 0,1,1,2,3,5,8,13,....
        
        calling fibonacci(6) would return 8, because the 6th Fibonacci number is 8.
    */

    function fibonacci(uint256 _position) public view returns (uint256) {
        uint256[3] memory dp = [uint256(0), 1, 1];
        if (_position < 3) return dp[_position];
        for (uint256 i = 3; i <= _position; i++) {
            dp[i % 3] = dp[(i - 1) % 3] + dp[(i - 2) % 3];
        }
        return dp[_position % 3];
    }
}
