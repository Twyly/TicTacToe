//
//  TJWTicTacToeGame.m
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "TJWTicTacToeGame.h"

@interface TJWTicTacToeGame()

@property (strong, nonatomic) NSArray *squares;
@property (nonatomic, readwrite) TicTacToePlayer currentPlayer;
@property (nonatomic, readonly) BOOL isWinner;

@end

@implementation TJWTicTacToeGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Setup Game with 9 Tic Tac Toe Squares
        NSMutableArray *mutableSquares = [NSMutableArray array];
        for (NSInteger index = 0; index < 9; index++) {
            TJWSquare *square = [[TJWSquare alloc] initWithIndex:index];
            [mutableSquares addObject:square];
        }
        _squares = [NSArray arrayWithArray:mutableSquares];
        _currentPlayer = TicTacToePlayerOne;
    }
    
    return self;
}


- (BOOL)checkWinAndTouchSquareAtIndex:(NSInteger)index
{
    TJWSquare *square = self.squares[index];
    square.owner = self.currentPlayer;
    
    if (self.isWinner) return YES;
    
    // Change Player
    self.currentPlayer = (self.currentPlayer == TicTacToePlayerOne) ? TicTacToePlayerTwo : TicTacToePlayerOne;
    
    return NO;
    
}

- (TJWSquare *)squareForIndex:(NSInteger)index
{
    return self.squares[index];
}

- (BOOL)isWinner
{
    TicTacToePlayer player = self.currentPlayer;
    
    // Check Rows for Win
    for (NSInteger row = 0; row < 3; row++) {
        NSInteger matchCount = 0;
        for (NSInteger squareIndex = 3*row; squareIndex < 3*row+3; squareIndex++) {
            TJWSquare *square = self.squares[squareIndex];
            if (square.owner == player) matchCount++;
            if (matchCount == 3) {
                NSLog(@"Row Win");
                return YES;
            }
        }
    }
    
    
    // Check Columns for Win
    for (NSInteger column = 0; column < 3; column++) {
        NSInteger matchCount = 0;
        for (NSInteger squareIndex = column; squareIndex < 9; squareIndex+=3) {
            TJWSquare *square = self.squares[squareIndex];
            if (square.owner == player) matchCount++;
            if (matchCount == 3) {
                NSLog(@"Column Win");
                return YES;
            }
        }
    }
    
    // Check Diagonals for Win
    NSInteger forwardDiagonalCount = 0;
    for (NSInteger squareIndex = 0; squareIndex < 9; squareIndex+=4) {
        TJWSquare *square = self.squares[squareIndex];
        if (square.owner == player) forwardDiagonalCount++;
        if (forwardDiagonalCount == 3) {
            NSLog(@"Forward Diagonal Win");
            return YES;
        }
    }
    
    NSInteger backwardDiagonalCount = 0;
    for (NSInteger squareIndex = 2; squareIndex < 7; squareIndex+=2) {
        TJWSquare *square= self.squares[squareIndex];
        if (square.owner == player) backwardDiagonalCount++;
        if (backwardDiagonalCount == 3) {
            NSLog(@"Backward Diagonal Win");
            return YES;
        }
    }
    
    return NO;
}



@end
