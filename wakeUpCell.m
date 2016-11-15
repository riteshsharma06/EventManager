//
//  wakeUpCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "wakeUpCell.h"

@implementation wakeUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(getDate:)
     
                                                 name:@"getDate" object:nil];
    
    
    self.curTimeDate = [NSDate date];
    self.timeFormatter = [[NSDateFormatter alloc] init];
    [_timeFormatter setDateFormat:@"HH:mm a"];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(getTime:)
     
                                                 name:@"getTime" object:nil];
    
    
    
   
    
    //timebutton
    [self.TimeButton.layer setCornerRadius:10.0f];
    [self.TimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.TimeButton.layer setBorderWidth:1.0f];
    
    //datebutton
    [self.dateButton.layer setCornerRadius:10.0f];
    [self.dateButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.dateButton.layer setBorderWidth:1.0f];
    
    
    //send button
    [self.sendLable.layer setCornerRadius:10.0f];
    [self.sendLable.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.sendLable.layer setBorderWidth:1.0f];
    
    
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

-(void)getDate:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    
    self.curDate = [userInfo objectForKey:@"date"];
    [self refreshTitle];
    
}
-(void)refreshTitle {
    [self.dateButton setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
}
- (IBAction)touchedButton:(id)sender {
    
 
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DateButtonClicked" object:nil userInfo:nil];
    
    
}

#pragma mark time method
-(void)getTime:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    
    self.curTime = [userInfo objectForKey:@"time"];
    [self refreshTime];
    
}
-(void)refreshTime {
    [self.TimeButton setTitle:(self.curTime ? : @"No time selected") forState:UIControlStateNormal];
}
- (IBAction)timeButton:(id)sender
{
   // [self.nameField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"TimeButtonClicked" object:nil userInfo:nil];
}
#pragma mark end

- (IBAction)sendButton:(id)sender
{
    [self validateWakeUpCell];
    if (error != YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"sendClicked" object:nil userInfo:nil];
        [self.dateButton setTitle:@"Date" forState:UIControlStateNormal];
        [self.TimeButton setTitle:@"Time" forState:UIControlStateNormal];
    }
    error = NO;
}
- (void)validateWakeUpCell {
    NSString *errorMessage;
    
    if ([self.dateButton.currentTitle isEqualToString:@"Date"]){
        errorMessage = @"Please enter valid Date";
        error = YES;
        
    }
    else if ([self.TimeButton.currentTitle isEqualToString:@"Time"]){
        errorMessage = @"Please enter valid Time";
        error = YES;
    }
    if (error == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid" message:errorMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
