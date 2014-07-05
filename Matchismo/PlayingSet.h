//
//  SetCard.h
//  Matchismo
//
//  Created by LiZiqiang on 3/30/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "Card.h"

@interface PlayingSet : Card

/*
 test where do I changed this properties
@property (readonly,nonatomic) NSUInteger number;
@property (readonly,nonatomic) NSUInteger symbol;
@property (readonly,nonatomic) NSUInteger shading;
@property (readonly,nonatomic) NSUInteger color;
*/

@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
