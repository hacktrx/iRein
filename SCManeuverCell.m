//
//  SCManeuverCell.m
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import "SCManeuverCell.h"

@implementation SCManeuverCell

@synthesize scoreStepper;
@synthesize scoreTextField;
@synthesize penaltyStepper;
@synthesize penaltyTextField;

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
    
    [self.scoreStepper addTarget:self
                          action:@selector(myStepperValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    
    [self.penaltyStepper addTarget:self
                          action:@selector(myStepperValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)myStepperValueChanged:(UIStepper *) stepper {
    
    if (stepper == self.scoreStepper) {
    float scoreNumber = self.scoreStepper.value;
    NSString *scoreString = [NSString stringWithFormat:@"%.02f", scoreNumber];
    self.scoreTextField.text = scoreString;
    }
    
    if (stepper == self.penaltyStepper) {
        float penaltyNumber = self.penaltyStepper.value;
        NSString *penaltyString = [NSString stringWithFormat:@"%.02f", penaltyNumber];
        self.penaltyTextField.text = penaltyString;
    }
    
}

-(void)changePenaltyStepperValue:(UIStepper *) stepper {
    
}

@end
