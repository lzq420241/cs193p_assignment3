//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by LiZiqiang on 3/30/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    self.gameId = @"CARD";
    return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.isChosen ? [self contentForCard:card] : nil;
}

- (NSAttributedString *)contentForCard:(Card *)card
{
    return [[NSAttributedString alloc] initWithString:card.contents];
}

- (NSInteger)selectedMode
{
    return 3;
}
@end
