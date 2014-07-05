//
//  CardGameViewController.h
//  Matchismo
//
//  Created by LiZiqiang on 12/20/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//  abstract class. Must implement createDck;

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController : UIViewController
- (Deck *)createDeck;
- (NSAttributedString *)titleForCard:(Card *)card;
- (NSAttributedString *)contentForCard:(Card *)card;
- (CardMatchingGame *)game;
- (NSInteger)selectedMode;

@property (strong, nonatomic) NSString *gameId;
//- (void)updateUI;

@end


/*
 can not use struct here, because its wrapper
 NSValue isn't an element of a property list.
 
 typedef struct{
    float duration;
    NSInteger score;
    NSUInteger dur_idx;
    NSUInteger sco_idx;
    
}extremRound;
extremRound exround;*/
