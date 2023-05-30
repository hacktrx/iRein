//
//  ManeuverDetailTableViewControlleriPad.m
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "ManeuverDetailTableViewControlleriPad.h"
#import "PatternNotesViewControlleriPad.h"
#import "Pattern.h"
#import "Maneuver.h"
#import "ManeuverDetailTableCell.h"

/*
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 108.0f
#define CELL_CONTENT_MARGIN 10.0f
*/

@implementation ManeuverDetailTableViewControlleriPad

@synthesize managedObjectContext;
@synthesize aPattern;
@synthesize theManeuver;
@synthesize maneuverDetailTableCell;
@synthesize tableViewBackground;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;

	//Implement this to add the viewImage button to the right side of the navigation bar.
	UIBarButtonItem *viewImageButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editNotesButtonPressed:)];
	self.navigationItem.rightBarButtonItem = viewImageButton;
	
	//Not sure how this works, but putting this here makes my popover the correct size.
	//I know why it should work in the RootViewController class, but not so sure about here.
	self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	//Since I want a title on the nav bar I can do this.
	UINavigationItem *navigationItem = self.navigationItem;
	navigationItem.title = self.theManeuver.name;
	
	self.tableView.backgroundView = self.tableViewBackground;
	self.tableView.allowsSelection = NO;
}


-(void)editNotesButtonPressed:(id)sender {
	
	 //This would otherwise go in the method for didSelectRow method when a cell has been selected.
	 // Create the root view controller for the navigation controller
	 // The new view controller configures a Cancel and Done button for the
	 // navigation bar.
	 PatternNotesViewControlleriPad *patternNotesViewController = [[PatternNotesViewControlleriPad alloc] initWithNibName:@"PatternNotesViewControlleriPad" bundle:nil];
	 patternNotesViewController.managedObjectContext = self.managedObjectContext;
	 patternNotesViewController.maneuver = self.theManeuver;
	 
	 // Configure the PatternNotesViewControlleriPad. In this case, it reports any
	 // changes to a custom delegate object.
	 patternNotesViewController.delegate = self;
	 
	 // Create the navigation controller and present it modally.
	 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:patternNotesViewController];
	navigationController.navigationBar.barStyle = UIBarStyleBlack; 
	navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
	 [self presentModalViewController:navigationController animated:YES];
	 
	 // The navigation controller is now owned by the current view controller
	 // and the patternNotesViewController is owned by the navigation controller,
	 // so both objects should be released to prevent over-retention.
	 
}	
	

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
	
	//This works to determine if no text was written in the note. If you change the return 2 to
	//return 1, then you can have it so that when there is no note there is no cell. I am currently
	//having the cell display some placeholder text saying "Select Edit to add your custom note".
	if ([theManeuver.notes length] == 0) {
		return 2;
	}
	
	else {
		return 2;
	}
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
	//Create a new ManeuverDetailTableCell if necessary
    ManeuverDetailTableCell *cell = (ManeuverDetailTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"ManeuverDetailTableCell" owner:self options:nil];
		cell = maneuverDetailTableCell;
		self.maneuverDetailTableCell = nil;
	}
			

	if (indexPath.row == 0) {
		
		//I am setting the cell background color to white in all of the iPad table view cells.
		//For some reason, the cell is kind of gray otherwise (noticable with the maneuverImage in the cell).
		cell.backgroundColor = [UIColor	whiteColor];

		[cell setNewCellText:theManeuver.maneuverDescription];
		cell.myCellText.font = [UIFont systemFontOfSize:19];
	}
	
	if (indexPath.row == 1) {
		
		cell.backgroundColor = [UIColor darkGrayColor];
		cell.myCellText.textColor = [UIColor whiteColor];
		
		if ([theManeuver.notes length] == 0) {
		
		cell.myCellText.textColor = [UIColor grayColor];
		[cell setNewCellText:@"(Push Edit to add custom note for this maneuver)"];
			
		}
		
		else {
			cell.myCellText.textColor = [UIColor whiteColor];
			NSString *theNotes = theManeuver.notes;
			[cell setNewCellText:theNotes];
		}

	}
	
	return cell;
	
}



- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
	
	if (indexPath.row == 0) {
				
		NSString *text = theManeuver.maneuverDescription;
		
		CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(700, 2000)];
		NSLog(@"%f", textSize.height);
		return (CGFloat) (60.0 + textSize.height);
		
	}
	
	
	if (indexPath.row == 1) {
		NSString *text = theManeuver.notes;
		CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(700, 2000)];
		NSLog(@"%f", textSize.height);
		return (CGFloat) (60.0 + textSize.height);
		
	}
	
	return (CGFloat) 60;
	
}




/*
- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
	
	if (indexPath.row == 0) {
		NSString *text = theManeuver.maneuverDescription;
		CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(150, 2000)];
		NSLog(@"%f", textSize.height);
		return (CGFloat) (80.0 + textSize.height);

	}
	
	
	if (indexPath.row == 1) {
		NSString *text = theManeuver.notes;
		CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(150, 2000)];
		NSLog(@"%f", textSize.height);
		return (CGFloat) (80.0 + textSize.height);

	}
	
	return (CGFloat) 80;

}
*/


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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    	
}
*/

- (void)patternNotesViewControlleriPad:(PatternNotesViewControlleriPad *)patternNotesViewControlleriPad didChangeNoteForManeuver:(Maneuver *)maneuver {
	
	if (maneuver) {
		
		[self.tableView reloadData];
	}
	
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.aPattern = nil;
	self.theManeuver = nil;
	self.maneuverDetailTableCell = nil;
	self.tableViewBackground = nil;
	NSLog(@"viewDidUnload fired in ManeuverDetailTableViewControlleriPad.");

}


- (void)dealloc {
	NSLog(@"dealloc fired in ManeuverDetailTableViewControlleriPad.");}


@end

