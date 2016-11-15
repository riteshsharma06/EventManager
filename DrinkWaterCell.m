//
//  DrinkWaterCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "DrinkWaterCell.h"

@implementation DrinkWaterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(drinkTitle:)
     
                                                 name:@"SetDrinkTitle" object:nil];
    
    
    
    //frequency button
    [self.btnFrequency.layer setCornerRadius:10.0f];
    [self.btnFrequency.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btnFrequency.layer setBorderWidth:1.0f];
    
  
    
    
    //send button
    [self.sendLabel.layer setCornerRadius:10.0f];
    [self.sendLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.sendLabel.layer setBorderWidth:1.0f];
    
    
    [self.viewNew.layer setCornerRadius:10.0f];
    [self.viewNew.layer setShadowOpacity:0.8];
    [self.viewNew.layer setShadowRadius:3.0];
    [self.viewNew.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.viewNew.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.viewNew.layer setBorderWidth:1.0f];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sendFrequency:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DrinkWater" object:nil userInfo:nil];
}

- (void)drinkTitle:(NSNotification *)note
{
    
    NSDictionary *userInfo = note.userInfo;
    
   NSString * title = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"drink"]];
    
    
    [self.btnFrequency setTitle:(title ? : @"Select Frequency") forState:UIControlStateNormal];
    
}

- (IBAction)sendButton:(id)sender
{
    [self validateDrinkWaterCell];
    
    if (error != YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"sendClicked" object:nil userInfo:nil];
        [self.btnFrequency setTitle:@"Frequency of Reminders ?" forState:UIControlStateNormal];
    }
    error = NO;
}

- (void)validateDrinkWaterCell {
    NSString *errorMessage;
    
    if ([self.btnFrequency.currentTitle isEqualToString:@"Frequency of Reminders ?"]){
        errorMessage = @"Please enter valid Time Frequency.";
        error = YES;
    }
    if (error == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid" message:errorMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
}


@end
