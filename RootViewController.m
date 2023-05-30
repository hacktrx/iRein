//
//  RootViewController.m
//  iRein
//
//  Created by Justin Hackett on 2/3/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "RootViewController.h"
#import "PatternDetailTableViewControlleriPad.h"
#import "PatternImageViewControlleriPad.h"
#import "Pattern.h"

@interface RootViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation RootViewController

@synthesize patternDetailTableViewControlleriPad;
@synthesize patterns;
@synthesize patternsArray;
@synthesize selectedPattern;
@synthesize managedObjectContext;
@synthesize splitViewController;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)initWithStyle:(UITableViewStyle)style
{ // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self != nil)
	{
		// any further customizations here
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 550.0);
	
	//This works using a fetch request.
	NSError *error;
	//Create a fetch request and an entity description to get the correct entity.
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Pattern" inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entityDescription];
	
	self.patterns = [self.managedObjectContext executeFetchRequest:request error:&error];
	
	self.patternsArray = self.patterns;
	
	self.patternDetailTableViewControlleriPad.managedObjectContext = self.managedObjectContext;	

	//I added this to give the controller a pattern to load on app launch.
	self.patternDetailTableViewControlleriPad.thePattern = [self.patternsArray objectAtIndex:0];
		

}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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

#pragma mark -
#pragma mark Rotation Support

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
    return 12;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    	
	// Configure the cell.
	[self configureCell:cell atIndexPath:indexPath];
	
    return cell;
	
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	NSInteger row = [indexPath row];
	
	Pattern *aPattern = [self.patterns objectAtIndex:row];
	NSLog(@"The object at index:row of the *patterns NSArray is %@", aPattern.name);		
	
	cell.textLabel.text = aPattern.name;
	
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
		
    NSLog(@"the start of didSelectRowAtIndex fired in RootViewControlleriPad");
    
		//If we are picking a pattern while showing a list of maneuvers in the detail view we pass in the
		//new pattern, load it, and dismiss the popover (since in portrait the popover will be available).
		if (self.patternDetailTableViewControlleriPad.navigationController.topViewController == self.patternDetailTableViewControlleriPad) {
			
        NSLog(@"The patternDetailTableViewControlleriPad is the topViewController in the nav stack");  
            
		//Put the selected picker row into a row variable then use that row to select which pattern in the "patterns" array
		//to pass to the "selectedPattern" variable.
		NSInteger row = [indexPath row];
		self.selectedPattern = [self.patternsArray objectAtIndex:row];
		[self.patternDetailTableViewControlleriPad loadNewPattern:selectedPattern];
            
         //Pass the integer of the row to the detailTableViewController, and from there we'll set the defaultInteger
         //variable of the PatternImageViewController.
         patternDetailTableViewControlleriPad.selectedRow = row;
            
        //This will pass the indexPath into this method which sets the correct small image in the legend.
        [patternDetailTableViewControlleriPad configureLegend:indexPath];

		//This will dismiss the popover when a row is selected.
		[self.patternDetailTableViewControlleriPad.popoverController dismissPopoverAnimated:YES];
        
            NSLog(@"patternDetailTableViewControlleriPad's identity is %@", self.patternDetailTableViewControlleriPad);
		}
	
	//If we are not showing the list of maneuvers, that means we must be showing a maneuver detail. So, we
	//do not have the popover button available. In this case we need to pop to the root view controller first,
	//and then pass in the selected pattern and load it. There will not be a popover to dismiss this time.
	else {
		
		[self.patternDetailTableViewControlleriPad.navigationController popToRootViewControllerAnimated:YES];
		
		NSInteger row = [indexPath row];
		self.selectedPattern = [self.patternsArray objectAtIndex:row];
		
		[self.patternDetailTableViewControlleriPad loadNewPattern:selectedPattern];
        
        //It seems I don't need this method here. So I'll leave it out until I find something wrong with it.
        //Pass the integer of the row to the detailTableViewController, and from there we'll set the defaultInteger
        //variable of the PatternImageViewController.
        //patternDetailTableViewControlleriPad.selectedRow = row;
        
        //This will pass the indexPath into this method which sets the correct small image in the legend.
        [patternDetailTableViewControlleriPad configureLegend:indexPath];
        
        NSLog(@"The patternDetailTableViewControlleriPad is not the topViewController in the nav stack");    

	}
    
    NSLog(@"didSelectRowForIndex fired in RootViewController");

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
   
    NSLog(@"Did receive memory warning fired in RootViewController");
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.patterns = nil;
	self.patternsArray = nil;
	self.selectedPattern = nil;
//Can't nil this out because it messes up the ability to select patterns after a low memory warning
//has caused this viewDidUnload method to fire.
	//self.patternDetailTableViewControlleriPad = nil;
    self.splitViewController = nil;
	[super viewDidUnload];
}




@end

