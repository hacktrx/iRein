//
//  CombinedManeuvers.h
//  iRein
//
//  Created by Justin Hackett on 7/1/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pattern;

@interface CombinedManeuvers : NSManagedObject

@property (nonatomic, retain) NSNumber * combinedManeuversNumber;
@property (nonatomic, retain) NSString * combinedManeuversURL;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Pattern *pattern;

@end
