//
//  LargePatternViewControlleriPhone.h
//  iRein
//
//  Created by Justin Hackett on 6/7/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pattern;

@protocol LargePatternViewDelegate <NSObject>

-(void)setMySegmentedControlActiveSegment:(NSInteger *)segment;

@end

@interface LargePatternViewControlleriPhone : UIViewController

@property (weak) id<LargePatternViewDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Pattern *selectedPattern;
@property (nonatomic, assign) NSInteger patternNumber;
@property (nonatomic, strong) IBOutlet UISegmentedControl *mySegmentedControl;


@end
