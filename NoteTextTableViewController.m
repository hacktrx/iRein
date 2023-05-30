//
//  NoteTextTableViewController.m
//  iRein
//
//  Created by Justin Hackett on 7/18/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "NoteTextTableViewController.h"
#import "Note.h"
#import "Pattern.h"
#import "Maneuver.h"

@interface NoteTextTableViewController ()

@property (strong, nonatomic) IBOutlet UILabel *staticNoteTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (strong, nonatomic) IBOutlet UILabel *patternLabel;
//Got rid of this:
//@property (strong, nonatomic) IBOutlet UILabel *maneuverLabel;
@property (strong, nonatomic) IBOutlet UILabel *staticDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) Pattern *selectedPattern;
@property (strong, nonatomic) SelectionTableViewController *mySelectionTableViewController;
@property (strong, nonatomic) IBOutlet UITableViewCell *patternSelectionCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *maneuverSelectionCell;


@end

@implementation NoteTextTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize selectedNote;
//@synthesize selectedRow;
@synthesize noteTitleTextField;
@synthesize patternLabel;
//Got rid of this:
//@synthesize maneuverLabel;
@synthesize dateLabel;
@synthesize noteTextView;
@synthesize selectedPattern;
@synthesize mySelectionTableViewController;
@synthesize patternSelectionCell;
@synthesize maneuverSelectionCell;


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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = self.selectedNote.pattern.name;
    self.selectedPattern = self.selectedNote.pattern;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}


#pragma mark -
#pragma mark Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
//These begin/endUpdate methods need to be here with this code in between otherwise, when the done
//button is pushed the edits that I made do not persist when the table view goes out of editing
//mode. I'm not sure why yet, but it does work that way.
    [self.tableView beginUpdates];
    
    if(editing == YES)
    {
        // Your code for entering edit mode goes here
        self.staticNoteTitleLabel.hidden = editing;
        self.staticDateLabel.hidden = editing;
        self.dateLabel.hidden = editing;
        [self.noteTitleTextField setTextColor:[UIColor colorWithRed:.407 green:.407 blue:.407 alpha:1]];
        [self.noteTextView setTextColor:[UIColor colorWithRed:.407 green:.407 blue:.407 alpha:1]];
    
        self.noteTitleTextField.enabled = editing;
        self.noteTextView.editable = editing;
        self.patternLabel.enabled = editing;
//Got rid of this:
        //self.maneuverLabel.enabled = editing;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [self.navigationItem setHidesBackButton:editing animated:YES];

        [self.noteTitleTextField becomeFirstResponder];

    } else {
        // Your code for exiting edit mode goes here
        self.staticNoteTitleLabel.hidden = editing;
        self.staticDateLabel.hidden = editing;
        self.dateLabel.hidden = editing;
        [self.noteTitleTextField setTextColor:[UIColor blackColor]];
        [self.noteTextView setTextColor:[UIColor blackColor]];

        self.noteTitleTextField.enabled = editing;
        self.noteTextView.editable = editing;
        self.patternLabel.enabled = editing;
//Got rid of this:
        //self.maneuverLabel.enabled = editing;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [self.navigationItem setHidesBackButton:NO animated:YES];
        
            self.selectedNote.pattern.name = self.patternLabel.text;
//Got rid of this:
            //self.selectedNote.maneuver.name = self.maneuverLabel.text;
            NSLog(@"The textField is equal to self.noteTitleTextField");
    }
    
    [self.tableView endUpdates];

    
