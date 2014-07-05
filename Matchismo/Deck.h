//
//  Deck.h
//  Matchismo
//
//  Created by LiZiqiang on 12/23/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
