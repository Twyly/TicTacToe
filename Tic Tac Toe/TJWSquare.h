//
//  TJWSquare.h
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJWSquare : NSObject

enum {
    TicTacToePlayerOne = 1,
    TicTacToePlayerTwo
};

typedef NSUInteger TicTacToePlayer;

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic) TicTacToePlayer owner;


// Designated Initializer
- (instancetype)initWithIndex:(NSInteger)index;

@end
