//
//  Pattern.h
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Maneuver, Note;

@interface Pattern : NSManagedObject

@property (nonatomic, retain) NSString * largeColorImageRef;
@property (nonatomic, retain) NSString * imageRef;
@property (nonatomic, retain) NSNumber * patternNumber;
@property (nonatomic, retain) NSString * largeWhiteImageRef;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *maneuvers;
@property (nonatomic, retain) NSSet *note;
@property (nonatomic, retain) NSSet *scorecardEvent;
@end

@interface Pattern (CoreDataGeneratedAccessors)

- (void)addManeuversObject:(Maneuver *)value;
- (void)removeManeuversObject:(Maneuver *)value;
- (void)addManeuvers:(NSSet *)values;
- (void)removeManeuvers:(NSSet *)values;

- (void)addNoteObject:(Note *)value;
- (void)removeNoteObject:(Note *)value;
- (void)addNote:(NSSet *)values;
- (void)removeNote:(NSSet *)values;

- (void)addScorecardEventObject:(NSManagedObject *)value;
- (void)removeScorecardEventObject:(NSManagedObject *)value;
- (void)addScorecardEvent:(NSSet *)values;
- (void)removeScorecardEvent:(NSSet *)values;

@end
