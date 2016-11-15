//
//  RMViewController.m
//  Reminders
//
//  Created by SoftBunch  on 10/17/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "RMViewController.h"

#import "ReminderListCell.h"

#import "BirthdayCell.h"

#import "callCell.h"

#import "messageCell.h"

#import "wakeUpCell.h"
#import "meetingCell.h"
#import "takeMedicineCell.h"
#import "DrinkWaterCell.h"
#import "ToDoList.h"

#import "FlatDatePicker.h"


@interface RMViewController ()<UIActionSheetDelegate,FlatDatePickerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UINib *reminderNIB ;
    
    UINib *birthdayNIB ;
    
    UINib *callNIB;
    
    UINib *meetingNIB;
    
    UINib *WakeUpNIB;
    
    UINib *drinkWaterNIB;
    
    
    UINib *messageNIB;
    
    UINib *medicineNIB;
    
    UINib *toDoNIB;
    
    int rowsNumbers;
    
    NSString *name;
    
    
    BOOL isSendClicked;
    
    
    
    NSMutableArray *arrMessageData;
    
    NSString *strMessage;
    
    BOOL isnotValid;

}
@property (nonatomic, strong) FlatDatePicker *flatDatePicker;
@end

@implementation RMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isnotValid = NO;
    
    arrMessageData = [[NSMutableArray alloc] init];
    [arrMessageData addObject:@"Welcome to Reminders"];
    [arrMessageData addObject:@"Feel free to set reminders of your choice"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:arrMessageData forKey:@"messages"];
    
    arrMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"messages"];
    
    
    
    isSendClicked = NO;
    
    //Medicine
    
    medicineNIB = [UINib nibWithNibName:@"takeMedicineCell" bundle:nil];
    [self.tableV registerNib:medicineNIB forCellReuseIdentifier:@"idMedicine"];
    
    //DrinkWater
    drinkWaterNIB =[UINib nibWithNibName:@"DrinkWaterCell" bundle:nil];
    [self.tableV registerNib:drinkWaterNIB forCellReuseIdentifier:@"idDrinkwater"];
    
    //wakeUpCall
    WakeUpNIB = [UINib nibWithNibName:@"wakeUpCell" bundle:nil];
    [self.tableV registerNib:WakeUpNIB forCellReuseIdentifier:@"idWakeUp"];
    
    //MeetingCell
    
    meetingNIB =[UINib nibWithNibName:@"meetingCell" bundle:nil];
    [self.tableV registerNib:meetingNIB forCellReuseIdentifier:@"idMeeting"];
    
    //BirthdayCell
    birthdayNIB =[UINib nibWithNibName:@"BirthdayCell" bundle:nil];
    [self.tableV registerNib:birthdayNIB forCellReuseIdentifier:@"idBirthday"];
    
    
    //Reminders task List
    reminderNIB = [UINib nibWithNibName:@"ReminderListCell" bundle:nil];
    [self.tableV registerNib:reminderNIB forCellReuseIdentifier:@"idReminder"];
    
    
    //call
    
    callNIB = [UINib nibWithNibName:@"callCell" bundle:nil];
    [self.tableV registerNib:callNIB forCellReuseIdentifier:@"idCall"];
    
    //final message
    messageNIB = [UINib nibWithNibName:@"messageCell" bundle:nil];
    [self.tableV registerNib:messageNIB forCellReuseIdentifier:@"idMessage"];
    
    
    //idTodo
    toDoNIB = [UINib nibWithNibName:@"ToDoList" bundle:nil];
    [self.tableV registerNib:toDoNIB forCellReuseIdentifier:@"idTodo"];
    
    
    
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    [self refreshTitle];
    
    
    
    
    
    
    rowsNumbers = [arrMessageData count] + 1;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(reminderObject:)
     
                                                 name:@"ReminderClicked" object:nil];
    
    
    
    //DateButtonClicked
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(callCalender:)
     
                                                 name:@"DateButtonClicked" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(callTimePicker:)
     
                                                 name:@"TimeButtonClicked" object:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(sendReminder:)
     
                                                 name:@"sendClicked" object:nil];
    
    
    
    //Drink Water
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(drinkwater:)
     
                                                 name:@"DrinkWater" object:nil];
    
    
    
    
    //flate date picker
    self.flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
    
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = @"Select your birthday";
    //self.flatDatePicker.datePickerMode = FlatDatePickerModeTime;
    self.flatDatePicker.datePickerMode = FlatDatePickerModeDate;
    //  [[[UIApplication sharedApplication] keyWindow] addSubview:_flatDatePicker];
    
    
    
    
    

    
    
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    [comps setMonth:0];
//    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    [comps setYear:150];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    //[comps release];
    
    self.flatDatePicker.minimumDate = [NSDate date];
    self.flatDatePicker.maximumDate = maxDate;
    
    
    
    // Registering keyboard notification
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    
    if(rowsNumbers > 0)
    {
        
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: rowsNumbers-1 inSection: 0];
        [self.tableV scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
    }

    
}


