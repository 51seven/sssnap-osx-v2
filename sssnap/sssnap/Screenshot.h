//
//  Screenshot.h
//  sssnap
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>


@interface Screenshot : NSObject
{
    NSImage *screenshotImage;

}

@property BOOL internalError;
@property BOOL didFinishProperly;

-(NSImage*) takeScreenshot;

@end
