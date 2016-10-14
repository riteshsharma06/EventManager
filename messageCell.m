//
//  messageCell.m
//  Reminders
//
//  Created by SoftBunch  on 10/7/16.
//  Copyright © 2016 miimobileapp. All rights reserved.
//

#import "messageCell.h"

@implementation messageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textFinal.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.textFinal.layer setBorderWidth:1.0f];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