#pragma mark keyboard methods

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
    
   // [self.tableV setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    
   [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1, self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
    
    if([self.flatDatePicker isOpen])
    {
        [self.flatDatePicker dismiss];
        
    }
   
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}


#pragma mark end




#pragma mark when datepicker visible
- (void)datepickerShown
{
    CGRect keyboardRect = self.flatDatePicker.frame;
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
  

}

-(void)datepickerHidden
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}






#pragma mark end








#pragma mark TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(void)refreshTitle {
    [self.dateButton setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
}


- (void)drinkwater:(NSNotification *)note {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select Frequency" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"30 min" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            
            [[NSUserDefaults standardUserDefaults] setObject:@"30 min" forKey:@"drink"];
            
            [self sendDirnkingNotification];
            
            //            NSDictionary *dict = [NSDictionary dictionaryWithObject:dateString forKey:@"time"];
            //
            //            [[NSNotificationCenter defaultCenter] postNotificationName: @"getTime" object:nil userInfo:dict];
            //
            //            [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"time"];
            
        }];
        action;
    })];
    
    
    UIAlertAction *option = [UIAlertAction
                             actionWithTitle:@"1 hour"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 [[NSUserDefaults standardUserDefaults] setObject:@"1 hour" forKey:@"drink"];
                                 NSLog(@"1 hour");
                                 [self sendDirnkingNotification];
                             }];
    
    
    [alertController addAction:option];
    
    
    
    UIAlertAction *option1 = [UIAlertAction
                              actionWithTitle:@"2 hours"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                  [[NSUserDefaults standardUserDefaults] setObject:@"2 hours" forKey:@"drink"];
                                  NSLog(@"2 hours");
                                  [self sendDirnkingNotification];
                              }];
    
    
    [alertController addAction:option1];
    
    
    UIAlertAction *option2 = [UIAlertAction
                              actionWithTitle:@"4 hours"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                  [[NSUserDefaults standardUserDefaults] setObject:@"4 hours" forKey:@"drink"];
                                  NSLog(@"4 hours");
                                  [self sendDirnkingNotification];
                              }];
    
    
    [alertController addAction:option2];
    
    
    UIAlertAction *option3 = [UIAlertAction
                              actionWithTitle:@"Once a Day"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                  [[NSUserDefaults standardUserDefaults] setObject:@"Once a Day" forKey:@"drink"];
                                  NSLog(@"Once a Day");
                                  [self sendDirnkingNotification];
                              }];
    
    
    [alertController addAction:option3];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"canceled..");
                                   }];
    
    
    [alertController addAction:cancelAction];
    
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    popoverController.sourceView = self.view;
    popoverController.sourceRect = [self.view bounds];
    [self presentViewController:alertController  animated:YES completion:nil];
    
    
}

