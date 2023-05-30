//
//  RootViewController.h
//  iRein
//
//  Created by Justin Hackett on 2/3/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PatternDetailTableViewControlleriPad;
@class Pattern;

@interface RootViewController : UITableViewController {

	PatternDetailTableViewControlleriPad *patternDetailTableViewControlleriPad;

	NSArray *patterns;
	NSArray *patternsArray;
	Pattern *selectedPattern;

	UISplitViewController *__weak splitViewController;

@private
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) IBOutlet PatternDetailTableViewControlleriPad *patternDetailTableViewControlleriPad;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSArray *patterns;
@property (nonatomic, strong) NSArray *patternsArray;
@property (nonatomic, strong) Pattern *selectedPattern;

@property (nonatomic, weak) IBOutlet UISplitViewController *splitViewController;

@end

//FYI, the way I got rid of the back button on the navigation bar of the PatternImageViewControlleriPad
//is to delete the text in the nib file for the navigation item that is in the inspector of the MainWindow
//nib file's DetailViewController navigationItem field. No text = no button in the nav bar.