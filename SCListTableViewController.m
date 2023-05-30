//
//  SCListTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 3/19/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import "SCListTableViewController.h"
#import "SCDetailTableViewController.h"
#import "SCAddTableViewController.h"
#import "SCEventCell.h"
#import "ScorecardEvent.h"

@interface SCListTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)configureCell:(SCEventCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SCListTableViewController

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
    
    /*
    ScorecardEvent *theNewEvent = [NSEntityDescription insertNewObjectForEntityForName:@"ScorecardEvent" inManagedObjectContext:self.managedObjectContext];
    self.myNewScorecard = theNewEvent;
    self.myNewScorecard.eventName = @"My NRHA Event";
    self.myNewScorecard.eventJudge = @"Judge Nacho";
    self.myNewScorecard.eventClass = @"Non Pro";
    self.myNewScorecard.eventDate = [NSDate date];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        
        //Replace this implementation with code to handle the error appropriately.
        
        //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    */
    
//Fetches all scorecard events.
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger *numberOfRows = [[self.fetchedResultsController fetchedObjects] count];
    
    return numberOfRows;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SCEventCell";
    SCEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
 
 
}


- (void)configureCell:(SCEventCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
     ScorecardEvent *theNewEvent = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
     /*
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
     */
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //TODO: Fix This
    if ([[segue identifier] isEqualToString:@"ScorecardEventSegue"]) {
        
        SCDetailTableViewController *mySCDetailTableViewController = [segue destinationViewController];
        mySCDetailTableViewController.managedObjectContext = self.managedObjectContext;
        //mySCDetailTableViewController.delegate = self;
        
        /* NOT USING THIS YET
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //noteTextTableViewController.selectedRow = path.row;
        noteTextTableViewController.selectedNote = [[self.fetchedResultsController fetchedObjects] objectAtIndex:path.row];
        
        NSLog(@"noteTextTableViewController.selectedNote is %@", noteTextTableViewController.selectedNote);
        NSLog(@"selectedNote.pattern is %@", noteTextTableViewController.selectedNote.pattern);
        NSLog(@"selectedNote.maneuver is %@", noteTextTableViewController.selectedNote.maneuver);
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        */
        [segue destinationViewController];
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SCEventAddSegue"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        SCAddTableViewController *sdAddTableViewController = [[navigationController viewControllers] objectAtIndex:0];
        sdAddTableViewController.managedObjectContext = self.managedObjectContext;
        //noteDetailTableViewController.delegate = self;
        
        [segue destinationViewController];
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
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ScorecardEvent" inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventDate" ascending:YES];
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
			[self configureCell:(SCEventCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
