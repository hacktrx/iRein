//
//  ManeuverDetailTableViewControlleriPad.h
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PatternNotesViewControlleriPad.h"

@class Pattern;
@class Maneuver;
@class ManeuverDetailTableCell;

@interface ManeuverDetailTableViewControlleriPad : UITableViewController <ManeuverNoteAddDelegate, UITableViewDelegate, UITableViewDataSource> {

	Pattern *aPattern;
	Maneuver *theManeuver;
	ManeuverDetailTableCell *maneuverDetailTableCell;

	IBOutlet UIImageView *tableViewBackground;
	
@private
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) Pattern *aPattern;
@property (nonatomic, strong) Maneuver *theManeuver;
@property (nonatomic, strong) IBOutlet ManeuverDetailTableCell *maneuverDetailTableCell;

@property (nonatomic, strong) IBOutlet UIImageView *tableViewBackground;

-(void)editNotesButtonPressed:(id)sender;

@end