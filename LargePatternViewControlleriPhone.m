//
//  LargePatternViewControlleriPhone.m
//  iRein
//
//  Created by Justin Hackett on 6/7/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "LargePatternViewControlleriPhone.h"
#import "Pattern.h"
#import "ManeuverTableViewController.h"

NSString *kManeuverSegue = @"maneuverSegue"; //Seque to table view of maneuver text.

@interface LargePatternViewControlleriPhone ()

@property (nonatomic, strong) IBOutlet UIImageView *patternImageView;
@property (nonatomic, strong) IBOutlet UILabel *patternNumberLabel;
@property (nonatomic, assign) BOOL showColoredPatterns;
//@property (nonatomic, strong) ManeuverTableViewController *maneuverTableViewController;

//@property (nonatomic, retain) UIImage *patternImage;
//@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
//@property (nonatomic, assign) NSInteger defaultImage;
//@property (nonatomic, assign) NSInteger selectedSegment;

-(IBAction)segControlClicked:(id)sender;
-(void)updatePatternImageForSegment:(NSInteger)segment;

@end

@implementation LargePatternViewControlleriPhone

@synthesize delegate;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize selectedPattern;
@synthesize patternNumber;
@synthesize patternNumberLabel;
@synthesize patternImageView;
@synthesize mySegmentedControl;
@synthesize showColoredPatterns;
//@synthesize maneuverTableViewController;
//@synthesize segmentedControl;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//Check to see if the colored pattern image should be loaded.
    if ([self.mySegmentedControl selectedSegmentIndex] == 0) {
        self.patternImageView.image = [UIImage imageNamed:self.selectedPattern.largeWhiteImageRef];
    }
    else {
        self.patternImageView.image = [UIImage imageNamed:self.selectedPattern.largeColorImageRef];
    }
    
    self.patternNumberLabel.text = [NSString stringWithFormat:@"%@", self.selectedPattern.patternNumber];
    
    // Configure the navigation bar. Not using because you can't do this with the segmented control in the nav bar.
    //self.navigationItem.title = [NSString stringWithFormat:@"NRHA %@", self.selectedPattern.name];
    
//TODO: May need to implement this done button stuff. Right now it's off cause I put the button on the storyboard.
//      Still need to figure out how to hook the done button to the cancelImageView method.
	//UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelImageView)];
    //self.navigationItem.rightBarButtonItem = cancelButtonItem;
    //[cancelButtonItem release];
        
    NSLog(@"viewDidLoad fired in PatternImageViewController");

//TODO:Delete this if other migration works.
//For populating the database for the first time.
    //[self setUpPatternData];

}


//For populating the database for the first time.
-(void)setUpPatternData {
    
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_1_Image.png"]) {
        
//The pattern "name" is a field that was already filled in on the prior version of the app.
//I don't need to set it again here.
        //[self.selectedPattern setValue:@"Pattern 1" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:1] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_1_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_1_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern name is equal to 1");
        NSLog(@"The managedObjectContext in the large pattern view controller is %@.", self.managedObjectContext);
        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_2_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 2" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:2] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_2_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_2_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_3_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 3" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:3] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_3_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_3_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_4_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 4" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:4] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_4_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_4_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_5_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 5" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:5] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_5_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_5_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_6_Image.png"]) {
    
        //[self.selectedPattern setValue:@"Pattern 6" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:6] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_6_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_6_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_7_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 7" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:7] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_7_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_7_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_8_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 8" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:8] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_8_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_8_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_9_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 9" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:9] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_9_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_9_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_10_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 10" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:10] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_10_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_10_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_11_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 11" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:11] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_11_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_11_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    if ([self.selectedPattern.imageRef isEqualToString:@"Pattern_12_Image.png"]) {
        
        //[self.selectedPattern setValue:@"Pattern 12" forKey:@"name"];
        [self.selectedPattern setValue:[NSNumber numberWithInt:12] forKey:@"patternNumber"];
        [self.selectedPattern setValue:@"Pattern_12_Image.png" forKey:@"largeColorImageRef"];
        [self.selectedPattern setValue:@"Pattern_12_Black.png" forKey:@"largeWhiteImageRef"];

        NSLog(@"The selectedPattern imageRef is %@", self.selectedPattern.imageRef);
        NSLog(@"The new patternNumber is %@", self.selectedPattern.patternNumber);
        
    }
    
    NSNumber *thePatternNumber = self.selectedPattern.patternNumber;
    NSString *patternNumberString = [thePatternNumber stringValue];
    self.patternNumberLabel.text = patternNumberString;
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//You can do the segue either way below. One uses a local variable and the other uses a property for the
//destination view controller. Both are listed here for reference.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
        if ([[segue identifier] isEqualToString:kManeuverSegue]) {
            
            ManeuverTableViewController *maneuverTableViewController = [segue destinationViewController];
            maneuverTableViewController.managedObjectContext = self.managedObjectContext;
            
            //NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            //patternDetailViewControlleriPhone.selectedRow = path.row;
            //NSLog(@"The selectedRow text in PatternTableViewController is %d", path.row);
            
            //self.selectedPattern = [patternsArray objectAtIndex:path.row];
            
            maneuverTableViewController.selectedPattern = self.selectedPattern;
            maneuverTableViewController.mySelectedSegment = self.mySegmentedControl.selectedSegmentIndex;
            
            NSLog(@"The destination controller is %@", segue.destinationViewController);
            NSLog(@"The selectedPattern in prepareForSegue is %@", self.selectedPattern);
            
            [segue destinationViewController];

    /*
    if ([[segue identifier] isEqualToString:kManeuverSegue]) {
        
        self.maneuverTableViewController = segue.destinationViewController;
        maneuverTableViewController.managedObjectContext = self.managedObjectContext;
        
        //NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //patternDetailViewControlleriPhone.selectedRow = path.row;
        //NSLog(@"The selectedRow text in PatternTableViewController is %d", path.row);
        
        //self.selectedPattern = [patternsArray objectAtIndex:path.row];
        
        maneuverTableViewController.selectedPattern = self.selectedPattern;
        
        NSLog(@"The destination controller is %@", segue.destinationViewController);
        NSLog(@"The selectedPattern in prepareForSegue is %@", self.selectedPattern);
        
        [segue destinationViewController];
    */
    }
}



#pragma mark -
#pragma mark - Private Methods



-(IBAction)segControlClicked:(id)sender {
    
    int clickedSegment = [sender selectedSegmentIndex];
    [self updatePatternImageForSegment:clickedSegment];
    
}


-(void)updatePatternImageForSegment:(NSInteger)segment {
    
    /*
     UIImage *myImage = [UIImage imageNamed:[thePattern largeColorImageRef]];
     newCell.image.image = myImage;
     */
    if (segment == 0) {
        self.patternImageView.image = [UIImage imageNamed:self.selectedPattern.largeWhiteImageRef];
        [self.delegate setMySegmentedControlActiveSegment:0];
    }
    
    else {
        self.patternImageView.image = [UIImage imageNamed:self.selectedPattern.largeColorImageRef];
        [self.delegate setMySegmentedControlActiveSegment:1];
    }
    
    
}





@end
