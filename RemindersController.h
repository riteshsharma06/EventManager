//
//  RemindersController.h
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"
@interface RemindersController : UITableViewController<THDatePickerDelegate>


@property(nonatomic,weak)IBOutlet UITableView *tableV;

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
