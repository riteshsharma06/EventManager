//
//  DrinkWaterCell.h
//  Reminders
//
//  Created by SoftBunch  on 10/6/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkWaterCell : UITableViewCell {
    BOOL error;
}

- (IBAction)sendFrequency:(id)sender;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFrequency;
@property (weak, nonatomic) IBOutlet UIView *viewNew;

@property (weak, nonatomic) IBOutlet UIButton *sendLabel;
@end
