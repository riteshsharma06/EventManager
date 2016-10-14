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
    [[NSNotificationCenter defaultCenter] postNotificationName: @"sendClicked" object:nil userInfo:nil];
}

@end
