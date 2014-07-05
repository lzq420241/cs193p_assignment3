//
//  SettingsViewController.m
//  Matchismo
//
//  Created by LiZiqiang on 7/3/14.
//  Copyright (c) 2014 LiZiqiang. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bonus;

@end

@implementation SettingsViewController

- (IBAction)setBonus:(UITextField *)sender {
    if (sender.text) {
        NSLog(@"match_bonus: %@", sender.text);
        [CardMatchingGame setMatch_bonus:[sender.text intValue]];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return pressed:");
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    _bonus.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
