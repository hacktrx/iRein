//
//  NoteDetailTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 7/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "NoteDetailTableViewController.h"
#import "Note.h"
#import "Pattern.h"
#import "Maneuver.h"
//#import "SelectionTableViewController.h"

NSString *kNoteEditSegue = @"noteEditSegue"; //Seque to note editing sheet.

@interface NoteDetailTableViewController ()

@property (strong, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (strong, nonatomic) IBOutlet UILabel *patternLabel;
@property (strong, nonatomic) IBOutlet UILabel *maneuverLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) Pattern *selectedPattern;
@property (strong, nonatomic) Maneuver *selectedManeuver;
@property (strong, nonatomic) IBOutlet SelectionTableViewController *mySelectionTableViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation NoteDetailTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize myNewNote;
@synthesize selectedRow;
@synthesize noteTitleTextField;
@synthesize patternLabel;
@synthesize maneuverLabel;
@synthesize dateLabel;
@synthesize noteTextView;
@synthesize selectedPattern;
@synthesize mySelectionTableViewController;
@synthesize doneButton;

#define NOTE_DETAIL_SECTION 0
#define NOTE_TEXT_SECTION 1

//TODO: Do A Fetch
//Need to fetch the note based on the table cell selection in the previous class. I don't have a fetchedResultsController
//yet or anything. Have to update this.

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
    listManeuvers = NO;
    
    noteTitleTextField.delegate = self;
    noteTextView.delegate = self;
    
    [self.noteTitleTextField becomeFirstResponder];

//TODO:Trying to figure out a way to make them select a pattern first. This doesn't work like I thought.
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    cell.hidden = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source

/*
- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
	
    // Configure the cell...
    Maneuver *maneuver = [self.fetchedResultsController objectAtIndexPath:indexPath];
	self.myManeuverText = maneuver.maneuverDescription;
    CGFloat theCellHeight = [self getHeightByWidthForString:myManeuverText forFont:[UIFont systemFontOfSize:14] forWidth:260];
    float adderFloat = 60;
    
    return theCellHeight + adderFloat;
    
}



-(float)getHeightByWidthForString:(NSString *)myString forFont:(UIFont *)mySize forWidth:(int)myWidth {
    
    CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
    CGSize requiredSize = [myString sizeWithFont:mySize constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
    
    NSLog(@"The requiredSize.height is %f", requiredSize.height);
    return requiredSize.height;
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.patternLabel.text isEqualToString:@"Pattern"]) {
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 0;
    }
    }
    
    else {
        
        if (section == 0) {
            return 2;
        }
        
        if (section == 1) {
            return 1;
        }
        
    }

    return nil;
    
}

#pragma mark -
#pragma mark Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"PatternSelectionSegue"]) {
        
        SelectionTableViewController *selectionTableViewController = [segue destinationViewController];
        self.mySelectionTableViewController = selectionTableViewController;
        self.mySelectionTableViewController.delegate = self;
        self.mySelectionTableViewController.managedObjectContext = self.managedObjectContext;
        self.mySelectionTableViewController.myEntity = @"Pattern";
        self.mySelectionTableViewController.mySortDescriptor = @"patternNumber";
        self.mySelectionTableViewController.noteDetailTableViewController = self;
        self.mySelectionTableViewController.listManeuvers = NO;
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        
        [segue destinationViewController];
        
    }

    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//TODO:Get rid of all this:
    /*
    if ([[segue identifier] isEqualToString:@"ManeuverSelectionSegue"]) {
        
        SelectionTableViewController *selectionTableViewController = [segue destinationViewController];
        self.mySelectionTableViewController = selectionTableViewController;
        self.mySelectionTableViewController.delegate = self;
        self.mySelectionTableViewController.managedObjectContext = self.managedObjectContext;
        self.mySelectionTableViewController.noteDetailTableViewController = self;
        self.mySelectionTableViewController.listManeuvers = YES;
        self.mySelectionTableViewController.fetchedResultsController = nil;
        self.mySelectionTableViewController.selectedPattern = self.selectedPattern;
        
        [segue destinationViewController];
    }
    */

}


-(IBAction)myCancelButtonPushed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];

}

