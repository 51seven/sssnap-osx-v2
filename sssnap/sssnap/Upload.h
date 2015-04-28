//
//  Upload.h
//  sssnap
//
//  Created by Christian Poplawski on 21/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GTMOAuth2Authentication.h"
#import "GoogleOAuth.h"
#import "UserNotification.h"
#import <AFNetworking.h>
#import <AFOAuth2Manager.h>

@interface Upload : NSObject

//  Lock the default init - only use initWithScreenshot!
-(instancetype) init __attribute__((unavailable("Use initWithScreenshot instead")));

@property NSImage* screenshotImage;
@property NSURL* serverURL;
@property NSURL* screenshotURL;
@property GTMOAuth2Authentication* auth;

-(id) initWithScreenshot:(NSImage*) screenshot andAuth: (GTMOAuth2Authentication *) auth;
-(void) uploadScreenshot;
-(void) copyURLToClipboard;
-(void) triggerNotification: (NSError *) error;

@end
