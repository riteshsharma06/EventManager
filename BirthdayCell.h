//
//  BirthdayCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"

@interface BirthdayCell : UITableViewCell<THDatePickerDelegate,UITextFieldDelegate>
@property (nonatomic, retain) NSDate * curDate;

@property (nonatomic, retain) NSDate * curTimeDate;

@property (nonatomic, retain) NSString * curTime;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property (nonatomic, retain) NSDateFormatter * timeFormatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIView *viewNew;

@property (weak, nonatomic) IBOutlet UIButton *TimeButton;
- (IBAction)timeButton:(id)sender;


- (IBAction)sendButton:(id)sender;
@end
