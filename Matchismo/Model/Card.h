//
//  Card.h
//  Matchismo
//
//  Created by LiZiqiang on 12/21/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;


- (int)match:(NSArray *)otherCards;
@end
