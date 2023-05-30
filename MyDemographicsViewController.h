//
//  MyDemographicsViewController.h
//  iRein
//
//  Created by Justin Hackett on 10/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import <UIKit/UIKit.h>


//My implementation of the Apple docs URL Loading System Programming Guide on how to use NSURLSession.
//All but the NSNetServicesBrowserDelegate are part of the Apple docs code implementation.
@interface MyDemographicsViewController : UIViewController <NSNetServiceBrowserDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate> //NSURLConnectionDownloadDelegate>//, NSURLAuthenticationChallengeSender>



@end
