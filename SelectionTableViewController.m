//
//  SelectionTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 7/25/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "SelectionTableViewController.h"
#import "Pattern.h"
#import "Maneuver.h"

@interface SelectionTableViewController ()

@end

@implementation SelectionTableViewController


@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize delegate;
@synthesize noteDetailTableViewController;
@synthesize noteTextTableViewController;

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
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    NSLog(@"viewDidLoad fired in SelectionTableViewController and listManeuvers is %hhd", self.listManeuvers);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.listManeuvers == NO) {
    // Configure the cell...
    Pattern *pattern = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = pattern.name;
        NSLog(@"cellForRow in pattern if statement fired");
    }
    
    else {
        Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = maneuver.name;
        NSLog(@"cellForRow in maneuver in else statement fired");
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.listManeuvers == NO) {
	//Pass the maneuver that was selected in the table to the ivar in the next controller.
	Pattern *thePattern = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[self.delegate didSelectPattern:thePattern];
        NSLog(@"did select table view cell in if statement for patterns");
        
    }
    
    else {
        Maneuver *theManeuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.delegate didSelectManeuver:theManeuver];
        NSLog(@"did select table view cell in else statement for maneuver");
    }

}

/*
 // If there was a previous selection, unset the accessory view for its cell.
 NSManagedObject *currentType = self.selectedPattern;
 
 if (currentType != nil) {
 NSInteger index = [self.fetchedResultsController indexPathForObject:indexPath];
 NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
 UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
 checkedCell.accessoryType = UITableViewCellAccessoryNone;
 }
 
 // Set the checkmark accessory for the selected row.
 [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
 
 // Deselect the row.
 [tableView deselectRowAtIndexPath:indexPath animated:YES];

*/





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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/
 


- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (_fetchedResultsController != nil) {
        NSLog(@"fetchedResultsController is nil in it's factory method");
        return _fetchedResultsController;
    }
    
    
    if (self.listManeuvers == NO) {
    
        NSLog(@"fetchedResultsController fired in if statement");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.myEntity inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array. We have only one sort descriptor in the array.
	NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:self.mySortDescriptor ascending:YES];
    
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
}
    
    else {
        NSLog(@"fetchedResultsController fired in else statement");
        // Create and configure a fetch request with the Maneuver entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Maneuver" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        //The predicate is not in the CoreDataBooks example, but I need it here.
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"pattern == %@", self.selectedPattern];
        [fetchRequest setPredicate:pred];
        
        NSLog(@"The pattern is %@", self.selectedPattern);
        
        // Create the sort descriptors array. We have only one sort descriptor in the array.
        NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pattern" ascending:YES];
        //Without this descriptor, the cells have all the maneuvers in them but they are not ordered from one
        //to twelve like they should be. I need this "name" descriptor to get it to do that correctly.
        NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nameDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Create and initialize the fetch results controller.
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
    }
    
    
    
    
    return _fetchedResultsController;
    
}



@end
