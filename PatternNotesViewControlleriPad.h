//
//  PatternNotesViewControlleriPad.h
//  iRein
//
//  Created by Justin Hackett on 2/13/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol ManeuverNoteAddDelegate;
@class Pattern;
@class Maneuver;

@interface PatternNotesViewControlleriPad : UIViewController {
	
	Pattern *pattern;
	Maneuver *maneuver;
	UITextView *notes;
	
@private
	id <ManeuverNoteAddDelegate> __weak delegate;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) Pattern *pattern;
@property (nonatomic, strong) Maneuver *maneuver;
@property (nonatomic, strong) IBOutlet UITextView *notes;

@property(nonatomic, weak) id <ManeuverNoteAddDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end


@protocol ManeuverNoteAddDelegate <NSObject>
//Don't need this line cause I'm not implementing a cancel method.
// maneuver == nil on cancel
- (void)patternNotesViewControlleriPad:(PatternNotesViewControlleriPad *)patternNotesViewControlleriPad didChangeNoteForManeuver:(Maneuver *)maneuver;

@end