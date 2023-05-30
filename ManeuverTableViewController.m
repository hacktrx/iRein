//
//  ManeuverTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 7/10/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "ManeuverTableViewController.h"
#import "PatternNotesViewController.h"
#import "Pattern.h"
#import "Maneuver.h"
#import "ManeuverCell.h"
#import "BlackAndWhiteCell.h"

@interface ManeuverTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) IBOutlet UIImageView *tableViewBackground;
@property (nonatomic, strong) UIImage *maneuverImage;
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UIImageView *smallPatternView;
@property (nonatomic, strong) NSString *myManeuverText;
@property (nonatomic, assign) float myCellHeight;
@property (nonatomic, strong) IBOutlet UILabel *patternNumber;
@property (nonatomic, strong) UIImage *patternImage;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (float)getHeightByWidthForString:(NSString *)myString forFont:(UIFont *)mySize forWidth:(int)myWidth;
- (void)loadBlackPatternImage:(NSInteger)rowNumber;


@end

@implementation ManeuverTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize selectedPattern;
@synthesize tableViewBackground;
@synthesize maneuverImage;
@synthesize headerView;
@synthesize smallPatternView;
@synthesize selectedRow;
@synthesize mySelectedSegment;
@synthesize myManeuverText;
@synthesize myCellHeight;
@synthesize patternNumber;
@synthesize patternImage;



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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Don't have a section header, this is a plain table, not a grouped table.
    //self.tableView.tableHeaderView = self.headerView;
    //self.smallPatternView.image = [UIImage imageNamed:[self.thePattern imageRef]];
    //self.tableView.sectionHeaderHeight = 10;
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		//Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    // Configure the navigation bar. Can't do this with the segmented control in the nav bar.
    self.navigationItem.title = [NSString stringWithFormat:@"NRHA %@", self.selectedPattern.name];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"Number of ojbects in the fetchRequest is %i", [[self.fetchedResultsController sections] count]);
    // Return the number of sections.
    //return [[fetchedResultsController sections] count];
	return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"The number of cell rows is %d", [sectionInfo numberOfObjects]);
    
	return [sectionInfo numberOfObjects];
    
    //return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.smallPatternView.image = [UIImage imageNamed:[self.thePattern imageRef]];

        if (mySelectedSegment == 0) {
            
            static NSString *kBlackAndWhiteCellID = @"BlackAndWhiteManeuverCell";
            BlackAndWhiteCell *cell = (BlackAndWhiteCell *)[tableView dequeueReusableCellWithIdentifier:kBlackAndWhiteCellID];
           [self configureCell:cell atIndexPath:indexPath];
            self.tableView.separatorColor = [UIColor clearColor];
            return cell;
            
        }
        
        
        if (mySelectedSegment == 1) {
            
            static NSString *kManeuverCellID = @"ManeuverCell";
            ManeuverCell *cell = (ManeuverCell *)[tableView dequeueReusableCellWithIdentifier:kManeuverCellID];
            [self configureCell:cell atIndexPath:indexPath];
            self.tableView.separatorColor = [UIColor clearColor];
            return cell;
        }
    
    return nil;
}


