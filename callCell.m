//
//  callCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "callCell.h"

@implementation callCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    self.nameField.delegate = self;
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    [self.viewNew.layer setBorderColor:[UIColor redColor].CGColor];
    [self.viewNew.layer setBorderWidth:1.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(getDate:)
     
                                                 name:@"getDate" object:nil];
    
    
    self.curTimeDate = [NSDate date];
    self.timeFormatter = [[NSDateFormatter alloc] init];
    [_timeFormatter setDateFormat:@"HH:mm a"];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(getTime:)
     
                                                 name:@"getTime" object:nil];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self addGestureRecognizer:tap];

    
    // Initialization code
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)sendButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"sendClicked" object:nil userInfo:nil];
}

#pragma mark textview delegate method

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"name"];
}



#pragma end

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
    [self.nameField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"TimeButtonClicked" object:nil userInfo:nil];
}
#pragma mark end

#pragma mark Dismiss Keyboard
-(void)dismissKeyboard {
    [self.nameField resignFirstResponder];
}
#pragma mark

@end
