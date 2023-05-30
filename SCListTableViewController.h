//
//  SCListTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 3/19/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ScorecardEvent;

@interface SCListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ScorecardEvent *myNewScorecard;

@end
