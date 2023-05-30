//
//  ManeuverTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 7/10/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class Pattern;

@interface ManeuverTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Pattern *selectedPattern;
@property (nonatomic, assign) NSInteger mySelectedSegment;

//I think I can get rid of this when I'm loading this class from the large pattern detail view.
@property (nonatomic, assign) NSInteger selectedRow;

//-(void)viewImageButtonPressed:(id)sender;
//-(IBAction)patternImageClicked:(id)sender;

@end