- (void)reminderObject:(NSNotification *)note {
    
    
    //    NSIndexPath *indexPath0 = [NSIndexPath indexPathForRow:1 inSection:0];
    //
    //    //put these indexpaths in a NSArray
    //
    //    [self.tableV insertRowsAtIndexPaths:@[indexPath0] withRowAnimation:UITableViewRowAnimationNone];
    
    
    isSendClicked = NO;
    NSDictionary *userInfo = note.userInfo;
    
    arrMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"messages"];
    
    name = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"Reminder"]];
    
    rowsNumbers = [arrMessageData count];
    rowsNumbers = rowsNumbers + 2;
    [self.tableV reloadData];
    if(rowsNumbers > 0)
    {
        
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: rowsNumbers-1 inSection: 0];
        [self.tableV scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return rowsNumbers;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    // @"Call",  done
    //    @"Birthday", done
    //    @"Meeting",  done
    //    @"Wake Up",  done
    //    @"Drink Water", done
    //    @"Take Medicine",
    //    @"To do List",
    
    
    
    if(indexPath.row < [arrMessageData count])
    {
        messageCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idMessage" forIndexPath:indexPath];
        if (!cell) {
            cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idMessage"];
        }
        
        
        cell.textFinal.text = [arrMessageData objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if(indexPath.row == [arrMessageData count])
    {
        ReminderListCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idReminder" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ReminderListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idReminder"];
        }
        //        [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
        //        [cell.contentView.layer setBorderWidth:1.0f];
        return cell;
    }
    else if(indexPath.row == [arrMessageData count] + 1)
    {
        if(!isSendClicked)
        {
            if([name isEqualToString:@"Birthday"])
            {
                
                BirthdayCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idBirthday" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BirthdayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idBirthday"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                
                return cell;
            }
            else if([name isEqualToString:@"Call"])
            {
                //callCell
                callCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idCall" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[callCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idCall"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
                
            }
            else if([name isEqualToString:@"Meeting"])
            {
                //meetingCell
                
                meetingCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idMeeting" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[meetingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idMeeting"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
            }
            else if([name isEqualToString:@"Wake Up"])
            {
                //wakeUpCell
                wakeUpCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idWakeUp" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[wakeUpCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idWakeUp"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
                
            }
            else if([name isEqualToString:@"Drink Water"])
            {
                //wakeUpCell
                DrinkWaterCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idDrinkwater" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[DrinkWaterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idDrinkwater"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
                
            }
            else if([name isEqualToString:@"Take Medicine"])
            {
                //wakeUpCell
                takeMedicineCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idMedicine" forIndexPath:indexPath];
                if (!cell) {
                    cell = [[takeMedicineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idMedicine"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
                
            }
            else if ([name isEqualToString:@"To do List"])
            {
                // to do task
                ToDoList *cell =[self.tableV dequeueReusableCellWithIdentifier:@"idTodo" forIndexPath:indexPath];
                
                if (!cell) {
                    cell = [[ToDoList alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idTodo"];
                }
                //                [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
                //                [cell.contentView.layer setBorderWidth:1.0f];
                return cell;
                
                
            }
            
            
        }
        else
        {
            
            messageCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idMessage" forIndexPath:indexPath];
            if (!cell) {
                cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idMessage"];
            }
            
            
            if([name isEqualToString:@"Birthday"])
            {
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
            }
            else if([name isEqualToString:@"Call"])
            {
                //callCell
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
                
                
            }
            else if([name isEqualToString:@"Meeting"])
            {
                //meetingCell
                
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n Venue:%@ ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"],[[NSUserDefaults standardUserDefaults] objectForKey:@"venue"]];
                
                
            }
            else if([name isEqualToString:@"Wake Up"])
            {
                
                //wakeUpCell
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n  Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
                
                
            }
            else if([name isEqualToString:@"Drink Water"])
            {
                //Drink water
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n in Every:%@",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"drink"]];
                
            }
            else if([name isEqualToString:@"Take Medicine"])
            {
                //take medicine
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
                
            }
            else if ([name isEqualToString:@"To do List"])
            {
                // to do task
                cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
                
            }
            
            
            
            //            [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
            //            [cell.contentView.layer setBorderWidth:1.0f];
            
            strMessage =cell.textFinal.text;
            
            
            return cell;
            
        }
        
        
        
    }
    //    else if (indexPath.row == 2)
    //    {
    //        //messageCell
    //
    //        messageCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"idMessage" forIndexPath:indexPath];
    //        if (!cell) {
    //            cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idMessage"];
    //        }
    //
    //
    //        if([name isEqualToString:@"Birthday"])
    //        {
    //            cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    //        }
    //        else if([name isEqualToString:@"Call"])
    //        {
    //            //callCell
    //            cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    //
    //
    //        }
    //        else if([name isEqualToString:@"Meeting"])
    //        {
    //            //meetingCell
    //
    //             cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n Venue:%@ ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"],[[NSUserDefaults standardUserDefaults] objectForKey:@"venue"]];
    //
    //
    //        }
    //        else if([name isEqualToString:@"Wake Up"])
    //        {
    //
    //            //wakeUpCell
    //            cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n  Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    //
    //
    //        }
    //        else if([name isEqualToString:@"Drink Water"])
    //        {
    //            //Drink water
    //           cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n in Every:%@",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"drink"]];
    //
    //        }
    //        else if([name isEqualToString:@"Take Medicine"])
    //        {
    //            //take medicine
    //            cell.textFinal.text = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    //
    //        }
    //
    //
    //
    //
    //
    //        return cell;
    //    }
    //
    
    return cell;
    //352
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int height1 = 0;
    
    
    if(indexPath.row < [arrMessageData count])
    {
        height1 = 142;
        
    }
    
    if(indexPath.row == [arrMessageData count])
    {
        height1 = 334;
    }
    else if(indexPath.row == [arrMessageData count] + 1)
    {
        if(!isSendClicked)
        {
            
            if([name isEqualToString:@"Birthday"])
            {
                height1 = 263;
            }
            else if([name isEqualToString:@"Call"])
            {
                //callCell
                height1 = 250;
                
            }
            else if([name isEqualToString:@"Meeting"])
            {
                //meetingCell
                height1 = 300;
                
            }
            else if([name isEqualToString:@"Wake Up"])
            {
                
                //wakeUpCell
                
                height1 = 230;
            }
            else if([name isEqualToString:@"Drink Water"])
            {
                //Drink water
                height1 = 220;
                
            }
            else if([name isEqualToString:@"Take Medicine"])
            {
                //take medicine
                
                height1 = 230;
            }
            else if ([name isEqualToString:@"To do List"])
            {
                height1 = 260;
            }
        }
        else
        {
            height1 = 189;
        }
    }
    //    else if(indexPath.row == 2)
    //    {
    //        height1 = 110;
    //    }
    
    
    
    return height1; // Normal height
}


//Call calender to appearence

-(void)callCalender:(NSNotification *)note
{
    
    // [self setDatePicker];
    [self flatedatePicker];
//    [self.scrollView scrollRectToVisible:CGRectMake(self.tableV.frame.origin.x,0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];

//    CGPoint bottomOffset = CGPointMake(0, [self.scrollView contentSize].height);
//    [self.scrollView setContentOffset:bottomOffset animated:NO];
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1, self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
}


//shows time picker

-(void)callTimePicker:(NSNotification *)note
{
    
    [self dispayTimeSelect];
    
    if([self.flatDatePicker isOpen])
    {
        [self.flatDatePicker dismiss];
         [self datepickerHidden];
    }
    
   
}


//takes action when send button is clicked

-(void)sendReminder:(NSNotification *)note
{
    
    isSendClicked = YES;
    
    NSLog(@"send button clicker");
    
    
    NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
    for(id object in arrMessageData)
    {
        [arrTemp addObject:object];
    }
    
    NSString *strTemp =[self getMessageText];
    
    [arrTemp addObject:strTemp];
    [[NSUserDefaults standardUserDefaults] setObject:arrTemp forKey:@"messages"];
    
    arrMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"messages"];
    rowsNumbers = [arrMessageData count] + 1;
    
    [self.tableV reloadData];
    
  //  [self resetDefaults];
    
}


#pragma mark Flat date picker

-(void)flatedatePicker
{
    
    [self.flatDatePicker show];
    [self datepickerShown];
    
}

#pragma mark


#pragma flate date picker delegate methods

#pragma mark - FlatDatePicker Delegate

- (void)flatDatePicker:(FlatDatePicker*)datePicker dateDidChange:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == FlatDatePickerModeDate) {
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    } else if (datePicker.datePickerMode == FlatDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    

    
    
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    [self datepickerHidden];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:@"Did cancelled !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alertView show];
    
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == FlatDatePickerModeDate) {
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    } else if (datePicker.datePickerMode == FlatDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    
    
    
    
    
    
    
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *todays = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    
    int today = (int) [todays day];
    
    int other = (int) [otherDay day];
    
    int tomonth = (int) [todays month];
    
    int omonth = (int) [otherDay month];
    
    
    if([todays day] == [otherDay day] &&
       [todays month] == [otherDay month] &&
       [todays year] == [otherDay year] &&
       [todays era] == [otherDay era]) {
        //do stuff
        
        
        isnotValid = NO;
        
        NSLog(@"date is same to what you want");
        
        
        
        
    }
    else if(other >= today && omonth >= tomonth)
    {
         NSLog(@"todays day is %ld and others days is : %ld   other month : %ld  today month : %ld",(long)[todays day],(long)[otherDay day],(long)[otherDay month],(long)[todays month]);
        isnotValid = NO;
    }
    else
    {
        isnotValid = YES;
    }
   
    
    
    
    
    
 
    
    if(isnotValid)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Select Valid date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
              [alertView show];
    }
    else
    {
        [self setDAteFromPicker:date];

    }

    
    
    [self datepickerHidden];
    
    

}





-(void)setDAteFromPicker:(NSDate *)date
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
        NSString *value = [dateFormatter stringFromDate:date];
    
    
    NSLog(@"date from value is : %@",value);
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:date forKey:@"date"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName: @"getDate" object:nil userInfo:dict];
        
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"date"];
    
    
    
    

