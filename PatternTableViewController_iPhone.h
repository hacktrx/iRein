//
//  PatternTableViewController_iPhone.h
//  iRein
//
//  Created by Justin Hackett on 9/29/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PatternTableViewController_iPhone : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
