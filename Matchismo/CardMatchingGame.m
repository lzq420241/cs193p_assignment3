//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by LiZiqiang on 12/24/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards;//of Card
@property (nonatomic, strong)NSMutableArray *matchSet;//of Card
//@property (nonatomic, strong) NSMutableArray *exround;

@end

@implementation CardMatchingGame


//must be C-style func 
NSInteger compareroundRecord(id round1, id round2, void *ctx)
{
    NSInteger *idx = ctx;
    if ([round1 isKindOfClass:[NSArray class]] && [round2 isKindOfClass:[NSArray class]]) {
        id v1 = [round1 objectAtIndex:*idx];
        id v2 = [round2 objectAtIndex:*idx];
        return [v1 compare:v2];
    }
    return NSOrderedSame;
}


#pragma mark - cardModel

+ (void)setMatch_bonus:(int)bonus
{
    MATCH_BONUS = bonus;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)matchSet
{
    if (!_matchSet) _matchSet = [[NSMutableArray alloc] init];
    return _matchSet;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        self.score = 0;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (void)chooseAtIndex:(NSUInteger)index
{
    [self chooseAtIndex:index matchMode:2];
}

- (void)chooseAtIndex:(NSUInteger)index matchMode:(NSInteger)mode
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            [self.matchSet removeObject:card];
            card.chosen = NO;
        } else {
            //match against other chosen card in matchSet
            if ([self.matchSet count] == mode - 1) {
                int matchScore = [card match:self.matchSet];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in self.matchSet) {
                        otherCard.matched = YES;
                    }
                    [self.matchSet removeAllObjects];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in self.matchSet) {
                        otherCard.chosen = NO;
                    }
                    [self.matchSet setArray:@[card]];
                }
            } else if ([self.matchSet count] < mode - 1){
                [self.matchSet addObject:card];
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}


@end
