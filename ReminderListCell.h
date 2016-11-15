//
//  ReminderListCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrList;
    UINib *reminderNIB;
    NSMutableArray *arrLogo;
}
@property (weak, nonatomic) IBOutlet UIView *myView;

@property(nonatomic,weak)IBOutlet UITableView *table;
@end
