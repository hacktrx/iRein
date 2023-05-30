//
//  PatternDetailTableViewCelliPad.h
//  iRein
//
//  Created by Justin Hackett on 4/8/11.
//  Copyright 2011 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PatternDetailTableViewCelliPad : UITableViewCell {
    
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
