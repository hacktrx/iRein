//
//  BlackAndWhiteCell.m
//  iRein
//
//  Created by Justin Hackett on 2/28/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import "BlackAndWhiteCell.h"

@implementation BlackAndWhiteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
