//
//  BirthdayCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "BirthdayCell.h"

@implementation BirthdayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    
    
    self.curTimeDate = [NSDate date];
    self.timeFormatter = [[NSDateFormatter alloc] init];
    [_timeFormatter setDateFormat:@"HH:mm a"];
    
    //textFiel
    [self.nameField.layer setCornerRadius:10.0f];
    [self.nameField.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.nameField.layer setBorderWidth:1.0f];
    
    //timebutton
    [self.TimeButton.layer setCornerRadius:10.0f];
    [self.TimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.TimeButton.layer setBorderWidth:1.0f];
    
    //datebutton
    [self.dateButton.layer setCornerRadius:10.0f];
    [self.dateButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.dateButton.layer setBorderWidth:1.0f];
    
    
    //send button
    [self.SendLabel.layer setCornerRadius:10.0f];
    [self.SendLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.SendLabel.layer setBorderWidth:1.0f];
    
    
    [self.viewNew.layer setCornerRadius:10.0f];
    [self.viewNew.layer setShadowOpacity:0.8];
    [self.viewNew.layer setShadowRadius:3.0];
    [self.viewNew.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.viewNew.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.viewNew.layer setBorderWidth:1.0f];

    
    
    self.nameField.delegate = self;
   // self.datePicker.delegate = self;
    [self refreshTitle];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(getDate:)
     
                                                 name:@"getDate" object:nil];
    
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

-(void)getTime:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    
    self.curTime = [userInfo objectForKey:@"time"];
    [self refreshTime];
    
}
-(void)refreshTitle {
    [self.dateButton setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
}

-(void)refreshTime {
    [self.TimeButton setTitle:(self.curTime ? : @"No time selected") forState:UIControlStateNormal];
}

- (IBAction)touchedButton:(id)sender {
   
    if([self.nameField isFirstResponder])
    {
        [self.nameField resignFirstResponder];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DateButtonClicked" object:nil userInfo:nil];
    
    
}


- (IBAction)timeButton:(id)sender
{
    [self.nameField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"TimeButtonClicked" object:nil userInfo:nil];
}

#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self refreshTitle];
   // [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
   // [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dismissKeyboard {
    [self.nameField resignFirstResponder];
}

#pragma mark textview delegate method

- (void)textFieldDidEndEditing:(UITextField *)textField
{
     [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"name"];
}



#pragma end

- (IBAction)sendButton:(id)sender
{
    [self validateBirthdayCell];
    
    if (error != YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"sendClicked" object:nil userInfo:nil];
        self.nameField.text = @"";
        [self.dateButton setTitle:@"Date" forState:UIControlStateNormal];
        [self.TimeButton setTitle:@"Time" forState:UIControlStateNormal];
    }
    error = NO;
}
- (void)validateBirthdayCell {
    
    NSString *errorMessage;
    
    if (!(self.nameField.text.length >= 1)){
        errorMessage = @"Please enter the Details";
        self.nameField.text = @"";
        error = YES;
    }
    else if ([self.dateButton.currentTitle isEqualToString:@"Date"]){
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
