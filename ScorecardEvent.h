//
//  ScorecardEvent.h
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pattern;

@interface ScorecardEvent : NSManagedObject

@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * eventJudge;
@property (nonatomic, retain) NSString * eventClass;
@property (nonatomic, retain) NSDate * eventDate;
@property (nonatomic, retain) NSSet *contestant;
@property (nonatomic, retain) Pattern *pattern;
@end

@interface ScorecardEvent (CoreDataGeneratedAccessors)

- (void)addContestantObject:(NSManagedObject *)value;
- (void)removeContestantObject:(NSManagedObject *)value;
- (void)addContestant:(NSSet *)values;
- (void)removeContestant:(NSSet *)values;

@end