- (void)configureCell:(ManeuverCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    //Using this for the height method of the cell.
    //self.myManeuverText = maneuver.maneuverDescription;
    
    //Hide the maneuver name for the black and white pattern's list of maneuvers.
    if (mySelectedSegment == 0) {
        
        Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.maneuverDescription.text = maneuver.maneuverDescription;
    }

    if (mySelectedSegment == 1) {
        
        Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.maneuverName.text = maneuver.name;
        cell.maneuverDescription.text = maneuver.maneuverDescription;
        UIImage *aManeuverImage = [UIImage imageNamed:[maneuver maneuverImageRef]];
        cell.maneuverImageView.image = aManeuverImage;
        //cell.maneuverName.center = CGPointMake(105, 25);
    }
    
    NSLog(@"thePattern in patternDetailViewControlleriPhone is %@", self.selectedPattern.name);
    NSLog(@"The managed object context in patternDetailViewControlleriPhone is %@", self.managedObjectContext);
    NSLog(@"The indexPath is %@, and the indexPath.row is %d", indexPath, indexPath.row);
    
    //myCellHeight = [self getHeightByWidth:myManeuverText :[UIFont systemFontOfSize:14] :260];
    
    //NSLog(@"My myCellHeight is %f", myCellHeight);
    
    /*
     if ([maneuver.notes length] == 0) {
     cell.noteIconView.hidden = YES;
     }
     
     else {
     cell.noteIconView.hidden = NO;
     }
     NSLog(@"This maneuver's note says %@", maneuver.notes);
     */
    
    //Added this for a test.
    //The answer to the question in the snapshot for this is no, it doesn't edit the relationship in the sql file
    //just because the relationship has been fetched. It still shows wrong in the sql file, but when the fetch is
    //is done it returns the correct notes for the maneuver and the correct pattern. I don't know why, but it does.
    //I will take a new snap and make a note of it.
    /*
     if ([maneuver.notes length] == 0) {
     //cell.noteIconView.hidden = YES;
     cell.backgroundColor = [UIColor grayColor];
     }
     
     else {
     //cell.noteIconView.hidden = NO;
     cell.backgroundColor = [UIColor redColor];
     
     }
     NSLog(@"This maneuver's note says %@", maneuver.notes);
     */
    
}


- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
	
    if (mySelectedSegment == 0) {
        
        // Configure the cell...
        Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        self.myManeuverText = maneuver.maneuverDescription;
        
        CGFloat theCellHeight = [self getHeightByWidthForString:myManeuverText forFont:[UIFont systemFontOfSize:14] forWidth:160];
        float adderFloat = 5;

        return theCellHeight + adderFloat;
    }
    
    if (mySelectedSegment == 1) {
        
        // Configure the cell...
        Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
        self.myManeuverText = maneuver.maneuverDescription;

        CGFloat theCellHeight = [self getHeightByWidthForString:myManeuverText forFont:[UIFont systemFontOfSize:14] forWidth:140];
        float adderFloat = 40;
        
        return theCellHeight + adderFloat;
    }

    return 0;
    
}


