//
//  Upload.h
//  sssnap
//
//  Created by Christian Poplawski on 21/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Upload : NSObject

//  Lock the default init - only use initWithScreenshot!
-(instancetype) init __attribute__((unavailable("Use initWithScreenshot instead")));

@property NSImage* screenshotImage;
@property NSURL* serverURL;
@property NSURL* screenshotURL;

-(id) initWithScreenshot:(NSImage*) screenshot;

@end
