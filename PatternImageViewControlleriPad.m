    //
//  PatternImageViewControlleriPad.m
//  iRein
//
//  Created by Justin Hackett on 2/12/11.
//  Copyright 2011 Steamer Trunk Records. All rights reserved.
//

#import "PatternImageViewControlleriPad.h"
#import "Pattern.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)

@implementation PatternImageViewControlleriPad

@synthesize patternImageView;
@synthesize thePatternForImageView;
@synthesize landscapePatternImageView;
@synthesize patternImage;
@synthesize delegate;
@synthesize segmentedControl;
@synthesize defaultImage;
@synthesize selectedSegment;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
		NSLog(@"initWithNibName:bundle fired in PatternImageViewControlleriPad just fired");

    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //If I don't have this, then the selectedSegment is defaulted to a value of 0. That makes the colored pattern
    //appear when the iPad is rotated even if the b&w pattern is being shown. This forces the b&w pattern to be
    //shown on iPad rotation.
    //TODO: Delete this???
    //self.selectedSegment = 0;
	
	// Configure the navigation bar
    self.navigationItem.title = self.thePatternForImageView.name;
	
	UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelImageView)];
    self.navigationItem.rightBarButtonItem = cancelButtonItem;
	
	//This is in the PatternNotesViewControlleriPad, but for the notes ivar instead.
	//I don't see any reason to ever need this here. So I'm commenting it out.
	//[self.patternImageView becomeFirstResponder];
    
    self.navigationItem.titleView = segmentedControl;
    segmentedControl.tintColor = [UIColor grayColor];
    
	if ((self.interfaceOrientation == UIDeviceOrientationPortrait) | (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
        
        
        self.view = patternImageView;
        
        switch (selectedSegment) {
            case 0:
                [self.segmentedControl setSelectedSegmentIndex:0]; 
                self.patternImageView.backgroundColor = [UIColor blackColor];
                self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
                self.patternImageView.image = self.patternImage;
                NSLog(@"The value of clickedSegment in the case0 of the Portrait part of the segControlClicked method is %d", selectedSegment);
                
                break;
            case 1:
                [self.segmentedControl setSelectedSegmentIndex:1]; 
                self.patternImageView.backgroundColor = [UIColor whiteColor];
                NSLog(@"The value of clickedSegment in the case1 of the Portrait part of the segControlClicked method is %d", selectedSegment);
                
                
                switch (defaultImage) {
                    case 0:
                        self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 1:
                        self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 2:
                        self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 3:
                        self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 4:
                        self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 5:
                        self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 6:
                        self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 7:
                        self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 8:
                        self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 9:
                        self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 10:
                        self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 11:
                        self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                        
                    default:
                        break;
                }
                
        }
        
    }
	
	else {
		
        self.view = landscapePatternImageView;
        //set point of rotation
		self.landscapePatternImageView.center = CGPointMake(351.0, 352.0);
		self.landscapePatternImageView.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        
        switch (selectedSegment) {
            case 0:
                [self.segmentedControl setSelectedSegmentIndex:0]; 
                self.landscapePatternImageView.backgroundColor = [UIColor blackColor];
                self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
                self.landscapePatternImageView.image = self.patternImage;
                NSLog(@"The value of clickedSegment in the case0 of the Landscape part of the segControlClicked method is %d", selectedSegment);
                break;
            case 1:
                [self.segmentedControl setSelectedSegmentIndex:1]; 
                self.landscapePatternImageView.backgroundColor = [UIColor whiteColor];
                NSLog(@"The value of clickedSegment in the case1 of the Landscape part of the segControlClicked method is %d", selectedSegment);
                
                switch (defaultImage) {
                    case 0:
                        self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 1:
                        self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 2:
                        self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 3:
                        self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 4:
                        self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 5:
                        self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 6:
                        self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 7:
                        self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 8:
                        self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 9:
                        self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 10:
                        self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 11:
                        self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                        
                    default:
                        break;
                }
        }
		
        
	}
    
    
	NSLog(@"viewDidLoad fired in PatternImageViewController");
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
    NSLog(@"willRotateToInterfaceOrientation fired in PatternImageViewControlleriPad");
    
	if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) | (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
        
        self.view = landscapePatternImageView;
        //set point of rotation
		self.landscapePatternImageView.center = CGPointMake(351.0, 352.0);
		self.landscapePatternImageView.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));

        switch (selectedSegment) {
            case 0:
                self.landscapePatternImageView.backgroundColor = [UIColor blackColor];
                self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
                self.landscapePatternImageView.image = self.patternImage;
                NSLog(@"The value of clickedSegment in the case0 of the Landscape part of the segControlClicked method is %d", selectedSegment);
                break;
            case 1:        
                self.landscapePatternImageView.backgroundColor = [UIColor whiteColor];
                NSLog(@"The value of clickedSegment in the case1 of the Landscape part of the segControlClicked method is %d", selectedSegment);
                
                switch (defaultImage) {
                    case 0:
                        self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 1:
                        self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 2:
                        self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 3:
                        self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 4:
                        self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 5:
                        self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 6:
                        self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 7:
                        self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 8:
                        self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 9:
                        self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 10:
                        self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                    case 11:
                        self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                        self.landscapePatternImageView.image = self.patternImage;
                        break;
                        
                    default:
                        break;
                }
        }
		
        
	}
	
	if ((toInterfaceOrientation == UIInterfaceOrientationPortrait) | (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
		
        self.view = patternImageView;

        switch (selectedSegment) {
            case 0:
                self.patternImageView.backgroundColor = [UIColor blackColor];
                self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
                self.patternImageView.image = self.patternImage;
                NSLog(@"The value of clickedSegment in the case0 of the Portrait part of the segControlClicked method is %d", selectedSegment);
                
                break;
            case 1:
                self.patternImageView.backgroundColor = [UIColor whiteColor];
                NSLog(@"The value of clickedSegment in the case1 of the Portrait part of the segControlClicked method is %d", selectedSegment);
                
                
                switch (defaultImage) {
                    case 0:
                        self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 1:
                        self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 2:
                        self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 3:
                        self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 4:
                        self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 5:
                        self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 6:
                        self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 7:
                        self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 8:
                        self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 9:
                        self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 10:
                        self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                    case 11:
                        self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                        self.patternImageView.image = self.patternImage;
                        break;
                        
                    default:
                        break;
                }

        }
        
    }
    
}