//TODO:FIX OR MAKE SURE THIS IS RIGHT.
-(float)getHeightByWidthForString:(NSString *)myString forFont:(UIFont *)mySize forWidth:(int)myWidth {

//Used a new boundingRectWithSize method here.
    CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
    CGRect requiredSize = [myString boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    NSLog(@"The requiredSize.height is %f", requiredSize.size.height);
    return requiredSize.size.height;
    
}


/*
 Got this method style from a webpage that uses a different way that doesn't rely on the deprecated method I used above.
 -(float)getHeightByWidthForString:(NSString *)myString forFont:(UIFont *)mySize forWidth:(int)myWidth {
 
 //CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
 
 
 // NSMutableDictionary *myTextAttributes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
 // colorOfText,NSForegroundColorAttributeName,
 // [NSFont systemFontOfSize:11.0],NSFontAttributeName,
 // dParagraphStyle, NSParagraphStyleAttributeName,
 // nil];
 
 
 // setting attributes of cell text
 NSMutableParagraphStyle *dParagraphStyle = [[NSMutableParagraphStyle alloc] init];
 [dParagraphStyle setAlignment:kCTLeftTextAlignment];
 
 NSMutableDictionary *myTextAttributes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
 dParagraphStyle, NSParagraphStyleAttributeName,
 nil];
 
 // getting sizes
 CGSize requiredSize = [myString sizeWithAttributes:myTextAttributes];
 
 NSLog(@"The requiredSize.height is %f", requiredSize.height);
 return requiredSize.height;
 
 //[myString boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
 
 }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}



//Taken from the iPad version. Commented out in the .h file too.
/*
-(void)viewImageButtonPressed:(id)sender {
     
     PatternImageViewController *patternImageViewController = [[PatternImageViewController alloc] initWithNibName:@"PatternImageViewController" bundle:nil];
     
     //Pass the image ref for "thePattern" to the ivar in the PatternImageViewController, "thePatternForImageView".
     patternImageViewController.thePatternForImageView = self.selectedPattern;
     
     //Pass the value of the selected row to the default image so we can select the right pattern image in
     //the switch statement of the patternImageViewController.
     patternImageViewController.defaultImage = selectedRow;
     
     //Pass the value of mySelectedSegment to the patternImageViewController.
     if (self.mySelectedSegment == -1) {
     patternImageViewController.selectedSegment = 0;
     }
     
     else {
     patternImageViewController.selectedSegment = self.mySelectedSegment;
     
     }
     
     // Configure the PatternImageViewController. In this case, it reports any
     // changes to a custom delegate object.
     //`patternImageViewController.delegate = self;
     
     // Create the navigation controller and present it modally.
     UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:patternImageViewController];
     navigationController.navigationBar.barStyle = UIBarStyleBlack;
     navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     [self presentModalViewController:navigationController animated:YES];
     
     // The navigation controller is now owned by the current view controller
     // and the patternImageViewController is owned by the navigation controller,
     // so both objects should be released to prevent over-retention.
     [patternImageViewController release];
     [navigationController release];
     
     */
    
    /*
     //Set the defaultImage ivar in the PatternImageViewController so we can choose the b&w image in the switch
     //statement in the PatternImageViewController.
     PatternImageViewController *patternImageViewController = [[PatternImageViewController alloc] initWithNibName:@"PatternImageViewController" bundle:nil];
     patternImageViewController.defaultImage = row;
     NSLog(@"The value of defaultImage in the PatternPickerViewController is %d", patternImageViewController.defaultImage);
     [patternImageViewController release];
     
}
*/


/*
 //This is a delegate method from the PatternImageViewControlleriPad.
 - (void)dismissPatternImageView {
 
 [self dismissModalViewControllerAnimated:YES];
 NSLog(@"dismissPatternImageView in PatternDetailTableViewController fired");
 }
 */

/*
 //This is a delegate method from the PatternImageViewController.
 - (void)recordSelectedSegment:(NSInteger)theSelectedSegment {
 
 self.mySelectedSegment = theSelectedSegment;
 }
 */


//This is commented out in the .h file too.
//-(IBAction)patternImageClicked:(id)sender {

//}



#pragma mark -
#pragma mark - Private Methods


-(void)loadBlackPatternImage:(NSInteger)rowNumber {
    
    //int clickedSegment = [sender selectedSegmentIndex];
    //self.selectedSegment = [sender selectedSegmentIndex];
    
    //NSLog(@"The value of defaultImage is %d", defaultImage);
    /*
     switch (clickedSegment) {
     case 0:
     self.patternImageView.backgroundColor = [UIColor blackColor];
     self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
     self.patternImageView.image = self.patternImage;
     break;
     case 1:
     self.patternImageView.backgroundColor = [UIColor whiteColor];
     */
    
    switch (rowNumber) {
        case 0:
            self.patternImage = [UIImage imageNamed:@"Pattern_1_Black_Small.png"];
            self.smallPatternView.image = self.patternImage;
            NSLog(@"The smallPatternView image is %@", smallPatternView.image);
            break;
        case 1:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_2_Black_Small.png"];
            break;
        case 2:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_3_Black_Small.png"];
            break;
        case 3:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_4_Black_Small.png"];
            break;
        case 4:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_5_Black_Small.png"];
            break;
        case 5:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_6_Black_Small.png"];
            break;
        case 6:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_7_Black_Small.png"];
            break;
        case 7:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_8_Black_Small.png"];
            break;
        case 8:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_9_Black_Small.png"];
            break;
        case 9:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_10_Black_Small.png"];
            break;
        case 10:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_11_Black_Small.png"];
            break;
        case 11:
            self.smallPatternView.image = [UIImage imageNamed:@"Pattern_12_Black_Small.png"];
            break;
            
        default:
            break;
    }
    
}


#pragma mark -
#pragma mark Fetched results controller

/**
 Returns the fetched results controller. Creates and configures the controller if necessary. Added by JH
 */

- (NSFetchedResultsController *)fetchedResultsController {
	
	if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
	// Create and configure a fetch request with the Maneuver entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Maneuver" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	//The predicate is not in the CoreDataBooks example, but I need it here.
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"pattern == %@", selectedPattern];
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
	
    
	return _fetchedResultsController;
    
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

@end