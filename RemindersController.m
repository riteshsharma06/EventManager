//
//  RemindersController.m
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "RemindersController.h"

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



@interface RemindersController ()<UIActionSheetDelegate,FlatDatePickerDelegate>
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
    
    //ReminderClicked
}
@property (nonatomic, strong) FlatDatePicker *flatDatePicker;
@end

@implementation RemindersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    self.flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view.superview];
    
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = @"Select your birthday";
    //self.flatDatePicker.datePickerMode = FlatDatePickerModeTime;
    self.flatDatePicker.datePickerMode = FlatDatePickerModeDate;
  //  [[[UIApplication sharedApplication] keyWindow] addSubview:_flatDatePicker];
    
    
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
        height1 = 100;

    }
    
    if(indexPath.row == [arrMessageData count])
    {
          height1 = 300;
    }
    else if(indexPath.row == [arrMessageData count] + 1)
    {
        if(!isSendClicked)
        {
        
            if([name isEqualToString:@"Birthday"])
            {
                height1 = 204;
            }
            else if([name isEqualToString:@"Call"])
            {
                //callCell
                height1 = 200;
                
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
}


//shows time picker

-(void)callTimePicker:(NSNotification *)note
{
   
    [self dispayTimeSelect];
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
    
    
}


#pragma mark Flat date picker

-(void)flatedatePicker
{

    [self.flatDatePicker show];
    
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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:@"Did cancelled !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
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
    
    NSString *value = [dateFormatter stringFromDate:date];
    
    
    NSString *message = [NSString stringWithFormat:@"Did valid date : %@", value];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
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




@end
