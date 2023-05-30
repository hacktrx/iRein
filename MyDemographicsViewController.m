//
//  MyDemographicsViewController.m
//  iRein
//
//  Created by Justin Hackett on 10/11/13.
//  Copyright (c) 2013 JH Productions. All rights reserved.
//

#import "MyDemographicsViewController.h"

@interface MyDemographicsViewController ()

@property (nonatomic, strong) IBOutlet UIButton *myButton;
@property (nonatomic, strong) IBOutlet UITextView *myTextView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *myIndicatorView;
@property (nonatomic, strong) NSMutableData *webData;

-(IBAction)dataButtonPushed:(id)sender;


@end



@implementation MyDemographicsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}


- (void)viewDidLoad {
    
    if (self.myIndicatorView.hidden == YES) {
        self.myIndicatorView.hidden = NO;
    }
    
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark START OF METHODS CALLED

-(IBAction)dataButtonPushed:(id)sender {
    
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                         "<PublicSafetyEnvelope version=\"1.0\">\n"
                         "<MessageIdentification/>\n"
                         "<From>My Computer</From>\n"
                         "<To/>\n"
                         "<Creation/>\n"
                         "<PublicSafety id=\"\">\n"
                         "<Query>\n"
                         "<MainNamesTable>\n"
                         "<LastName search_type=\"equal_to\">Johnson</LastName>\n"
                         "<FirstName search_type=\"equal_to\">Mike</FirstName>\n"
                         "</MainNamesTable>\n"
                         "</Query>\n"
                         "</PublicSafety>\n"
                         "</PublicSafetyEnvelope>\n"];

    NSURL *url = [NSURL URLWithString:@"http://192.168.50.235:4081/DataExchange/REST"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[req addValue: @"processXMLDocument" forHTTPHeaderField:@"SOAPAction"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];

    if (conn)
    {
        //I THINK I NEED TO CALL A METHOD TO AUTHENTICATE HERE OR SOMETHING.
        self.webData = [NSMutableData data];
    }
    
    NSLog(@"dataButtonPushed fired and the webData is %@", self.webData);

}


#pragma - mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSLog(@"willSendRequestForAuthenticationChallenge did fire with challenge:%@\n", challenge);
        
    if ([challenge previousFailureCount] > 0) {
        // do something may be alert message
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
    else
    {

    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"xmluser"
                                                             password:@"xmluser"
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    

        }
    
}


#pragma - mark NSURLConnectionDataDelegate

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    [self.webData setLength: 0];
    
    NSLog(@"connection:didReceiveResponse fired and the response is %@", response);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.webData appendData:data];
    //NSLog(@"The data in didReceiveData is %@", data);
    //NSLog(@"The webData in didReceiveData is %@", self.webData);
    NSString *dataString = [[NSString alloc] initWithData:self.webData encoding:NSUTF8StringEncoding];
    NSLog(@"The dataString is %@", dataString);
    //self.myCell.tweetScreenNameLabel.text = [[[self.tweetArr objectAtIndex:indexPath.row] valueForKey:@"user"] valueForKey:@"screen_name"];
    //NSString *nameString =
    NSString *nameString = [dataString valueForKey:@"Name"];
    NSLog(@"The name is %@", nameString);
}



#pragma - mark NSURLConnectionDownloadDelegate
//CANNOT IMPLEMENT THIS DELEGATE AND THE DATA DELEGATE TOO. IT WOULD NOT CALL THE DATA DELEGATE METHOD DIDRECEIVEDATA.
/*
-(void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL {
    
    NSLog(@"connectionDidFinishDownloading fired");
    
    NSLog(@"..DONE. Received Bytes: %d\n", [self.webData length]);
    NSString *theXML = [[NSString alloc]    //---shows the XML---
                        initWithBytes:[self.webData mutableBytes] length:[self.webData length]
                        encoding:NSUTF8StringEncoding];
    NSLog(@"The XML is:\n%@\n",theXML);
    NSLog(@"The destination URL is %@", destinationURL);
    
    
    NSString *responseString = [[NSString alloc] initWithData:self.webData encoding:NSUTF8StringEncoding];
    NSLog(@"The responseString is %@", responseString);
    self.webData = nil;
    
    //  [activityIndicator stopAnimating];
        
}

- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    
    NSLog(@"data is %lld, total bytes is %lld, expected bytes is %lld", bytesWritten, totalBytesWritten, expectedTotalBytes);
    
}
*/

#pragma - mark END OF METHODS CALLED

/*
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    NSLog(@"canAuthenticateAgainstProtectionSpace fired and the protectionSpace is %@", protectionSpace);

}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    //NSArray *trustedHosts=[NSArray arrayWithObject:@"https://mydomain/"];
    //if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //if ([trustedHosts containsObject:challenge.protectionSpace.host])
            //[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]forAuthenticationChallenge:challenge];
    
    NSLog(@"didReceiveAuthenticationChallenge fired and the challenge is %@", challenge);
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    
}


-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
    [self.webData appendData:data];
    
    NSLog(@"connection:didReceiveData fired.");

}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    
    NSLog(@"connection:didFailWithError fired and the error is %@.", error);

}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    
    NSLog(@"..DONE. Received Bytes: %d", [self.webData length]);
    NSString *theXML = [[NSString alloc]    //---shows the XML---
                        initWithBytes:[self.webData mutableBytes] length:[self.webData length]
                        encoding:NSUTF8StringEncoding];
    NSLog(@"....%@",theXML);
    
    //  [activityIndicator stopAnimating];

    NSLog(@"connectionDidFinishDownloading fired and the XML is %@", theXML);

}
*/
//END OF CODE EXAMPLE FROM WEB





@end
