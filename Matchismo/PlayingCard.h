//
//  PlayingCard.h
//  Matchismo
//
//  Created by LiZiqiang on 12/23/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
