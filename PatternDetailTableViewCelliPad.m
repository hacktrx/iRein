//
//  PatternDetailTableViewCelliPad.m
//  iRein
//
//  Created by Justin Hackett on 4/8/11.
//  Copyright 2011 JH Productions. All rights reserved.
//

#import "PatternDetailTableViewCelliPad.h"


@implementation PatternDetailTableViewCelliPad

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