//Make any insertion/deletion/selection calls inside the beginUpdates block below.
//We currently have none for this class but I'm saving this for later.
    /*
    [self.tableView beginUpdates];
	
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


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - SelectionTableViewController Delegate Methods

-(void)didSelectPattern:(Pattern *)pattern {
    
    self.patternLabel.text = pattern.name;
    self.selectedPattern = pattern;
    self.selectedNote.pattern = pattern;
    listManeuvers = YES;
//Why am I setting this here and in the segue method?
    mySelectionTableViewController.selectedPattern = pattern;
//Got rid of this:
    //self.maneuverLabel.hidden = NO;
    self.noteTextView.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"didSelectPattern fired in NoteTextTableViewController and the notesTableView selectedNote.pattern is %@", self.selectedNote.pattern);

}

-(void)didSelectManeuver:(Maneuver *)maneuver {

//Got rid of this:
    //self.maneuverLabel.text = maneuver.name;
    self.selectedNote.maneuver = maneuver;
    listManeuvers = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"didSelectManeuver fired in NoteTextTableViewController and the notesTableView selectedNote.maneuver is %@", self.selectedNote.maneuver);
    
}


#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn fired.");
	[textField resignFirstResponder];
    //Also put anything here you want to happen when the return button is pushed.
	return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
    NSLog(@"textFieldShouldEndEditing just fired and the textField is %@", textField);
    
	if (textField == self.noteTitleTextField) {
		self.selectedNote.title = self.noteTitleTextField.text;
		self.navigationItem.title = self.selectedNote.title;
        NSLog(@"The textField is equal to self.noteTitleTextField");
	}
    
	return YES;
}

#pragma mark -
#pragma mark UITextView Delegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
	
    NSLog(@"textViewShouldEndEditing just fired and the textView is %@", textView);
    
    if (textView == self.noteTextView) {
        self.selectedNote.text = self.noteTextView.text;
        NSLog(@"The textView is equal to self.noteTextView");
    }
    
	return YES;
}

//Not using these in this application.
/*
- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"textViewDidChangeSelection did fire");
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textViewDidEndEditing did fire");
    
}
*/



#pragma mark -
#pragma mark Editing rows

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"JH - willSelectRowAtIndexPath just fired and the indexPath is %@", indexPath);
	NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
    // If editing, don't allow instructions to be selected
    // Not editing: Only allow instructions to be selected
    
    if ((isEditing && section == NOTE_TEXT_SECTION) || (!isEditing && section != NOTE_TEXT_SECTION)) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;
        NSLog(@"If statement fired in willSelectRowAtIndexPath");
    }
    
	return rowToSelect;
}


/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
*/
    /*
     What to do on selection depends on what section the row is in.
     For Type, Instructions, and Ingredients, create and push a new view controller of the type appropriate for the next screen.
     */
/*
    switch (section) {
        case NOTE_DETAIL_SECTION:
            nextViewController = [[TypeSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((TypeSelectionViewController *)nextViewController).recipe = recipe;
            break;
			
        case NOTE_TEXT_SECTION:
            nextViewController = [[InstructionsViewController alloc] initWithNibName:@"InstructionsView" bundle:nil];
            ((InstructionsViewController *)nextViewController).recipe = recipe;
            break;
*/
		/*
        case INGREDIENTS_SECTION:
            nextViewController = [[IngredientDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((IngredientDetailViewController *)nextViewController).recipe = recipe;
            
            if (indexPath.row < [recipe.ingredients count]) {
                Ingredient *ingredient = [ingredients objectAtIndex:indexPath.row];
                ((IngredientDetailViewController *)nextViewController).ingredient = ingredient;
            }
            break;
          */
/*
        default:
            break;
    }
    
    // If we got a new view controller, push it .
    if (nextViewController) {
        [self.navigationController pushViewController:nextViewController animated:YES];
        [nextViewController release];
    }
}
*/

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//Can use this to tell certain rows or sections how to behave during editing.
    /*
    NSIndexPath *pathOne = [NSIndexPath indexPathForRow:1 inSection:NOTE_DETAIL_SECTION];
    
    if ([indexPath compare:pathOne] == NSOrderedSame) {
        
        return UITableViewCellEditingStyleNone;
    }
    */
    
	UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    
    return style;
}




//If you touch the insert or delete buttons in edit mode, this message is sent to the tableView data source.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     
//Example of some code that can be used in this method.
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     NSLog(@"Editing style is ...StyleDelete");
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     NSLog(@"Editing style is ...StyleInsert");
     }

