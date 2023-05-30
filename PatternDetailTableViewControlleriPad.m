//
//  PatternDetailTableViewControlleriPad.m
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "PatternDetailTableViewControlleriPad.h"
#import "ManeuverDetailTableViewControlleriPad.h"
#import "RootViewController.h"
#import "Pattern.h"
#import "Maneuver.h"
#import "PatternDetailTableViewCelliPad.h"

@interface PatternDetailTableViewControlleriPad ()

- (void)configureCell:(PatternDetailTableViewCelliPad *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation PatternDetailTableViewControlleriPad

@synthesize toolbar, popoverController;
@synthesize fetchedResultsController, managedObjectContext;
@synthesize thePattern;
@synthesize tableViewBackground;
@synthesize maneuverImage;
@synthesize headerView;
@synthesize smallPatternView;
@synthesize selectedRow;
@synthesize mySelectedSegment;
@synthesize patternDetailTableViewCell;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mySelectedSegment = -1;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	//This put the name of the pattern that was selected in the popover in the middle of the nav bar.
	//When the app launches pattern 1 is assigned to the "thePattern" ivar. It's done in the RootViewController's
	//viewDidLoad method. Then, each time a pattern is selected in the patterns list, the loadNewPattern method
	//will assign the new pattern's name into the title property, not from this viewDidLoad method.
	self.navigationItem.title = self.thePattern.name;
	
	self.tableView.backgroundView = self.tableViewBackground;
    
    //This puts the legend in as a header view of the table and loads pattern1 in the first time on launch.
    self.tableView.tableHeaderView = self.headerView;
    [self configureLegend:0];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail		
	}
	
	NSLog(@"The pattern that got passed into this is %@", thePattern);
	
	//Implement this to add the viewImage button to the right side of the navigation bar.
	UIBarButtonItem *viewImageButton = [[UIBarButtonItem alloc] initWithTitle:@"View" style:UIBarButtonItemStylePlain target:self action:@selector(viewImageButtonPressed:)];
	self.navigationItem.rightBarButtonItem = viewImageButton;
	
	NSLog(@"viewDidLoad fired in PatternDetailTableViewControlleriPad");
	
}

-(void)viewImageButtonPressed:(id)sender {
	
	PatternImageViewControlleriPad *patternImageViewController = [[PatternImageViewControlleriPad alloc] initWithNibName:@"PatternImageViewControlleriPad" bundle:nil];
	
	//Pass the image ref for "thePattern" to the ivar in the PatternImageViewController, "thePatternForImageView".
	patternImageViewController.thePatternForImageView = self.thePattern;
	
    //Pass the value of the selected row to the default image so we can select the right b&w image in
    //the switch statement of the patternImageViewController.
    patternImageViewController.defaultImage = selectedRow;
    
    //Pass the value of mySelectedSegment to the patternImageViewController.
    NSLog(@"the value of mySelectedSegment in PatternDetailTableViewControlleriPad is %d", self.mySelectedSegment);
    if (self.mySelectedSegment == -1) {
        patternImageViewController.selectedSegment = 0;
    }
    
    else {
        patternImageViewController.selectedSegment = self.mySelectedSegment;

    }
    
	// Configure the PatternImageViewControlleriPad. In this case, it reports any
	// changes to a custom delegate object.
	patternImageViewController.delegate = self;
	
	// Create the navigation controller and present it modally.
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:patternImageViewController];
	navigationController.navigationBar.barStyle = UIBarStyleBlack;
	navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:navigationController animated:YES];
	
	// The navigation controller is now owned by the current view controller
	// and the patternImageViewController is owned by the navigation controller,
	// so both objects should be released to prevent over-retention.
}

 

//Created this method to update the table when a pattern is selected in the rootView. Otherwise, the
//table shows the maneuvers for pattern 1 that was set up in 
-(void)loadNewPattern:(Pattern *)pattern {
	
	self.thePattern = pattern;
    NSLog(@"the value of thePattern in the iPad's loadNewPattern method is %@", self.thePattern);
	
	//This put the name of the pattern that was selected in the popover in the middle of the nav bar.
	self.navigationItem.title = self.thePattern.name;
	
	self.fetchedResultsController = nil;
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail		
	}
	
	[self.tableView reloadData];
    
    NSLog(@"loadNewPattern fired in the patternDetailTableViewControlleriPad");
}

//This is a delegate method from the PatternImageViewControlleriPad.
- (void)dismissPatternImageView {
	
	[self dismissModalViewControllerAnimated:YES];
	NSLog(@"dismissPatternImageView in PatternDetailTableViewControlleriPad fired");
}

//This is a delegate method from the PatternImageViewControlleriPad.
- (void)recordSelectedSegment:(NSInteger)theSelectedSegment {
    
    self.mySelectedSegment = theSelectedSegment;
}



#pragma mark -
#pragma mark Split view support

- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{  
	[barButtonItem setTitle:@"NRHA Patterns"];
	[[self navigationItem] setLeftBarButtonItem:barButtonItem];
	[self setPopoverController:pc];
}


- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	[[self navigationItem] setLeftBarButtonItem:nil];
	[self setPopoverController:nil];
}



- (void)viewWillAppear:(BOOL)animated {
	
	NSLog(@"viewWillAppear fired in the PatternDetailTableViewControlleriPad");
	[super viewWillAppear:animated];
	
	//From CoreDataBooks
	[self.tableView reloadData];	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
    */
    
    PatternDetailTableViewCelliPad *cell = (PatternDetailTableViewCelliPad *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"PatternDetailTableViewCelliPad" owner:self options:nil];
		cell = patternDetailTableViewCell;
		self.patternDetailTableViewCell = nil;
	}
    
	// Configure the cell.
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
	
}

- (void)configureCell:(PatternDetailTableViewCelliPad *)cell atIndexPath:(NSIndexPath *)indexPath {
	
    // Configure the cell to show the maneuver's name
	Maneuver *maneuver = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.maneuverName.text = maneuver.name;
	
	//I am setting the cell background color to white in all of the iPad table view cells.
	//For some reason, the cell is kind of gray otherwise (noticable with the maneuverImage in the cell).
	cell.backgroundColor = [UIColor	whiteColor];
	
	//New way of doing this?
	UIImage *aManeuverImage = [UIImage imageNamed:[maneuver maneuverImageRef]];
	cell.maneuverImageView.image = aManeuverImage;
	cell.maneuverDescription.text = maneuver.maneuverDescription;
    
    if ([maneuver.notes length] == 0) {
		cell.noteIconView.hidden = YES;
	}
	
	else {
		cell.noteIconView.hidden = NO;
	}
}

- (void)configureLegend:(NSIndexPath *)rowInteger {
    
    //self.tableView.tableHeaderView = self.headerView;
    //self.smallPatternView.image = [UIImage imageNamed:[self.thePattern imageRef]];
    selectedRow = [rowInteger row];
    
    switch (selectedRow) {
        case 0:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern1.png"];

            break;
        case 1:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern2.png"];

            break;
        case 2:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern3.png"];

            break;
        case 3:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern4.png"];

            break;
        case 4:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern5.png"];

            break;
        case 5:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern6.png"];

            break;
        case 6:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern7.png"];

            break;
        case 7:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern8.png"];

            break;
        case 8:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern9.png"];

            break;
        case 9:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern10.png"];

            break;
        case 10:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern11.png"];

            break;
        case 11:
            self.smallPatternView.image = [UIImage imageNamed:@"Small_Horizontal_Pattern12.png"];

        default:
            break;
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	ManeuverDetailTableViewControlleriPad *maneuverDetailTableViewController = [[ManeuverDetailTableViewControlleriPad alloc] initWithNibName:@"ManeuverDetailTableViewControlleriPad" bundle:nil];
	
	//Make sure the next viewController has the same context.
	maneuverDetailTableViewController.managedObjectContext = self.managedObjectContext;
	
	//Pass the maneuver that was selected in the table to the ivar in the next controller.
	maneuverDetailTableViewController.theManeuver = [fetchedResultsController objectAtIndexPath:indexPath];
	
	[self.navigationController pushViewController:maneuverDetailTableViewController animated:YES];
	
}

#pragma mark -
#pragma mark Fetched results controller

/**
 Returns the fetched results controller. Creates and configures the controller if necessary. Added by JH
 */

- (NSFetchedResultsController *)fetchedResultsController {
	
	if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
	// Create and configure a fetch request with the Maneuver entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Maneuver" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	//The predicate is not in the CoreDataBooks example, but I need it here.
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"pattern == %@", thePattern];
	[fetchRequest setPredicate:pred];
	
	// Create the sort descriptors array. We have only one sort descriptor in the array.
	NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pattern" ascending:YES];
	//Without this descriptor, the cells have all the maneuvers in them but they are not ordered from one
	//to twelve like they should be. I need this "name" descriptor to get it to do that correctly.
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nameDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	self.fetchedResultsController = aFetchedResultsController;
	fetchedResultsController.delegate = self;
	
	// Memory management.
	
	return fetchedResultsController;
    
}    


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    [self reloadInputViews];
    NSLog(@"applicationDidReceiveMemoryWarning called in PatternDetailTableViewControlleriPad");
    
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.toolbar = nil;
//I don't nil these out because viewDidUnload is called during a low memory warning, and if these
//are nil then the tableview will be blank and the popover will not dismiss on a selection.
	//self.thePattern = nil;
	//self.popoverController = nil;
	self.tableViewBackground = nil;
	self.maneuverImage = nil;
    self.headerView = nil;
    self.smallPatternView = nil;
    self.patternDetailTableViewCell = nil;
	self.fetchedResultsController = nil;
}




@end

