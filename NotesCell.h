//
//  NotesCell.h
//  iRein
//
//  Created by Justin Hackett on 9/13/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *patternTextLabel;
//Got rid of this:
//@property (nonatomic, strong) IBOutlet UILabel *maneuverTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteDateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *notePatternImageView;


@end
