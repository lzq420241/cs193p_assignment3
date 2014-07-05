//
//  PlayingCard.m
//  Matchismo
//
//  Created by LiZiqiang on 12/23/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter AND getter

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSMutableArray *cards = [otherCards mutableCopy];
    PlayingCard *comparedCard = self;
    
    while ([cards count] > 0) {
        for (PlayingCard *otherCard in cards) {
            if (otherCard.rank == comparedCard.rank) {
                score += 4;
            } else if ([otherCard.suit isEqualToString:comparedCard.suit]){
                score += 1;
            }
        }
        comparedCard = [cards lastObject];
        [cards removeLastObject];
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    //NSLog(@"get PlayingCard contents:%@",[rankStrings[self.rank] stringByAppendingString:self.suit]);
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
