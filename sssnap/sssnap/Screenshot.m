//
//  Screenshot.m
//  sssnap
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "Screenshot.h"

@interface Screenshot ()

@end

@implementation Screenshot

-(id) init
{
    if(self = [super init]) {
        NSLog(@"Entered Screenshot constructor"); //Testing
        screenshotData = [self takeScreenshot];
    }
    
    return self;
}

//
//  Captures a screenshot using the built in screencapture command.
//
-(NSData*) takeScreenshot {
    
    //  Start the task and define launch path
    NSTask *screencapture;
    screencapture = [[NSTask alloc] init];
    [screencapture setLaunchPath:@"/usr/sbin/screencapture"];
    
    //  Array with Arguments to be given to screencapture
    NSArray *screencaptureArgs = [NSArray arrayWithObjects:@"-i", @"-c", @"image.jpg", nil];
    
    //  Apply arguments and start application
    [screencapture setArguments:screencaptureArgs];
    [screencapture launch];
    [screencapture waitUntilExit];
    
    NSLog(@"Process 'screencapture' has finished with reason: %ld", [screencapture terminationReason]);
    
    return nil;
}

@end
