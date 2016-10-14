//
//  DrinkWaterCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkWaterCell : UITableViewCell

- (IBAction)sendFrequency:(id)sender;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFrequency;

@end
