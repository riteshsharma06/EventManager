//
//  wakeUpCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wakeUpCell : UITableViewCell
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
- (IBAction)sendButton:(id)sender;
@property (nonatomic, retain) NSDate * curTimeDate;
@property (nonatomic, retain) NSString * curTime;
@property (nonatomic, retain) NSDateFormatter * timeFormatter;
@property (weak, nonatomic) IBOutlet UIButton *TimeButton;
- (IBAction)timeButton:(id)sender;
@end
