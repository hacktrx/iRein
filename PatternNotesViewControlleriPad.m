    //
//  PatternNotesViewControlleriPad.m
//  iRein
//
//  Created by Justin Hackett on 2/13/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "PatternNotesViewControlleriPad.h"
#import "Pattern.h"
#import "Maneuver.h"

@implementation PatternNotesViewControlleriPad

@synthesize managedObjectContext;
@synthesize pattern;
@synthesize maneuver;
@synthesize notes;
@synthesize delegate;



- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    [super setEditing:editing animated:animated];
	
    notes.editable = editing;
	
	//Don't need this because this view is loaded as a modal view, so there is no back button.
	//[self.navigationItem setHidesBackButton:editing animated:YES];
	
	
	 //If editing is finished, update the maneuver's notes and save the managed object context.
	 
	
	if (!editing) {
		
		self.maneuver.notes = self.notes.text;
		
		NSError *error = nil;
		
		if (![self.managedObjectContext save:&error]) {
			
			 //Replace this implementation with code to handle the error appropriately.
			 
			 //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}

}



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		// Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.notes.text = self.maneuver.notes;
	
	// Configure the navigation bar
    self.navigationItem.title = @"Maneuver Note";

	UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
	
	[notes becomeFirstResponder];
	
	//In the Recipes code they don't have this line???
    [super viewDidLoad];
}

//TODO: Do I need this, or should I use the method in the iPhone version?
/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == notes) {
		[notes resignFirstResponder];
		[self save];
	}
	return YES;
}
*/

- (void)save {
    
	/*
	If the note has two or more characters it will be saved. Also, if it has no characters
	it will fire the save: method on the context, but since we have told the ManeuverDetailTableViewControlleriPad
	to only display one row if there is 0 characters in the maneuver notes object, only one row will be shown.
	*/
	if ([self.notes.text length] >= 2 || [self.notes.text length] == 0) {
	
	self.maneuver.notes = self.notes.text;

	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		
		 //Replace this implementation with code to handle the error appropriately.
		 
		 //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	   }		
    
	}
	
	[self.delegate patternNotesViewControlleriPad:self didChangeNoteForManeuver:maneuver];
}


- (void)cancel {
	
	
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		
		 //Replace this implementation with code to handle the error appropriately.
		 
		 //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	
	[self.delegate patternNotesViewControlleriPad:self didChangeNoteForManeuver:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	
	self.notes = nil;
	self.pattern = nil;
	self.maneuver = nil;
	self.delegate = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