-(IBAction)myDoneButtonPushed:(id)sender {

    Note *theNewNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    self.myNewNote = theNewNote;
    
    
    self.myNewNote.title = self.noteTitleTextField.text;
    self.myNewNote.text = self.noteTextView.text;
    self.myNewNote.pattern = self.selectedPattern;

//TODO:Get rid of this.
    //self.myNewNote.maneuver = self.selectedManeuver;
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateStyle:@"yyyy-MM-dd"];
    NSDate *myCurrentDate = [NSDate date];
    self.myNewNote.date = myCurrentDate;
    
		NSManagedObjectContext *context = self.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
            
            //Replace this implementation with code to handle the error appropriately.
            
            //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
            
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
        
        [self.delegate didSaveManagedObjectContext:self.managedObjectContext];
        [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark -
#pragma mark SelectionTableViewController Delegate Methods

-(void)didSelectPattern:(Pattern *)pattern {

    self.patternLabel.text = pattern.name;
    self.selectedPattern = pattern;
    listManeuvers = YES;
    mySelectionTableViewController.selectedPattern = pattern;
    self.maneuverLabel.hidden = NO;
    self.noteTextView.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:Nil];
    NSLog(@"didSelectPattern fired in SelectionTableViewController");
    
    [self.tableView reloadData];
}


//TODO:Get rid of this:
-(void)didSelectManeuver:(Maneuver *)maneuver {
    
    self.maneuverLabel.text = maneuver.name;
    self.selectedManeuver = maneuver;
    listManeuvers = YES;
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    NSLog(@"didSelectManeuver fired in SelectionTableViewController");

}




#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.noteTitleTextField) {
    
	[textField resignFirstResponder];
    }
    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.doneButton.enabled = YES;
}



#pragma mark - UITextView Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.doneButton.enabled = YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if ([self.noteTextView isFirstResponder] && [touch view] != self.noteTextView) {
        
        [self.noteTextView resignFirstResponder];
    }
    // My comment : If you have several text controls copy/paste/modify a block above and you are DONE!
}


#pragma mark -
#pragma mark Editing
/*
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.tableView beginUpdates];
    if(editing == YES)
    {
        // Your code for entering edit mode goes here
        [self.noteTitleTextField becomeFirstResponder];
        NSLog(@"Entering edit mode");
        
    } else {
        // Your code for exiting edit mode goes here
        NSLog(@"Not in editing mode");
    }
    
	self.noteTitleTextField.enabled = editing;
	self.patternLabel.enabled = editing;
	self.maneuverLabel.enabled = editing;
	[self.navigationItem setHidesBackButton:editing animated:YES];
	
    [self.tableView endUpdates];
  */
	
    /*
     
     NSUInteger ingredientsCount = [recipe.ingredients count];
     
     NSArray *ingredientsInsertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:ingredientsCount inSection:INGREDIENTS_SECTION]];
     
     if (editing) {
     [self.tableView insertRowsAtIndexPaths:ingredientsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
     overviewTextField.placeholder = @"Overview";
     } else {
     [self.tableView deleteRowsAtIndexPaths:ingredientsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
     overviewTextField.placeholder = @"";
     }
     
     [self.tableView endUpdates];
     */
    
    //If editing is finished, save the managed object context.
/*
	if (!editing) {
		NSManagedObjectContext *context = self.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
            
            //Replace this implementation with code to handle the error appropriately.
            
            //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
            
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
        
        [self.delegate didSaveManagedObjectContext:self.managedObjectContext];
	}

}
*/


// Override to support editing the table view.
//Asks the data source to commit the insertion or deletion of a specified row in the receiver.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Editing style is ...StyleDelete");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        NSLog(@"Editing style is ...StyleInsert");
    }
}
*/


 /*
 - (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
 
 if (textField == nameTextField) {
 recipe.name = nameTextField.text;
 self.navigationItem.title = recipe.name;
 }
 else if (textField == overviewTextField) {
 recipe.overview = overviewTextField.text;
 }
 else if (textField == prepTimeTextField) {
 recipe.prepTime = prepTimeTextField.text;
 }
 return YES;
 }
 
 
 
*/



@end
