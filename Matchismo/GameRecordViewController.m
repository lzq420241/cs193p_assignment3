//
//  GameRecordViewController.m
//  Matchismo
//
//  Created by LiZiqiang on 6/4/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "GameRecordViewController.h"
#import "GameResult.h"

@interface GameRecordViewController ()
                
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sortByEndtime;
@property (weak, nonatomic) IBOutlet UIButton *sortByDuration;
@property (weak, nonatomic) IBOutlet UIButton *sortByScore;
@property (strong, nonatomic) NSArray *recordArray;
@end

@implementation GameRecordViewController

- (NSArray *)recordArray
{
    _recordArray = [GameResult allGameResults];
    return _recordArray;
}

/********************************************************
 *
 * Maybe better to employ
 * NSMutableAttributedString method
 * - (void)addAttributes:(NSDictionary *)attributes range:(NSRange)aRange
 *
 ********************************************************/


- (NSAttributedString *)roundRecordToAttributedString:(GameResult *)roundRec
{
    NSString *gameName = roundRec.gameType;
    //NSDate *tmpTime = [NSDate dateWithTimeIntervalSinceReferenceDate:[[roundRec objectAtIndex:1] floatValue]];
    //NSAttributedString *startTime = [[NSAttributedString alloc] initWithString:[roundRec.start descriptionWithLocale:[NSLocale currentLocale]]];
    NSAttributedString *endTime = [[NSAttributedString alloc] initWithString:[NSDateFormatter localizedStringFromDate:roundRec.end
                                                                                                              dateStyle:NSDateFormatterShortStyle
                                                                                                              timeStyle:NSDateFormatterShortStyle]];
    //startTime = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%f",[[roundRec objectAtIndex:1] floatValue]]];
    
    NSString *rndDuration = [NSString stringWithFormat:@"%.1f",roundRec.duration];
    NSString *rndScore = [NSString stringWithFormat:@" %ld",(long)roundRec.score];
    //NSInteger rndField = roundRec.field;
    
    
    NSAttributedString *roundDuration, *roundScore;
    NSMutableAttributedString *roundDiscription = [[NSMutableAttributedString alloc] initWithString:@""];
    [roundDiscription appendAttributedString:endTime];
    
    NSAttributedString *roundGame = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@", played %@ for ",gameName]];
    [roundDiscription appendAttributedString:roundGame];
    
    roundDuration = [[NSAttributedString alloc] initWithString:rndDuration];
    [roundDiscription appendAttributedString:roundDuration];
    [roundDiscription appendAttributedString:[[NSAttributedString alloc] initWithString:@" s, got "]];
    
    roundScore = [[NSAttributedString alloc] initWithString:rndScore];
    [roundDiscription appendAttributedString:roundScore];
    [roundDiscription appendAttributedString:[[NSAttributedString alloc] initWithString:@" p.\n"]];
    
    if ([roundRec.start isEqualToDate:[self shortestDuration:gameName]]) {
        [roundDiscription addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [roundDiscription length])];
    }
    
    if ([roundRec.start isEqualToDate:[self highestScore:gameName]]) {
        [roundDiscription addAttribute:NSStrokeWidthAttributeName value:@-3 range:NSMakeRange(0, [roundDiscription length])];
    }
    return roundDiscription;
}

- (NSDate *)shortestDuration:(NSString *)gameType
{
    NSMutableArray *tmp_array = [[NSMutableArray alloc] init];
    for (GameResult *gr in self.recordArray)
        if ([gameType isEqualToString:gr.gameType])
            [tmp_array addObject:gr];
    GameResult *ex_gr = [[tmp_array sortedArrayUsingSelector:@selector(compareDuration:)] firstObject];
    return ex_gr.start;
}

- (NSDate *)highestScore:(NSString *)gameType
{
    NSMutableArray *tmp_array = [[NSMutableArray alloc] init];
    for (GameResult *gr in self.recordArray)
        if ([gameType isEqualToString:gr.gameType])
            [tmp_array addObject:gr];
    GameResult *ex_gr = [[tmp_array sortedArrayUsingSelector:@selector(compareScore:)] lastObject];
    return ex_gr.start;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textView.attributedText = [self getTextViewContent:[self recordArray]];
}

- (NSMutableAttributedString *)getTextViewContent:(NSArray *)sortedArray
{
    NSMutableAttributedString *roundInfo = [[NSMutableAttributedString alloc] init];
    for (id obj in sortedArray) {
        if ([obj isKindOfClass:[GameResult class]]) {
            [roundInfo appendAttributedString:[self roundRecordToAttributedString:obj]];
        }
    }
    return roundInfo;
}

- (IBAction)sortByEndtime:(UIButton *)sender {
    NSArray *tempArray = [self.recordArray sortedArrayUsingSelector:@selector(compareLastPlayed:)];
    self.textView.attributedText = [self getTextViewContent:tempArray];
}
- (IBAction)sortByDuration:(UIButton *)sender {
    NSArray *tempArray = [self.recordArray sortedArrayUsingSelector:@selector(compareDuration:)];
    self.textView.attributedText = [self getTextViewContent:tempArray];
}
- (IBAction)sortByScore:(UIButton *)sender {
    NSArray *tempArray = [self.recordArray sortedArrayUsingSelector:@selector(compareScore:)];
    self.textView.attributedText = [self getTextViewContent:tempArray];
}

/*- (NSAttributedString *)arrayFormating:(NSArray *)recordArray
{
    NSInteger arrayItemNumber = [recordArray count];
	if (arrayItemNumber) {
        if (arrayItemNumber > 1) {
            NSArray *tmpArray = [recordArray subarrayWithRange:NSMakeRange(1, arrayItemNumber -1)];
            
        }
    }
}*/

@end
