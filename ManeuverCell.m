//
//  ManeuverCell.m
//  iRein
//
//  Created by Justin Hackett on 10/12/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import "ManeuverCell.h"

@implementation ManeuverCell

@synthesize maneuverImageView;
@synthesize noteIconView;
@synthesize maneuverName;
@synthesize maneuverDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
