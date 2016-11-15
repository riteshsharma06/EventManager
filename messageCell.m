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
//    [self.textFinal.layer setBorderColor:[UIColor greenColor].CGColor];
//    [self.textFinal.layer setBorderWidth:1.0f];
    
    [self.textFinal setTextColor:[UIColor whiteColor]];
    
    [self.viewNew.layer setCornerRadius:10.0f];
    [self.viewNew.layer setShadowOpacity:0.8];
    [self.viewNew.layer setShadowRadius:3.0];
    [self.viewNew.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.viewNew.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.viewNew.layer setBorderWidth:1.0f];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
