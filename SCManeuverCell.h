//
//  SCManeuverCell.h
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCManeuverCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIStepper *scoreStepper;
@property (strong, nonatomic) IBOutlet UITextField *scoreTextField;
@property (strong, nonatomic) IBOutlet UIStepper *penaltyStepper;
@property (strong, nonatomic) IBOutlet UITextField *penaltyTextField;
@property (strong, nonatomic) IBOutlet UILabel *totalScoreTextField;

-(void)changeScoreStepperValue:(UIStepper *) stepper;
-(void)changePenaltyStepperValue:(UIStepper *) stepper;

@end
