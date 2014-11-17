//
//  Upload.h
//  sssnap
//
//  Created by Christian Poplawski on 21/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerAuth.h"
#import "GTMOAuth2Authentication.h"
#import "GoogleOAuth.h"

@interface Upload : NSObject

//  Lock the default init - only use initWithScreenshot!
-(instancetype) init __attribute__((unavailable("Use initWithScreenshot instead")));

- (void)authentication:(GTMOAuth2Authentication *)auth request:(NSMutableURLRequest *)request finishedWithError:(NSError *)error;

@property NSImage* screenshotImage;
@property NSURL* serverURL;
@property NSURL* screenshotURL;
@property GTMOAuth2Authentication* auth;

-(id) initWithScreenshot:(NSImage*) screenshot andAuth: (GTMOAuth2Authentication *) auth;
-(void) uploadScreenshot;
-(NSString *) returnScreenshotURL;

@end
