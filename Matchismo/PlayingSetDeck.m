//
//  SetDeck.m
//  Matchismo
//
//  Created by LiZiqiang on 3/30/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "PlayingSetDeck.h"

@implementation PlayingSetDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSUInteger number = 1; number <= 3; number++) {
            for (NSUInteger symbol = 1; symbol <= 3; symbol++) {
                for (NSUInteger shading = 1; shading <= 3; shading++) {
                    for (NSUInteger color = 1; color <= 3; color++){
                        PlayingSet *card = [[PlayingSet alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }//color
                }//shading
            }//symbol
        }//number
    }//if
    return self;
}

@end
