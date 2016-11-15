//
//  RMViewController.h
//  Reminders
//
//  Created by SoftBunch  on 10/17/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMViewController : UIViewController
@property(nonatomic,weak)IBOutlet UITableView *tableV;

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
