//
//  meetingCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meetingCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *venueField;
@property (nonatomic, retain) NSDate * curTimeDate;
@property (nonatomic, retain) NSString * curTime;
@property (nonatomic, retain) NSDateFormatter * timeFormatter;
@property (weak, nonatomic) IBOutlet UIButton *TimeButton;
@end
