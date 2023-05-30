//
//  Association.h
//  iRein
//
//  Created by Justin Hackett on 9/19/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pattern;

@interface Association : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Pattern *pattern;

@end
