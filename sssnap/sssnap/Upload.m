//
//  Upload.m
//  sssnap
//
//  Created by Christian Poplawski on 21/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "Upload.h"
#import <AppKit/AppKit.h>

@implementation Upload


-(id) initWithScreenshot: (NSImage*) screenshot {
    if(self = [super init]) {
        _screenshotImage = screenshot;
        //  TODO: Write a function to easily switch between dev and live enviroment
        _serverURL = [NSURL URLWithString:@"http://localhost:3000/upload"];
        _screenshotURL = [self uploadScreenshot];
    }
    return self;
}


- (NSURL *)uploadScreenshot {
    
    NSMutableURLRequest *uploadRequest = [[NSMutableURLRequest alloc] init];
    [uploadRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [uploadRequest setHTTPShouldHandleCookies:NO];
    [uploadRequest setTimeoutInterval:30];
    [uploadRequest setHTTPMethod:@"POST"];
    
    NSURL *requestURL = _serverURL;
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"V2ymHFg03ehbqgZCaKO6jy";
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [uploadRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //  Add Image Data
    NSData *screenshotData = [_screenshotImage TIFFRepresentation];
    NSBitmapImageRep *screenshotDataRep = [NSBitmapImageRep imageRepWithData: screenshotData];
    screenshotData = [screenshotDataRep representationUsingType:NSPNGFileType properties: nil];
    
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
    
    // set URL
    [uploadRequest setURL:requestURL];
    
    //  Send the request and catch the response
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:uploadRequest returningResponse:&response error:&err];
    NSString *str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    NSLog(@"Response : %@",str);
    
    //  Shuld return an URL later on
    return str;
}

@end