- (void)cancelImageView {
	
//TODO: Figure this out next.
    
	//This PatternDetailTableViewControlleriPad is the delegate.
	[self.delegate dismissPatternImageView];
    
    [self.delegate recordSelectedSegment:[self.segmentedControl selectedSegmentIndex]];
    NSLog(@"the value of selectedSegmentIndex in patternImageViewController's cancelImageView is %d", [self.segmentedControl selectedSegmentIndex]);
    
	NSLog(@"cancelImageView in PatternImageViewControlleriPad fired");

}

-(IBAction)segControlClicked:(id)sender {
    
    int clickedSegment = [sender selectedSegmentIndex];
    self.selectedSegment = [sender selectedSegmentIndex];
    
    NSLog(@"The value of defaultImage is %d", defaultImage);
    
    //If we are in a portrait orientation do this:
    if ((self.interfaceOrientation == UIDeviceOrientationPortrait) | (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
    
    switch (clickedSegment) {
        case 0:
            self.patternImageView.backgroundColor = [UIColor blackColor];
            self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
            self.patternImageView.image = self.patternImage;
            NSLog(@"The value of clickedSegment in the case0 of the Portrait part of the segControlClicked method is %d", clickedSegment);

            break;
        case 1:
            self.patternImageView.backgroundColor = [UIColor whiteColor];
            NSLog(@"The value of clickedSegment in the case1 of the Portrait part of the segControlClicked method is %d", clickedSegment);
            
            switch (defaultImage) {
                case 0:
                    self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 1:
                    self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    NSLog(@"The value of defaultImage in the case2 of the Portrait part of the segControlClicked method is %d", defaultImage);
                    break;
                case 2:
                    self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 3:
                    self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 4:
                    self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 5:
                    self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 6:
                    self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 7:
                    self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 8:
                    self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 9:
                    self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 10:
                    self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                case 11:
                    self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                    self.patternImageView.image = self.patternImage;
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    //If we are in a landscape orientation do this:
    /*if ((self.interfaceOrientation == UIDeviceOrientationLandscapeLeft) | (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
        */
    else {
        switch (clickedSegment) {
            case 0:
                self.landscapePatternImageView.backgroundColor = [UIColor blackColor];
                self.patternImage = [UIImage imageNamed:[self.thePatternForImageView imageRef]];
                self.landscapePatternImageView.image = self.patternImage;
                NSLog(@"The value of clickedSegment in the case0 of the Landscape part of the segControlClicked method is %d", clickedSegment);
                break;
            case 1:        
                self.landscapePatternImageView.backgroundColor = [UIColor whiteColor];
                NSLog(@"The value of clickedSegment in the case1 of the Landscape part of the segControlClicked method is %d", clickedSegment);
        
        switch (defaultImage) {
            case 0:
                self.patternImage = [UIImage imageNamed:@"Pattern_1_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 1:
                self.patternImage = [UIImage imageNamed:@"Pattern_2_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 2:
                self.patternImage = [UIImage imageNamed:@"Pattern_3_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 3:
                self.patternImage = [UIImage imageNamed:@"Pattern_4_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                NSLog(@"The value of defaultImage in the case3 of the Landscape part of the segControlClicked method is %d", clickedSegment);
                break;
            case 4:
                self.patternImage = [UIImage imageNamed:@"Pattern_5_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 5:
                self.patternImage = [UIImage imageNamed:@"Pattern_6_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 6:
                self.patternImage = [UIImage imageNamed:@"Pattern_7_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 7:
                self.patternImage = [UIImage imageNamed:@"Pattern_8_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 8:
                self.patternImage = [UIImage imageNamed:@"Pattern_9_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 9:
                self.patternImage = [UIImage imageNamed:@"Pattern_10_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 10:
                self.patternImage = [UIImage imageNamed:@"Pattern_11_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
            case 11:
                self.patternImage = [UIImage imageNamed:@"Pattern_12_Black.png"];
                self.landscapePatternImageView.image = self.patternImage;
                break;
                
            default:
                break;
        }

       }
    } 
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


//Cant have this controller respond to low memory warning because when I go back to the pattern detail table view
//after canceling the pattern image view, I can no longer select different patterns from the root view table.
//It just won't work properly any more.
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
   
    NSLog(@"didReceiveMemoryWarning fired in PatternImageViewControlleriPad");
}


- (void)viewDidUnload {
	self.patternImageView = nil;
	self.thePatternForImageView = nil;
	self.landscapePatternImageView = nil;
	self.patternImage = nil;
    self.segmentedControl = nil;
	self.delegate = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	NSLog(@"viewDidUnload fired in PatternImageViewControlleriPad");
}


- (void)dealloc {
	
	NSLog(@"dealloc fired in PatternImageViewControlleriPad");

}


@end
