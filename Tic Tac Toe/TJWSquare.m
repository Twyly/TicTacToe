//
//  TJWSquare.m
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "TJWSquare.h"

@implementation TJWSquare


- (instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (instancetype)init
{
    // Maybe throw an exception
    return nil;
}


@end
