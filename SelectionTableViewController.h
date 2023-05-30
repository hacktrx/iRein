//
//  SelectionTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 7/25/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Pattern;
@class Maneuver;
@class NoteDetailTableViewController;
@class NoteTextTableViewController;

@protocol SelectionTableDelegate <NSObject>

-(void)didSelectPattern:(Pattern *)pattern;
-(void)didSelectManeuver:(Maneuver *)maneuver;

@end

@interface SelectionTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
        
}

@property (weak) id<SelectionTableDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSString *myEntity;
@property (nonatomic, strong) NSString *mySortDescriptor;
@property (nonatomic, strong) Pattern *selectedPattern;
@property (nonatomic, strong) NoteDetailTableViewController *noteDetailTableViewController;
@property (nonatomic, strong) NoteTextTableViewController *noteTextTableViewController;

@property (nonatomic) BOOL listManeuvers;


@end
