//
//  PatternNote.h
//  iRein
//
//  Created by Justin Hackett on 7/1/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pattern;

@interface PatternNote : NSManagedObject

@property (nonatomic, retain) NSNumber * patternNoteNumber;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Pattern *pattern;

@end
