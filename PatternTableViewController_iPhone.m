//
//  PatternTableViewController_iPhone.m
//  iRein
//
//  Created by Justin Hackett on 9/29/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import "PatternTableViewController_iPhone.h"
#import "AppDelegate_Shared.h"
#import "Pattern.h"
#import "PatternDetailViewControlleriPhone.h"

@interface PatternTableViewController_iPhone ()
    
//@property (nonatomic, strong) PatternDetailViewControlleriPhone *patternDetailViewControlleriPhone;
@property (nonatomic, strong) NSArray *patternsArray;
@property (nonatomic, strong) Pattern *selectedPattern;


@end

@implementation PatternTableViewController_iPhone

@synthesize patternsArray;
@synthesize selectedPattern;
@synthesize managedObjectContext;
//@synthesize patternDetailViewControlleriPhone;


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
    
    //self.navigationController.navigationBar.topItem.title = @"NRHA Patterns";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //This works using a fetch request.
    NSError *error;
    //Create a fetch request and an entity description to get the correct entity.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Pattern" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entityDescription];
    
    
    // Create the sort descriptors array. We have only one sort descriptor in the array.
	NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"patternNumber" ascending:YES];
	//Without this descriptor, the cells have all the maneuvers in them but they are not ordered from one
	//to twelve like they should be. I need this "name" descriptor to get it to do that correctly.
	//NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    
    self.patternsArray = [self.managedObjectContext executeFetchRequest:request error:&error];
        
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PatternCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Pattern *thePattern = [patternsArray objectAtIndex:indexPath.row];
    
    //This has to be assigned here and then used in the prepareForSegue method because the didSelectRowAtIndexPath
    //is never called in the storyboard version. So I assign the selected pattern here, and then pass it in the
    //prepareForSegue method.
    //self.selectedPattern = thePattern;
    
    cell.textLabel.text = thePattern.name;
    
    NSLog(@"The Cell is %@", cell);
    NSLog(@"PatternTableViewController pattern 1 is %@", [patternsArray objectAtIndex:0]);

    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    //Put the selected picker row into a row variable then use that row to select which pattern in the "patterns" array
	//to pass to the "selectedPattern" variable.
    /*
	//NSInteger row = [self.patternPicker selectedRowInComponent:0];
	self.selectedPattern = [self.patternsArray objectAtIndex:indexPath];
	
	NSLog(@"The selected pattern is %@", selectedPattern);
	
	PatternDetailTableViewController *detailTableViewController = [[PatternDetailTableViewController alloc] initWithNibName:@"PatternDetailTableViewController" bundle:nil];
	detailTableViewController.managedObjectContext = self.managedObjectContext;	
	
	//Assign the selectedPattern to be the detailTableViewController's "thePattern" variable. In the detailTableViewController
	//we will load the correct instructions based on the pattern we passed to the controller's "thePattern" ivar.
	detailTableViewController.thePattern = self.selectedPattern;
	
    //Pass the integer of the row to the detailTableViewController, and from there we'll set the defaultInteger
    //variable of the PatternImageViewController.
    detailTableViewController.selectedRow = row;
    
	//Push the next view controller onto the navigation stack.
	[self.navigationController pushViewController:detailTableViewController animated:YES];
	[detailTableViewController release];
	*/  
    
    //self.selectedPattern = [self.patternsArray objectAtIndex:[indexPath row]];
    //id *selectedCellRow = [self.patternsArray objectAtIndex:[indexPath row]];
    
    
    NSLog(@"The selected Pattern in didSelectRowAtIndexPath is %@", selectedPattern.name);
    NSLog(@"The managedObjectContext of the PatternTableViewController is %@", self.managedObjectContext);
    NSLog(@"The selected indexPath.row is %d", indexPath.row);

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        PatternDetailViewControlleriPhone *patternDetailViewControlleriPhone = [segue destinationViewController];
        //self.patternDetailViewControlleriPhone = segue.destinationViewController;
                
        patternDetailViewControlleriPhone.managedObjectContext = self.managedObjectContext;
                
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        patternDetailViewControlleriPhone.selectedRow = path.row;
        NSLog(@"The selectedRow text in PatternTableViewController is %d", path.row);
       
        self.selectedPattern = [patternsArray objectAtIndex:path.row];

        patternDetailViewControlleriPhone.selectedPattern = self.selectedPattern;
    
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        NSLog(@"The selectedPattern in prepareForSegue is %@", self.selectedPattern);
        NSLog(@"The thePattern is %@", patternDetailViewControlleriPhone.selectedPattern);
        
        [segue destinationViewController];
        
    }
}



@end
