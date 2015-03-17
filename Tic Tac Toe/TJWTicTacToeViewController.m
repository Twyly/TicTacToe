//
//  TJWTicTacToeViewController.m
//  Tic-Tac-Toe
//
//  Created by Teddy Wyly on 12/17/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "TJWTicTacToeViewController.h"
#import "TJWTicTacToeGame+TJWGameAI.h"
#import "TJWBoardView.h"
#import <objc/objc-runtime.h>

NSString *const kButtonToSquareAssociation = @"ButtonToSquareAssociation";

@interface TJWTicTacToeViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) TJWTicTacToeGame *game;

// Each button has an associated tag (from 0-8) set in IB to denote it's position in space as
// outlet connections do not preserve index
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *squareButtons;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet TJWBoardView *boardView;

@property (nonatomic) NSString *buttonToSquareSelectorKey;

@end

@implementation TJWTicTacToeViewController

# pragma mark - UI

- (void)updateDisplay
{
    for (UIButton *button in self.squareButtons) {
        [self updateButton:button];
    }
    [self updatePlayerLabel];
}

- (void)updatePlayerLabel
{
    NSString *playerString = (self.game.currentPlayer == TicTacToePlayerOne) ? @"Player One's Move" : @"Player Two's Move";
    self.playerLabel.text = playerString;
}

- (void)displayWinAlertView
{
    NSString *playerName = (self.game.currentPlayer == TicTacToePlayerOne) ? @"Player One" : @"Player Two";
    UIAlertView *winAlertView = [[UIAlertView alloc] initWithTitle:@"Winner!" message:[NSString stringWithFormat:@"%@ Wins The Game!!!", playerName] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [winAlertView show];
}

- (void)updateButton:(UIButton *)button
{
    // Mapping between model and UI
    
    TJWSquare *square;
    
    if (self.game) {
        square = objc_getAssociatedObject(button, @selector(buttonToSquareSelectorKey));
    }
    
    if (square.owner) {
        button.selected = YES;
        [button setTitle:((square.owner == TicTacToePlayerOne) ? @"X" : @"O") forState:UIControlStateSelected | UIControlStateDisabled];
        button.enabled = NO;
    } else {
        [button setTitle:@"" forState:UIControlStateSelected | UIControlStateDisabled];
        button.selected = NO;
        button.enabled = YES;
    }
}

- (void)associateButtonsToView
{
    int buttonIndex = 0;
    for (UIButton *button in self.squareButtons) {
        TJWSquare *square = [self.game squareForIndex:buttonIndex];
        objc_setAssociatedObject(button, @selector(buttonToSquareSelectorKey), square, OBJC_ASSOCIATION_ASSIGN);
        buttonIndex++;
    }
}


# pragma mark - Lazy Instantiation

- (TJWTicTacToeGame *)game
{
    if (!_game) {
        _game = [[TJWTicTacToeGame alloc] init];
        [self associateButtonsToView];
    }
    return _game;
}

# pragma mark - IBAction

- (IBAction)squareButtonPressed:(UIButton *)sender
{
    if ([self.game checkWinAndTouchSquareAtIndex:sender.tag]) [self displayWinAlertView];
    [self updateButton:sender];
    [self updatePlayerLabel];
}

- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender
{
    self.game = nil;
    [self updateDisplay];
}

- (IBAction)autoMoveButtonPressed:(UIButton *)sender
{
    NSInteger suggestedIndex = [self.game suggestedIndexToPlay];
    
    // Find Correlating Button
    UIButton *suggestedButton;
    for (UIButton *button in self.squareButtons) {
        if (button.tag == suggestedIndex) {
            suggestedButton = button;
        }
    }
    
    if (suggestedButton) {
        [self squareButtonPressed:suggestedButton];
    } else {
        // Do something here, either display an Alert Or Play a New Game
    }
}


# pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self clearButtonPressed:nil];
    }
}


@end
