//
//  PatternImageCollectionController.h
//  iRein
//
//  Created by Justin Hackett on 10/21/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LargePatternViewControlleriPhone.h"

@interface PatternImageCollectionController : UICollectionViewController <NSFetchedResultsControllerDelegate, LargePatternViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSNumber *myActiveSwitchSegment;


@end
