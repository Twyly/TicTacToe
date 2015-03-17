//
//  TJWBoardView.m
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "TJWBoardView.h"

@interface TJWBoardView()

@end


@implementation TJWBoardView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithFrame:frame];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupWithFrame:self.frame];
}

- (void)setupWithFrame:(CGRect)frame
{
    if (frame.size.width != frame.size.height) NSLog(@"Board is not square!");
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Horizontal Lines
    CGFloat height = self.frame.size.height * (1/3.0);
    [path moveToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, height)];
    
    height += self.frame.size.height * (1/3.0);
    [path moveToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, height)];
    
    //Vertical Lines
    CGFloat width = self.frame.size.width * (1/3.0);
    [path moveToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, self.bounds.size.height)];
    
    width += self.frame.size.width * (1/3.0);
    [path moveToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, self.bounds.size.height)];
    
    [[UIColor blueColor] setStroke];
    [path stroke];
    
}


@end
