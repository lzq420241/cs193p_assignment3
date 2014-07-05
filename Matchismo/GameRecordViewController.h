//
//  GameRecordViewController.h
//  Matchismo
//
//  Created by LiZiqiang on 6/4/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"


@interface GameRecordViewController : UIViewController
@property (nonatomic,strong) NSAttributedString *gameRecord;
@property (nonatomic) NSInteger index;
@end
