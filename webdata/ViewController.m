//
//  ViewController.m
//  webdata
//
//  Created by Binary Semantics on 5/7/13.
//  Copyright (c) 2013 Binary Semantics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    responseData =[NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://dthms.airtel.in/iap-dataapi/private/bc/channels?X-Claimed-UserId=sunanndan"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"didReceiveResponse");
    [responseData setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
    
    //probably append the received data in a member variable
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    
    
    //check the error domain and report errors back to the calling function via a delegate
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //perform any cleanup and notify the delegate of available data
    
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[responseData length]);
    
    NSString *s = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    
   // NSMutableArray *arry=[NSMutableArray alloc]
    
    
    //    NSString *path = NSTemporaryDirectory();
    //    path = [path stringByAppendingPathComponent:@"tmpfile.txt"];
    //    if ([s writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil]) {
    //        NSDictionary *d = [[NSDictionary alloc] initWithContentsOfFile:path];
    //    }
    
    //  NSLog(@"%@",s);
    NSError *myError = nil;
    NSMutableArray *res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSLog(@"%d",[res count]);
    
    
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    //return YES to say that we have the necessary credentials to access the requested resource
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    //some code here, continue reading to find out what comes here
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"sunanndan" password:@"qplus"
                                                          persistence:NSURLCredentialPersistenceForSession];
    
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
