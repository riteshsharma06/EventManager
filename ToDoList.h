//
//  ToDoList.h
//  Reminders
//
//  Created by SoftBunch  on 10/13/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoList : UITableViewCell<UITextFieldDelegate> {
    BOOL error;
}
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (nonatomic, retain) NSDate * curTimeDate;
@property (nonatomic, retain) NSString * curTime;
@property (nonatomic, retain) NSDateFormatter * timeFormatter;
@property (weak, nonatomic) IBOutlet UIButton *TimeButton;

@property (weak, nonatomic) IBOutlet UIView *viewNew;
- (IBAction)timeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendLabel;
@end
