//
//  CardGamePlayingHistory.m
//  Matchismo
//
//  Created by LiZiqiang on 4/5/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "CardGamePlayingHistory.h"

@interface CardGamePlayingHistory ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CardGamePlayingHistory

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textView.attributedText = _gameHistory;
}


@end