//Example of some code that can be used in this method.
    // Only allow deletion, and only in the ingredients section
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.section == INGREDIENTS_SECTION)) {
        // Remove the corresponding ingredient object from the recipe's ingredient list and delete the appropriate table view cell.
        Ingredient *ingredient = [ingredients objectAtIndex:indexPath.row];
        [recipe removeIngredientsObject:ingredient];
        [ingredients removeObject:ingredient];
        
        NSManagedObjectContext *context = ingredient.managedObjectContext;
        [context deleteObject:ingredient];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
     
    */
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Not using this since I am using static tableView cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *CellIdentifier = @"NotesCell";
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Note *theNewNote = [self.myOldNotesArray objectAtIndex:indexPath.row];
    
    cell.patternTextLabel.text = [NSString stringWithFormat:@"%@", theNewNote.pattern.name];
    cell.maneuverTextLabel.text = [NSString stringWithFormat:@"%@", theNewNote.maneuver.name];
    cell.noteTitleLabel.text = [NSString stringWithFormat:@"%@", theNewNote.title];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateStyle:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormater stringFromDate:theNewNote.date];
    cell.noteDateLabel.text = dateString;
    
    cell.noteTextLabel.text = theNewNote.text;
    cell.notePatternImageView.image = [UIImage imageNamed:theNewNote.pattern.largeWhiteImageRef];
     
    return cell;
     */
     
//}
     

- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
	NSLog(@"The indexPath is %@", indexPath);
    
    // Configure the cell...
    //Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];

	self.noteTextView.text = self.selectedNote.text;
    self.noteTitleTextField.text = self.selectedNote.title;
    self.patternLabel.text = self.selectedNote.pattern.name;
//Got rid of this:
    //self.maneuverLabel.text = self.selectedNote.maneuver.name;
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateStyle:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormater stringFromDate:self.selectedNote.date];
    self.dateLabel.text = dateString;
    
    NSIndexPath *pathOne = [NSIndexPath indexPathForRow:0 inSection:NOTE_TEXT_SECTION];
    NSIndexPath *pathTwo = [NSIndexPath indexPathForRow:0 inSection:NOTE_DETAIL_SECTION];
    
    if ([indexPath compare:pathOne] == NSOrderedSame) {
        
    CGFloat theCellHeight = [self getHeightByWidthForString:self.noteTextView.text forFont:[UIFont systemFontOfSize:14] forWidth:280];
    float adderFloat = 30;
    
    return theCellHeight + adderFloat;
        
    }
    
    if ([indexPath compare:pathTwo] == NSOrderedSame) {

        if (self.editing) {
            //return 47;
            return 44;

        }
        //return 30;
        return 44;

    }
    
    //return 30;
    return 44;

}


-(float)getHeightByWidthForString:(NSString *)myString forFont:(UIFont *)mySize forWidth:(int)myWidth {
    
    CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
    CGSize requiredSize = [myString sizeWithFont:mySize constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
    
    NSLog(@"The requiredSize.height is %f", requiredSize.height);
    return requiredSize.height;
    
}

#pragma mark -
#pragma mark Moving rows


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"PatternCellEditSegue"]) {
        
        NSLog(@"prepareForSegue just fired for PatternCell segue, the sender is %@", sender);
        
        SelectionTableViewController *selectionTableViewController = [segue destinationViewController];
        self.mySelectionTableViewController = selectionTableViewController;
        self.mySelectionTableViewController.delegate = self;
        self.mySelectionTableViewController.managedObjectContext = self.managedObjectContext;
        self.mySelectionTableViewController.myEntity = @"Pattern";
        self.mySelectionTableViewController.mySortDescriptor = @"patternNumber";
        self.mySelectionTableViewController.noteTextTableViewController = self;
        self.mySelectionTableViewController.listManeuvers = NO;
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        
        [segue destinationViewController];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"ManeuverCellEditSegue"]) {
        
        NSLog(@"prepareForSegue just fired for ManeuverCell segue, the sender is %@", sender);

        SelectionTableViewController *selectionTableViewController = [segue destinationViewController];
        self.mySelectionTableViewController = selectionTableViewController;
        self.mySelectionTableViewController.delegate = self;
        self.mySelectionTableViewController.managedObjectContext = self.managedObjectContext;
        self.mySelectionTableViewController.noteTextTableViewController = self;
        self.mySelectionTableViewController.listManeuvers = YES;
        self.mySelectionTableViewController.fetchedResultsController = nil;
        self.mySelectionTableViewController.selectedPattern = self.selectedPattern;
        
        [segue destinationViewController];
    }
}



@end
