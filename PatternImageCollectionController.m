//
//  PatternImageCollectionController.m
//  iRein
//
//  Created by Justin Hackett on 10/21/12.
//  Copyright (c) 2012 JH Productions. All rights reserved.
//

#import "PatternImageCollectionController.h"
#import "PatternCollectionCell.h"
#import "Pattern.h"
#import "LargePatternViewControlleriPhone.h"

NSString *kCellID = @"cellID"; // UICollectionViewCell storyboard id
NSString *kViewHeaderID = @"viewHeaderID"; // UICollectionViewCell storyboard id
NSString *kCollectionDetailSegue = @"showCollectionDetail"; //Seque to collection view detail view.

@interface PatternImageCollectionController ()

@end

@implementation PatternImageCollectionController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize myActiveSwitchSegment;


//For declared properties, you should use assign instead of weak; for variables you should use __unsafe_unretained instead of __weak.

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kCollectionDetailSegue]) {
        
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Pattern *thePattern = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
        LargePatternViewControlleriPhone *largePatternViewController = [segue destinationViewController];
        largePatternViewController.delegate = self;
        
        int myInteger = [myActiveSwitchSegment integerValue];
        [largePatternViewController.mySegmentedControl setSelectedSegmentIndex:myInteger];
        
        largePatternViewController.managedObjectContext = self.managedObjectContext;
        largePatternViewController.selectedPattern = thePattern;
        //largePatternViewController.patternNumber = indexPath.row;
    }
}


#pragma mark -
#pragma mark Delegate methods

/*
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        LTWLetter *ltwLetter = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //self.detailViewController.detailItem = object;
        
    }
     
}
*/

#pragma mark -
#pragma mark Data Source methods


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PatternCollectionCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    Pattern *thePattern = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    
    /*
    UIImage *myImage = [UIImage imageNamed:[thePattern largeWhiteImageRef]];
    newCell.image.image = myImage;
    newCell.label.text = [thePattern.patternNumber stringValue];
    */
    

//TODO:See if I can leave this here.
//Don't know how this will work with new migration code in app delegate.
    UIImage *myImage = [UIImage imageNamed:[thePattern largeWhiteImageRef]];
    newCell.image.image = myImage;
    newCell.label.text = [thePattern.patternNumber stringValue];
    //newCell.label.font = [UIFont systemFontOfSize:10];
    
    
    return newCell;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    
    return [[self.fetchedResultsController sections] count];

}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    //LTW_LetterCollectionViewHeader *header = nil;
    UICollectionReusableView *header = nil;
    
    if ([kind isEqual:UICollectionElementKindSectionHeader])
    {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kViewHeaderID forIndexPath:indexPath];
        
        //LTWLetter *ltwLetter = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //header.collectionViewHeaderLabel.text = ltwLetter.writingSubject;
    }
    
    return header;
     
}


#pragma mark -
#pragma mark - Fetched results controller

//I don't think I need to do anything with this when migrating. Check it out, then delete the line below in this method
//if I find I don't need to change the method line for migration.
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pattern" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Fix this. I took it off for now.
    // Set the batch size to a suitable number.
    //[fetchRequest setFetchBatchSize:100];
    
    /*This is a different way of writing the descriptor code.
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"patternNumber" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    */
    
    // Create the sort descriptors array. We have only one sort descriptor in the array.
	NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"patternNumber" ascending:YES];
    
//TODO: Get rid of this if migration works without changing it.
    //Use this as sort descriptor when populating database for migration for first time.
    //NSSortDescriptor *patternDescriptor = [[NSSortDescriptor alloc] initWithKey:@"imageRef" ascending:YES];
    
	//Without this descriptor, the cells have all the maneuvers in them but they are not ordered from one
	//to twelve like they should be. I need this "name" descriptor to get it to do that correctly.
	//NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"imageRef" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:patternDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
     
}


#pragma mark -
#pragma mark - Delegate Methods


-(void)setMySegmentedControlActiveSegment:(NSInteger *)segment {
    
    self.myActiveSwitchSegment = [NSNumber numberWithInt:segment];
    
}



@end
