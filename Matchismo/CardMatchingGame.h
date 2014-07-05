//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by LiZiqiang on 12/24/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

enum {enu_startTime, enu_Duration, enu_Score, enu_Both};

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void)chooseAtIndex:(NSUInteger)index matchMode:(NSInteger)mode;
- (void)chooseAtIndex:(NSUInteger)index;


- (Card *)cardAtIndex:(NSUInteger)index;
+ (void)setMatch_bonus:(int)bonus;

@property (nonatomic, readonly)NSInteger score;

@property (nonatomic, getter = isReset)BOOL reset;
@property (nonatomic)float roundstartTime;

@end
NSInteger compareroundRecord(id round1, id round2, void *ctx);


