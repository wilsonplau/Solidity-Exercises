// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */
    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // Check Rows
        for (uint8 row = 0; row < 3; row++) {
            bool isAllSame = true;
            uint8 value = board[row][0];
            for (uint8 col = 0; col < 3; col++) {
                if (board[row][col] != value) isAllSame = false;
            }
            if (isAllSame) return true;
        }

        // Check Columns
        for (uint8 col = 0; col < 3; col++) {
            bool isAllSame = true;
            uint8 value = board[0][col];
            for (uint8 row = 0; row < 3; row++) {
                if (board[row][col] != value) isAllSame = false;
            }
            if (isAllSame) return true;
        }

        // Check Diagonals
        if (board[0][0] == board[1][1] && board[1][1] == board[2][2])
            return true;
        if (board[0][2] == board[1][1] && board[1][1] == board[2][0])
            return true;

        return false;
    }
}
