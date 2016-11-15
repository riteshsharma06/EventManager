//
//  ReminderListCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "ReminderListCell.h"
#import "remindersDataCell.h"


@implementation ReminderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    reminderNIB = [UINib nibWithNibName:@"remindersDataCell" bundle:nil];
    [self.table registerNib:reminderNIB forCellReuseIdentifier:@"idReminderData"];
    
    
        
    
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    arrLogo = [[NSMutableArray alloc] initWithObjects:@"call.png",@"birthday.png",@"meeting.png",@"wakeup.png",@"drinkwater.png",@"medicine.png",@"todolist.png", nil];
    
    arrList = [[NSMutableArray alloc] initWithObjects:@"Call",
               @"Birthday",
               @"Meeting",
               @"Wake Up",
               @"Drink Water",
               @"Take Medicine",
               @"To do List", nil];
    
    
   
    
    // border radius
    [self.myView.layer setCornerRadius:30.0f];
    [self.myView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.myView.layer setShadowOpacity:0.8];
    [self.myView.layer setShadowRadius:3.0];
    [self.myView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.myView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.myView.layer setBorderWidth:1.0f];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    remindersDataCell *cell = [self.table dequeueReusableCellWithIdentifier:@"idReminderData"];
    
        cell.Name.text = [NSString stringWithFormat:@"%@",[arrList objectAtIndex:indexPath.row]];
    
    
        cell.ImgLogo.image = [UIImage imageNamed:[arrLogo objectAtIndex:indexPath.row]];
//    [cell.contentView.layer setBorderColor:[UIColor blueColor].CGColor];
//    [cell.contentView.layer setBorderWidth:1.0f];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[arrList objectAtIndex:indexPath.row] forKey:@"Reminder"];
    
    //[userInfo setValue:strTit forKey:@"Title"];
    
     [[NSNotificationCenter defaultCenter] postNotificationName: @"ReminderClicked" object:nil userInfo:userInfo];
}




@end
