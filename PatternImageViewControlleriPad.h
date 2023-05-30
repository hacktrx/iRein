//
//  PatternImageViewControlleriPad.h
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pattern;

@protocol PatternImageModalViewDelegate;

@interface PatternImageViewControlleriPad : UIViewController {

	Pattern *thePatternForImageView;
	IBOutlet UIImageView *patternImageView;
	IBOutlet UIImageView *landscapePatternImageView;
	UIImage *patternImage;
	IBOutlet UISegmentedControl *segmentedControl;
    NSInteger defaultImage;
    NSInteger selectedSegment;
    
@private
	id <PatternImageModalViewDelegate> __weak delegate;
}

@property (nonatomic, strong) Pattern *thePatternForImageView;
@property (nonatomic, strong) IBOutlet UIImageView *patternImageView;
@property (nonatomic, strong) IBOutlet UIImageView *landscapePatternImageView;
@property (nonatomic, strong) UIImage *patternImage;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, assign) NSInteger defaultImage;
@property (nonatomic, assign) NSInteger selectedSegment;

@property(nonatomic, weak) id <PatternImageModalViewDelegate> delegate;

-(IBAction)segControlClicked:(id)sender;
//- (void)cancelImageView;

@end


@protocol PatternImageModalViewDelegate <NSObject>

- (void)dismissPatternImageView;
- (void)recordSelectedSegment:(NSInteger)theSelectedSegment;

@end