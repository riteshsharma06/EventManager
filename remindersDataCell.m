//
//  remindersDataCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/5/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "remindersDataCell.h"

@implementation remindersDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.Name.layer setBorderColor:[UIColor blueColor].CGColor];
    [self.Name.layer setBorderWidth:1.0f];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
