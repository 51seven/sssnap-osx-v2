//
//  Upload.m
//  sssnap
//
//  The Upload class initializes the upload of a screenshot taken by the Screenshot Class.
//  The default init for this class is locked, since an Upload Object *always* needs to be initialized with
//  an existing screenshot to be uploaded.
//  An Upload Object for now has the following properties:
//  @_screenshotImage: The actual screenshot, which is given to the constroctor on initialization.
//  @_serverURL: The URL to which the screenshot needs to be send. WIP.
//  @_screenshotURL: The URL of the stored screenshot the server sent back. Not working at this time.
//
//  Documentation Status: Version 0.1.0
//  Documentation last changed on: 17/11/14
//
//  Created by Christian Poplawski on 21/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "Upload.h"
#import <AppKit/AppKit.h>




#import "AppDelegate.h"

@implementation Upload


-(id) initWithScreenshot: (NSImage*) screenshot andAuth: (GTMOAuth2Authentication *) auth {
    if(self = [super init]) {
        _screenshotImage = screenshot;
        //  TODO: Write a function to easily switch between dev and live enviroment
        _serverURL = [NSURL URLWithString:@"https://localhost:3000/api/upload"];
        _auth = auth;
        
    }
    return self;
}

//
//  Uploads a screenshot via POST request to the server and recieves a URL as an answer.
//  The URL leads to where the screenshot is stored on the server.
//  This function is called on Object initiation only!
//  For further reading on the boundarys, please visit http://www.w3.org/Protocols/rfc1341/7_2_Multipart.html
//
- (void) uploadScreenshot {
    
    //  Set up the basic request
    NSMutableURLRequest *uploadRequest = [[NSMutableURLRequest alloc] init];
    [uploadRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [uploadRequest setHTTPShouldHandleCookies:NO];
    [uploadRequest setTimeoutInterval:30];
    [uploadRequest setHTTPMethod:@"POST"];
    [uploadRequest setURL:_serverURL];
    
    // the boundary string: a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"V2ymHFg03ehbqgZCaKO6jy";
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    NSString *accept = [NSString stringWithFormat:@"application/json"];
    
    [uploadRequest setValue:accept forHTTPHeaderField:@"Accept"];
    [uploadRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // Initialize post body
    NSMutableData *body = [NSMutableData data];
    
    //  Prepare Image Data
    NSData *screenshotData = [_screenshotImage TIFFRepresentation];
    NSBitmapImageRep *screenshotDataRep = [NSBitmapImageRep imageRepWithData: screenshotData];
    screenshotData = [screenshotDataRep representationUsingType:NSPNGFileType properties: nil];
    
    //  Append image data to post body
    if (screenshotData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:screenshotData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [uploadRequest setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [uploadRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [_auth authorizeRequest:uploadRequest
         completionHandler:^(NSError *error) {
             if (error == nil) {
                 
                 NSLog(@"Auth succeeded!"); // DEBUG
                 NSLog(@"%@", [uploadRequest description]); // DEBUG
                 
                 NSURLResponse *response = nil;
                 NSError *HTTPError = nil;
                 NSData *data = [NSURLConnection sendSynchronousRequest:uploadRequest returningResponse:&response error:&HTTPError];
                 
                 // Log possible errors
                 // TODO: Do something that makes sense when an error occurs.
                 if(HTTPError) {
                     NSLog(@"Following Error occured during the HTTP-Request: ");
                     NSLog(@"%@", HTTPError);
                 }
                 
                 // Write returns to string
                 NSString *str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                 NSLog(@"%@", str); // DEBUG
                 
                 NSError *JSONError = nil;
                 NSArray *requestReturns = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &JSONError];
                 
                 // Log possible errors
                 // TODO: Do something that makes sense when an error occurs.
                 if(JSONError) {
                     NSLog(@"Following Error occured during JSON-Parsing: ");
                     NSLog(@"%@", JSONError);
                 }
                 
                 // Save URL of screenshot to object's variables
                 _screenshotURL = [requestReturns valueForKey:@"shortlink"];
                 
                 NSLog(@"%@", requestReturns);  // DEBUG
                 NSLog(@"%@", _screenshotURL);  // DEBUG
                 
                 NSError *notificationTestError = nil;
                 UserNotification *testNotification = [[UserNotification alloc]initWithURL:_screenshotURL andError:notificationTestError];
                 
             }
         }];
    
    return;
    
}


@end
