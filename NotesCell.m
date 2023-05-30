//
//  NotesCell.m
//  iRein
//
//  Created by Justin Hackett on 9/13/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "NotesCell.h"

@implementation NotesCell

@synthesize patternTextLabel;
//Got rid of this:
//@synthesize maneuverTextLabel;
@synthesize noteTitleLabel;
@synthesize noteTextLabel;
@synthesize noteDateLabel;
@synthesize notePatternImageView;

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
