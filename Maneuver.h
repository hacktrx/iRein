//
//  Maneuver.h
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note, Pattern;

@interface Maneuver : NSManagedObject

@property (nonatomic, retain) NSString * maneuverDescription;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * maneuverImageRef;
@property (nonatomic, retain) Pattern *pattern;
@property (nonatomic, retain) NSSet *note;
@end

@interface Maneuver (CoreDataGeneratedAccessors)

- (void)addNoteObject:(Note *)value;
- (void)removeNoteObject:(Note *)value;
- (void)addNote:(NSSet *)values;
- (void)removeNote:(NSSet *)values;

@end
