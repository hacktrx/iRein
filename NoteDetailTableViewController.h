//
//  NoteDetailTableViewController.h
//  iRein
//
//  Created by Justin Hackett on 7/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SelectionTableViewController.h"
#import "Note.h"

@protocol NoteDetailTableViewControllerDelegate <NSObject>

-(void)didSaveManagedObjectContext:(NSManagedObjectContext *)context;
// recipe == nil on cancel
//- (void)noteDetailTableViewController:(NoteDetailTableViewController *)noteDetailController didAddNote:(Note *)note;

@end

@interface NoteDetailTableViewController : UITableViewController <SelectionTableDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    BOOL listManeuvers;
    
}


@property (weak) id<NoteDetailTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Note *myNewNote;
@property (nonatomic, assign) NSInteger selectedRow;

@end
