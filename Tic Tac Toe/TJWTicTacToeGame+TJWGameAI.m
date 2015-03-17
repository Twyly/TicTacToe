//
//  TJWTicTacToeGame+TJWGameAI.m
//  Tic Tac Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "TJWTicTacToeGame+TJWGameAI.h"

@implementation TJWTicTacToeGame (TJWGameAI)

# pragma mark - AI

- (NSInteger)suggestedIndexToPlay
{
    NSInteger index;
    
    // Try to Find A Win
    index = [self suggestedIndexToPlayForPlayer:self.currentPlayer];
    if (index < 0) {
        // Try to Find A Block
        TicTacToePlayer otherPlayer = (self.currentPlayer == TicTacToePlayerOne) ? TicTacToePlayerTwo : TicTacToePlayerOne;
        index = [self suggestedIndexToPlayForPlayer:otherPlayer];
        if (index < 0) {
            // Just Go Random
            index = [self randomIndexFromAvailableSquares];
        }
    }
    return index;
}

// Returns -1 if no immediate "best play," that is a win or a block
- (NSInteger)suggestedIndexToPlayForPlayer:(TicTacToePlayer)player
{
    
    // Look for Row Win
    for (NSInteger row = 0; row < 3; row++) {
        NSInteger matchCount = 0;
        NSInteger emptySquareIndex = -1;
        for (NSInteger squareIndex = 3*row; squareIndex < 3*row+3; squareIndex++) {
            TJWSquare *square = [self squareForIndex:squareIndex];
            if (square.owner == player) matchCount++;
            else if (!square.owner) emptySquareIndex = squareIndex;
            if (matchCount == 2 && (emptySquareIndex >= 0)) {
                return emptySquareIndex;
            }
        }
    }
    
    // Look For Column Win
    for (NSInteger column = 0; column < 3; column++) {
        NSInteger matchCount = 0;
        NSInteger emptySquareIndex = -1;
        for (NSInteger squareIndex = column; squareIndex < 9; squareIndex+=3) {
            TJWSquare *square = [self squareForIndex:squareIndex];
            if (square.owner == player) matchCount++;
            else if (!square.owner) emptySquareIndex = squareIndex;
            if (matchCount == 2 && (emptySquareIndex >= 0)) {
                return emptySquareIndex;
            }
        }
    }
    
    // Check For Diagonals Win
    NSInteger forwardDiagonalCount = 0;
    NSInteger emptySquareIndexInForwardDiagonal = -1;
    for (NSInteger squareIndex = 0; squareIndex < 9; squareIndex+=4) {
        TJWSquare *square = [self squareForIndex:squareIndex];
        if (square.owner == player) forwardDiagonalCount++;
        else if (!square.owner) emptySquareIndexInForwardDiagonal = squareIndex;
        if (forwardDiagonalCount == 2 && (emptySquareIndexInForwardDiagonal >= 0)) {
            return emptySquareIndexInForwardDiagonal;
        }
    }
    
    NSInteger backwardDiagonalCount = 0;
    NSInteger emptySquareIndexInBackwardDiagonal = -1;
    for (NSInteger squareIndex = 2; squareIndex < 7; squareIndex+=2) {
        TJWSquare *square= [self squareForIndex:squareIndex];
        if (square.owner == player) backwardDiagonalCount++;
        else if (!square.owner) emptySquareIndexInBackwardDiagonal = squareIndex;
        if (backwardDiagonalCount == 2 && (emptySquareIndexInForwardDiagonal >= 0)) {
            return emptySquareIndexInBackwardDiagonal;
        }
    }
    
    return -1;
}

- (NSInteger)randomIndexFromAvailableSquares
{
    // Create an array of squares with no owner
    NSMutableArray *availableSquares = [NSMutableArray array];
    for (NSInteger index = 0; index < 9; index++) {
        TJWSquare *square = [self squareForIndex:index];
        if (!square.owner) [availableSquares addObject:square];
    }
    
    // Return a random One
    NSInteger count = [availableSquares count];
    if (count) {
        NSInteger randomindex = arc4random() % count;
        TJWSquare *randomSquare = availableSquares[randomindex];
        return randomSquare.index;
    }

    return -1;
 
}

@end
