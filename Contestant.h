//
//  Contestant.h
//  iRein
//
//  Created by Justin Hackett on 3/21/14.
//  Copyright (c) 2014 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScorecardEvent;

@interface Contestant : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * exhibitorNumber;
@property (nonatomic, retain) NSNumber * drawNumber;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) ScorecardEvent *scorecard;

@end
