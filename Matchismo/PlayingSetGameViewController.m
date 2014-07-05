//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by LiZiqiang on 3/30/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "PlayingSetGameViewController.h"
#import "PlayingSetDeck.h"

@interface PlayingSetGameViewController ()
@end

@implementation PlayingSetGameViewController

-(Deck *)createDeck
{
    self.gameId = @"SET";
    return [[PlayingSetDeck alloc] init];
}

//for SET! game, Poke always face up.
- (NSAttributedString *)titleForCard:(Card *)card
{
    return [self contentForCard:card];
}

- (NSAttributedString *)contentForCard:(Card *)card
{
    PlayingSet *setCard = (PlayingSet *)card;
    
    NSString *sym = [PlayingSet validSymbols][setCard.symbol];
    NSMutableString *plainContent = [[NSMutableString alloc] init];
    
    NSUInteger number = setCard.number;
    
    while (number--) {
        [plainContent appendString:sym];
    }
    
    UIColor *color = [PlayingSet validColors][setCard.color];
    CGFloat alpha = [[PlayingSet validShadings][setCard.shading] floatValue];
    color = [color colorWithAlphaComponent:alpha];
                      
    NSAttributedString *cardContent = [[NSAttributedString alloc]
                                       initWithString:plainContent
                                           attributes:@{NSForegroundColorAttributeName:color}];
    //return card.isChosen ? cardContent : nil;
    //cost me at least 4 hours for finding reasons why card can not begin with face up
    return cardContent;
}

- (NSInteger)selectedMode
{
    return 3;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"setcardchosen" : @"cardfront"];
}
@end
