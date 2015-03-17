//
//  TJWTicTacToeGame.h
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJWSquare.h"

@interface TJWTicTacToeGame : NSObject

@property (nonatomic, readonly) TicTacToePlayer currentPlayer;

- (BOOL)checkWinAndTouchSquareAtIndex:(NSInteger)index;
- (TJWSquare *)squareForIndex:(NSInteger)index;


@end
