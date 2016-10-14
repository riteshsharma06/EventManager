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
}

@property(nonatomic,weak)IBOutlet UITableView *table;
@end
