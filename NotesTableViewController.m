//
//  NotesTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 7/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "NotesTableViewController.h"
#import "AppDelegate_Shared.h"
#import "Pattern.h"
#import "Maneuver.h"
#import "Note.h"
#import "PatternDetailViewControlleriPhone.h"
#import "NoteDetailTableViewController.h"
#import "NoteTextTableViewController.h"
#import "NotesCell.h"

NSString *kNoteDetailSegue = @"noteDetailSegue"; //Seque to table view of note detail sheet.
NSString *kNoteTextSegue = @"noteTextSegue"; //Seque to table view of note text.

@interface NotesTableViewController () {
    //int selectedCellRow;

}
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *patternsArray;
@property (nonatomic, strong) NSArray *maneuversArray;
@property (nonatomic, strong) NSMutableArray *maneuversWithNotesArray;
@property (nonatomic, strong) NSArray *notesArray;
@property (nonatomic, strong) NSArray *myNewNotesArray;
@property (nonatomic, strong) NSMutableArray *myOldNotesArray;
@property (nonatomic, strong) Note *selectedNote;

@property (nonatomic, strong) NSMutableArray *myNotesArray;

- (void)configureCell:(NotesCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(Note *)getNoteWithPattern:(Pattern *)pattern maneuver:(Maneuver *)maneuver noteText:(NSString *)text;
-(void)addOldNotesToNewNotesArray;

@end

@implementation NotesTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize patternsArray;
@synthesize maneuversArray;
@synthesize maneuversWithNotesArray;
@synthesize notesArray;
@synthesize myNewNotesArray;
@synthesize myOldNotesArray;
@synthesize selectedNote;

@synthesize myNotesArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
//Calls methods to take old note's text and create new notes then set the old note's to have no text.
    [self addOldNotesToNewNotesArray];
    
//TODO:CHECK TO MAKE SURE THE FETCH OCCURS FOLLOWING THE NEW NOTE CREATION.
//TODO:IS THIS THREADSAFE?A
//Fetches all new Notes.
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
}

#pragma mark -
#pragma mark Notes Support

-(void)addOldNotesToNewNotesArray {
    
//Run this only once with first app startup. This will take the old notes according to the maneuver they belong to
//and then call the getNoteWithPattern... method and create a new note. Once this is done it shouldn't be done again
//otherwise you end up with duplicate notes being created in the store.
    
//If the myNotesArray is nil, create one.
    if (!self.myNotesArray) {

    NSMutableArray *anArray = [[NSMutableArray alloc] init];
    self.myNotesArray = anArray;
       
//End of if statement.
    }
    
    
//Fetch all maneuvers sorted by name ascending.
        NSError *error;
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Maneuver" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entityDescription];
        NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    
//Put fetched maneuvers into maneuversArray.
        self.maneuversArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    
//Loop through the maneuversArray.
            int i;
            for (i = 0; i < [self.maneuversArray count]; ++i) {
            
            Maneuver *theManeuver = [maneuversArray objectAtIndex:i];
            NSLog(@"The count of maneuversArray is %i", [maneuversArray count]);
            
//Check to see if the maneuver has notes text.
            if (theManeuver.notes != [NSString stringWithFormat:@""]) {

//Get the pattern that the note's maneuver belongs to.
                Pattern *aPattern = theManeuver.pattern;
                Maneuver *aManeuver = theManeuver;

//Call getNoteWithPattern method passing the pattern, the maneuver, and the note text.
//This returns a new note with it's attributes set using the values passed into the method.
                Note *oldNote = [self getNoteWithPattern:aPattern maneuver:aManeuver noteText:theManeuver.notes];
                
//Add the newly returned new note to to the self.myNotesArray.
               [self.myNotesArray addObject:oldNote];

//Set the old note on the maneuver to have no text.
                [theManeuver setValue:@"" forKey:@"notes"];
//TODO:See if this works or not, or use above code.
                //theManeuver.notes = nil;
                
//Save the context.
                [_managedObjectContext save:&error];
//End of if statement.
            }
                
//End of for loop.
        }
    
}


