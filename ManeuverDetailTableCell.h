//
//  ManeuverDetailTableCell.h
//  iRein
//
//  Created by Justin Hackett on 2/20/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ManeuverDetailTableCell : UITableViewCell {
	
	IBOutlet UILabel *myCellText;

}

@property (nonatomic, strong) IBOutlet UILabel *myCellText;

- (void)setNewCellText:(NSString *)textForCell;

@end