//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Select Valid date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertView show];
//    }

}

#pragma mark



#pragma mark delete NSDefaults date

- (void)resetDefaults {
    // you can usually get the domain via [[NSBundle mainBundle] bundleIdentifier]
    [[NSUserDefaults standardUserDefaults]
     removePersistentDomainForName:@"com.miimobileapp.Reminders"];
    // or use a string for any other settings domains you use
    //[[NSUserDefaults standardUserDefaults]
    // removePersistentDomainForName:@"com.mycompany.myappname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark


//-(void)setFinalReminder
//{
//
//
//
//}

//
//-(void)setDatePicker
//{
//    if(!self.datePicker)
//        self.datePicker = [THDatePickerViewController datePicker];
//    self.datePicker.date = self.curDate;
//    self.datePicker.delegate = self;
//    [self.datePicker setAllowClearDate:NO];
//    [self.datePicker setClearAsToday:YES];
//    [self.datePicker setAutoCloseOnSelectDate:NO];
//    [self.datePicker setAllowSelectionOfSelectedDate:YES];
//    [self.datePicker setDisableYearSwitch:YES];
//    //[self.datePicker setDisableFutureSelection:NO];
//    [self.datePicker setDaysInHistorySelection:12];
//    [self.datePicker setDaysInFutureSelection:0];
//    //    [self.datePicker setAllowMultiDaySelection:YES];
//    //    [self.datePicker setDateTimeZoneWithName:@"UTC"];
//    //[self.datePicker setAutoCloseCancelDelay:5.0];
//    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
//    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
//    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
//
//    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
//        int tmp = (arc4random() % 30)+1;
//        return (tmp % 5 == 0);
//    }];
//    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
//    [self presentSemiViewController:self.datePicker withOptions:@{
//                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
//                                                                  KNSemiModalOptionKeys.animationDuration : @(0.2),
//                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
//                                                                  }];
//}

#pragma mark - THDatePickerDelegate

//- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
//    self.curDate = datePicker.date;
//    [self refreshTitle];
//
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:datePicker.date forKey:@"date"];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName: @"getDate" object:nil userInfo:dict];
//
//    [[NSUserDefaults standardUserDefaults] setObject:self.curDate forKey:@"date"];
//
//    [self dismissSemiModalView];
//}
//
//- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
//    [self dismissSemiModalView];
//}
//
//- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
//    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
//}