-(Note *)getNoteWithPattern:(Pattern *)pattern maneuver:(Maneuver *)maneuver noteText:(NSString *)text {
    
    NSLog(@"Here, the Pattern is %@, and the Maneuver is %@", pattern, maneuver);
    
    NSError *error;
    Note *newNote = (Note *)[NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    [newNote setValue:text forKey:@"text"];
    [newNote setPattern:pattern];
//Got rid of this:
    //[newNote setManeuver:maneuver];
    [newNote setValue:@"iRein v1.1 Note" forKey:@"title"];
    [newNote setValue:[NSDate date] forKey:@"date"];
    NSLog(@"The new note's date is now %@", newNote.date);
    
    [_managedObjectContext save:&error];
    
    return newNote;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[self.fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
	
    return count;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    NSInteger numberOfRows = 0;

    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    */
    NSInteger *numberOfRows = [[self.fetchedResultsController fetchedObjects] count];
    
    return numberOfRows;
    
}


/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    // Return a title or nil as appropriate for the section.
    switch (section) {
        case OLD_NOTES_SECTION:
            title = @"iRein v1.0 Notes";
            break;
        case NEW_NOTES_SECTION:
            title = @"iRein v2.0 Notes";
            break;
        default:
            break;
    }
    
    return title;
    
}
*/


//TODO: There seems to be a problem with doing this fetch in this cell method. I don't think it's fetching in time.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"NotesCell";
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)configureCell:(NotesCell *)cell atIndexPath:(NSIndexPath *)indexPath {

        Note *theNewNote = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
        
        cell.patternTextLabel.text = [NSString stringWithFormat:@"%@", theNewNote.pattern.name];
//Got rid of this:
        //cell.maneuverTextLabel.text = [NSString stringWithFormat:@"%@", theNewNote.maneuver.name];
        cell.noteTitleLabel.text = [NSString stringWithFormat:@"%@", theNewNote.title];
        
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateStyle:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormater stringFromDate:theNewNote.date];
        cell.noteDateLabel.text = dateString;
        
        cell.noteTextLabel.text = theNewNote.text;
        cell.notePatternImageView.image = [UIImage imageNamed:theNewNote.pattern.largeWhiteImageRef];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			
			 //Replace this implementation with code to handle the error appropriately.
			 
			 //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
        
	}
}


/*
 // Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Editing style is ...StyleDelete");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        NSLog(@"Editing style is ...StyleInsert");
    }
}
*/


//TODO: I put this here in case I need it.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.selectedNote = [self.myNewNotesArray objectAtIndex:indexPath.row];
   //NSLog(@"The self.selectedNote is %@", self.selectedNote);

//}

/*
//Not using this. I don't want to reorder the rows.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}
*/

#pragma mark -
#pragma mark Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//TODO: Fix This
    if ([[segue identifier] isEqualToString:kNoteTextSegue]) {
        
        NoteTextTableViewController *noteTextTableViewController = [segue destinationViewController];
        noteTextTableViewController.managedObjectContext = self.managedObjectContext;
        noteTextTableViewController.delegate = self;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //noteTextTableViewController.selectedRow = path.row;
        noteTextTableViewController.selectedNote = [[self.fetchedResultsController fetchedObjects] objectAtIndex:path.row];
        
        NSLog(@"noteTextTableViewController.selectedNote is %@", noteTextTableViewController.selectedNote);
        NSLog(@"selectedNote.pattern is %@", noteTextTableViewController.selectedNote.pattern);
        NSLog(@"selectedNote.maneuver is %@", noteTextTableViewController.selectedNote.maneuver);
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        
        [segue destinationViewController];

    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:kNoteDetailSegue]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        NoteDetailTableViewController *noteDetailTableViewController = [[navigationController viewControllers] objectAtIndex:0];
        noteDetailTableViewController.managedObjectContext = self.managedObjectContext;
        noteDetailTableViewController.delegate = self;
        
        [segue destinationViewController];
    }
}

#pragma mark -
#pragma mark NoteTextTableViewControllerDelegate

-(void)didSaveManagedObjectContext:(NSManagedObjectContext *)context {
    NSLog(@"didSaveManagedObjectContext delegate method did fire before if statement");
    
        if (context == self.managedObjectContext) {
        [self.tableView reloadData];
        NSLog(@"didSaveManagedObjectContext delegate method did fire");
    }
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
        
    // Set up the fetched results controller if needed.
    if (_fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
    }
	
	return _fetchedResultsController;
}

#pragma mark -
#pragma mark Delegate FetchedResultsController Methods

//Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
    NSLog(@"willChangeContent fired");
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"insertRowsAtIndexPaths fired");
            break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"deleteRowsAtIndexPaths fired");
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:(NotesCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            NSLog(@"configureCell fired");
            break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"deleteRowsAtIndexPaths and insertRowsAtIndexPaths fired");
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"deleteSections fired");
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
    NSLog(@"didChangeContent fired");
}




@end
