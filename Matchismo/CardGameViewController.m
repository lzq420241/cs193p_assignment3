//
//  CardGameViewController.m
//  Matchismo
//
//  Created by LiZiqiang on 12/20/13.
//  Copyright (c) 2013 LiZiqiang. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGamePlayingHistory.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSInteger selectedMode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (nonatomic) NSInteger previousScore;
@property (nonatomic, strong) NSMutableArray *matchRecord;//of Card
@property (nonatomic, strong) NSMutableArray *infoHistory;//of NSAttributedString
@property (nonatomic, strong) Card *currentOperationCard;
@property (nonatomic) BOOL gamereset;

//Record since game lastest installation

@property (nonatomic, strong) GameResult *roundRecord;

@end

@implementation CardGameViewController

-(GameResult *)roundRecord
{
    if (!_roundRecord) _roundRecord = [[GameResult alloc] init];
    _roundRecord.gameType = self.gameId;
    return _roundRecord;
}


#pragma mark -NSUserDefaults


- (void)viewDidLoad
{
    [super viewDidLoad];
    //call updateUI here will cause crash.
    //[self updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    }
}

- (BOOL)firstPlayofCurrentGame
{
    NSArray *recordArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"APP_Record"];
    if ([recordArray count]) {
        for (id obj in recordArray) {
            if ([obj isKindOfClass:[NSArray class]] && [[obj objectAtIndex:0] isEqualToString:[self gameId]])  return FALSE;
        }
        return TRUE;
    } else {
        return TRUE;
    }
}

#pragma mark -gameLogic

- (Card *)currentOperationCard
{
    if (!_currentOperationCard) _currentOperationCard = [[Card alloc] init];
    return _currentOperationCard;
}


-(NSMutableArray *)infoHistory
{
    if (!_infoHistory) _infoHistory = [[NSMutableArray alloc] init];
    return _infoHistory;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        
        self.previousScore = 0;
        self.game.roundstartTime = [NSDate timeIntervalSinceReferenceDate];
        //self.exround = [[[NSUserDefaults standardUserDefaults] arrayForKey:[self gameId]] mutableCopy];
        //self.appRecord = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"APP_Record"] mutableCopy];
    }
    return _game;
}

//abstract
- (Deck *)createDeck
{
    return nil;
}

//abstract
- (NSInteger)selectedMode
{
    return -1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show history"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGamePlayingHistory class]]) {
            CardGamePlayingHistory *cgph = (CardGamePlayingHistory *)segue.destinationViewController;
            NSMutableAttributedString *playingInfo = [[NSMutableAttributedString alloc] init];
            for (NSAttributedString *str in self.infoHistory) {
                [playingInfo appendAttributedString:str];
            }
            //card game playing history
            cgph.gameHistory = playingInfo;
        }
    }
}

- (NSInteger)GetIndexFromStartTime:(float)startTime
{
    NSArray *tmpArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"APP_Record"];
    for (id obj in tmpArray) {
        if ([obj isKindOfClass:[NSArray class]]) {
            if ([[obj objectAtIndex:0] isEqualToString:[self gameId]] && [[obj objectAtIndex:1] floatValue] == startTime) {
                return [tmpArray indexOfObject:obj];
            }
        }
    }
    return 0;
}

- (IBAction)touchRedealButton:(UIButton *)sender {
    //persistence storage
    
    /*updateUI will check score change,
    score diff equals to zero for two reasons:
     1.card unchosen
     2.game reset (Need the reset info so that 1&2 can be differentiated.)
     */
    self.game = nil;
    self.game.reset = YES;
    self.roundRecord = nil;
    
    //why put updateUI after reset game?
    //records are saved in previous touchCardButton,
    //set the above variable to nil stop the successor updatation, and begins the new round.
    [self updateUI];
    
    
    self.game.reset = NO;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.currentOperationCard = [self.game cardAtIndex:chosenButtonIndex];
    //NSLog(@"get Current Mode: %ld",self.selectedMode);
    [self.game chooseAtIndex:chosenButtonIndex matchMode:self.selectedMode];
    [self updateUI];
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        //NSLog(@"get PlayingCard contents:%@",card.contents);
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    if (!self.game.isReset) {
        [self updateGameInfo];
        //avoid update upon redeal is pressed
        self.roundRecord.score = (int)self.game.score;
    }
    self.previousScore = self.game.score;
}

- (void)updateGameInfo
{
    
    NSInteger scoreChange = self.game.score - self.previousScore;
    NSMutableAttributedString *gameInfo = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    //NSMutableAttributedString *currentGameInfo = [[NSMutableAttributedString alloc] init];
    
    //use the contentForCard interface
    NSMutableAttributedString *cardContent = [[NSMutableAttributedString alloc] initWithAttributedString:[self contentForCard:self.currentOperationCard]];
    [cardContent appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    
    if(scoreChange == 0) {
        //unchoose
        [gameInfo appendAttributedString:cardContent];
        [gameInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@"unchosen, no penalty!"]];
        [self.matchRecord removeObject:self.currentOperationCard];
    } else {
        [self.matchRecord addObject:self.currentOperationCard];
        
        if (scoreChange == -1) {
            //no enough card to perform match operation
            [gameInfo appendAttributedString:cardContent];
            //[gameInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            [gameInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@"selected, cost 1 point!"]];
        } else {
            NSEnumerator *enumerator = [self.matchRecord objectEnumerator];
            id anObject;
            while (anObject = [enumerator nextObject]) [gameInfo appendAttributedString:[self contentForCard:anObject]];
            if(scoreChange < -1) {
                //mismatch
                [gameInfo appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match, %ld point penalty!",(scoreChange - 1) * -1]]];
                [self.matchRecord setArray:@[self.currentOperationCard]];
            } else if (scoreChange > 0) {
                //matched (transferred from case : scoreChange == -1)
                [gameInfo appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"matched for %ld point!",scoreChange + 1]]];
                [self.matchRecord removeAllObjects];
            }
        }
    }
    
    //NSLog(@"get text length before set: %ld",gameInfo.length);
    if (gameInfo.length)
        [self.infoHistory insertObject:gameInfo atIndex:0];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return nil;
}

- (NSAttributedString *)contentForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
