//
//  NoteTextTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 7/18/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SelectionTableViewController.h"

@class Note;

@protocol NoteTextTableViewControllerDelegate <NSObject>

-(void)didSaveManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface NoteTextTableViewController : UITableViewController <SelectionTableDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    BOOL listManeuvers;
}

@property (weak) id<NoteTextTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Note *selectedNote;
//@property (nonatomic, assign) NSInteger selectedRow;

@end