#pragma mark display Time picker
-(void)dispayTimeSelect
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeTime];
    [alertController.view addSubview:picker];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            [outputFormatter setDateFormat:@"hh:mm a"]; //12hr time format
            NSString *dateString = [outputFormatter stringFromDate:picker.date];
            
            
            NSLog(@"%@",dateString);
            
            NSDictionary *dict = [NSDictionary dictionaryWithObject:dateString forKey:@"time"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"getTime" object:nil userInfo:dict];
            
            [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"time"];
            
        }];
        action;
    })];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"canceled..");
                                   }];
    
    
    [alertController addAction:cancelAction];
    
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    popoverController.sourceView = self.view;
    popoverController.sourceRect = [self.view bounds];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}



#pragma mark Send Drinking Notification

-(void)sendDirnkingNotification
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"drink"] forKey:@"drink"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDrinkTitle" object:nil userInfo:dic];
    
}





#pragma mark end

-(NSString *)getMessageText
{
    if([name isEqualToString:@"Birthday"])
    {
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    }
    else if([name isEqualToString:@"Call"])
    {
        //callCell
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
        
        
    }
    else if([name isEqualToString:@"Meeting"])
    {
        //meetingCell
        
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n Venue:%@ ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"],[[NSUserDefaults standardUserDefaults] objectForKey:@"venue"]];
        
        
    }
    else if([name isEqualToString:@"Wake Up"])
    {
        
        //wakeUpCell
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n  Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
        
        
    }
    else if([name isEqualToString:@"Drink Water"])
    {
        //Drink water
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n in Every:%@",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"drink"]];
        
    }
    else if([name isEqualToString:@"Take Medicine"])
    {
        //take medicine
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
        
    }
    else if ([name isEqualToString:@"To do List"])
    {
        // to do task
        strMessage = [NSString stringWithFormat:@"You have set reminder for %@\n with following details\n Name:%@\n Date:%@ \n Time:%@ \n ",name,[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"date"],[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
        
    }
    
    
    
    //            [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
    //            [cell.contentView.layer setBorderWidth:1.0f];
    
    return strMessage;
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
