//
//  SCManeuverTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 3/20/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SCManeuverTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
