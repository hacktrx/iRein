//
//  ManeuverCell.h
//  iRein
//
//  Created by Justin Hackett on 10/12/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManeuverCell : UITableViewCell {
    
    IBOutlet UIImageView *maneuverImageView;
    IBOutlet UIImageView *noteIconView;
    IBOutlet UILabel *maneuverName;
    IBOutlet UILabel *maneuverDescription;
    
}

@property (nonatomic, strong) IBOutlet UIImageView *maneuverImageView;
@property (nonatomic, strong) IBOutlet UIImageView *noteIconView;
@property (nonatomic, strong) IBOutlet UILabel *maneuverName;
@property (nonatomic, strong) IBOutlet UILabel *maneuverDescription;

@end
