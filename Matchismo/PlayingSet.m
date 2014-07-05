//
//  SetCard.m
//  Matchismo
//
//  Created by LiZiqiang on 3/30/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "PlayingSet.h"

@implementation PlayingSet

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSMutableArray *cards = [otherCards mutableCopy];
    PlayingSet *comparedCard = self;
    
    if ([cards count] == 2) {
        NSUInteger number = comparedCard.number;
        NSUInteger symbol = comparedCard.symbol;
        NSUInteger shading = comparedCard.shading;
        NSUInteger color = comparedCard.color;
        
        //common ways to use id type with dot property
        for (PlayingSet *otherCard in cards){
            number += otherCard.number;
            symbol += otherCard.symbol;
            shading += otherCard.shading;
            color += otherCard.color;
        }
        
        if ((number == 6 || number % 3 == 0) && \
            (symbol == 6 || symbol % 3 == 0) && \
            (shading == 6 || shading % 3 == 0) && \
            (color == 6 || color % 3 == 0))
        {
            score = 1;
        }
    }
    
    return score;
}

+ (NSArray *)validSymbols
{
    return @[@"?",@"▲",@"◼︎",@"•"];
}

+ (NSArray *)validShadings
{
    return @[@"0.0",@"0.3",@"0.6",@"0.9"];
}

+ (NSArray *)validColors
{
    return @[[UIColor blackColor],[UIColor greenColor],[UIColor redColor],[UIColor orangeColor]];
}

- (NSString *)contents
{
    return nil;
}

@end
