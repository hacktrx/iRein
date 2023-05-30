//
//  NotesTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 7/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NoteTextTableViewController.h"
#import "NoteDetailTableViewController.h"

@interface NotesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, NoteTextTableViewControllerDelegate, NoteDetailTableViewControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
