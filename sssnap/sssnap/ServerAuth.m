//
//  ServerAuth.m
//  sssnap
//
//  Created by Christian Poplawski on 04/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "ServerAuth.h"

@implementation ServerAuth

-(id) init {
    if(self = [super init]) {
        
        GoogleOAuth *appCredentials = [[GoogleOAuth alloc]init];
        _auth = [appCredentials getAuthFromKeychain];

    }
    
    return self;
}


-(NSMutableArray *)getUserCredentials {

    
    //  Set up the request frame
    NSMutableURLRequest *userCredentialsRequest = [[NSMutableURLRequest alloc] init];
    [userCredentialsRequest setHTTPMethod:@"GET"];
    [userCredentialsRequest setURL:[NSURL URLWithString:@"https://localhost:3000/api/user"]];
    NSString *BoundaryConstant = @"V2ymHFg03ehbqgZCaKO6jy";
    NSString *contentType = [NSString stringWithFormat:@"application/json; boundary=%@", BoundaryConstant];
    [userCredentialsRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    

    
    NSMutableArray *requestReturns = [self authRequestAndSend:userCredentialsRequest];
    
    return requestReturns;

}


-(NSMutableDictionary *) authRequestAndSend:(NSMutableURLRequest *)request {
    
    NSMutableDictionary *requestReturns = [[NSMutableDictionary alloc]init];
    
    // Add authentication to the http header
    [_auth authorizeRequest:request
          completionHandler:^(NSError *error) {
              if (error == nil) {
                  
                  // the request has been authorized
                  NSLog(@"%@", [request description]); // DEBUG
                  NSURLResponse *response = nil;
                  NSError *err = nil;
                  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                  
                  if(err) {
                      NSLog(@"Error during Request");
                  }
                  
                  [requestReturns addEntriesFromDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err]];
                  
                  if(err) {
                      NSLog(@"Error during JSON parisng");
                      NSLog(@"%@", err);
                  }
                  
                  NSLog(@"%@", requestReturns);  //  DEBUG
                  
                  
              }
              // TODO: Need some error handling?
              
          }];

    return requestReturns;
    
}



- (void)authentication:(GTMOAuth2Authentication *)auth
               request:(NSMutableURLRequest *)request
     finishedWithError:(NSError *)error {
    if (error != nil) {
        // Authorization failed
    } else {
        // Authorization succeeded
    }
}

@end
