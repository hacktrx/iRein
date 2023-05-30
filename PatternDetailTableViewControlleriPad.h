//
//  PatternDetailTableViewControlleriPad.h
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>
//Need this because the protocol declaration is in the PatternImageViewControlleriPad.
#import "PatternImageViewControlleriPad.h"
#import <CoreData/CoreData.h>

@class PatternImageViewController;
@class ManeuverDetailTableViewController;
@class Pattern;
@class PatternDetailTableViewCelliPad;

@interface PatternDetailTableViewControlleriPad : UITableViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, PatternImageModalViewDelegate, NSFetchedResultsControllerDelegate> {

	UIPopoverController *popoverController;
    UIToolbar *toolbar;

	Pattern *thePattern;
	IBOutlet UIImageView *tableViewBackground;
	UIImage *maneuverImage;
    IBOutlet UIView *headerView;
    IBOutlet UIImageView *smallPatternView;
    NSInteger selectedRow;
    NSInteger mySelectedSegment;
    PatternDetailTableViewCelliPad *patternDetailTableViewCell;
    
	@private
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) UIPopoverController *popoverController;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UIImageView *smallPatternView;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, assign) NSInteger mySelectedSegment;
@property (nonatomic, strong) IBOutlet PatternDetailTableViewCelliPad *patternDetailTableViewCell;

@property (nonatomic, strong) Pattern *thePattern;
@property (nonatomic, strong) IBOutlet UIImageView *tableViewBackground;
@property (nonatomic, strong) UIImage *maneuverImage;

//Used to set the horizontal small pattern image in the legend.
- (void)configureLegend:(NSIndexPath *)rowInteger;

-(void)viewImageButtonPressed:(id)sender;

-(void)loadNewPattern:(Pattern *)pattern;

@end
