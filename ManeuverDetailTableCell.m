//
//  ManeuverDetailTableCell.m
//  iRein
//
//  Created by Justin Hackett on 2/20/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "ManeuverDetailTableCell.h"


@implementation ManeuverDetailTableCell

@synthesize myCellText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)setNewCellText:(NSString *)textForCell {
	
	self.myCellText.text = textForCell;

}




@end
