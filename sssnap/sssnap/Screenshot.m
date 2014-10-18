//
//  Screenshot.m
//  sssnap
//
//  Screenshot class. Every time the screenshot hotkey is triggered, a new Screenshot Object is created.
//  For now a Screenshot Object has the following properties:
//  @screenshotData: The actual screenshot to be sent to the server.
//  @screenshotURL: The URL under which the screenshot is accessable on the server.
//  To be continued!
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
        //  A Screenshot Object only is created when the user wants to take a screenshot.
        //  Therefor the screenshotData (speak: the screenshot) has to be taken right away.
        screenshotData = [self takeScreenshot];
    }
    
    return self;
}

//
//  Captures a screenshot using the built in screencapture command.
//  Returns the data to the screenshot Object.
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
    
    //  Check if screencapture did success or aborted
    //  Check if task ins't still running to prevent errors!
    if(![screencapture isRunning]) {
        int status = [screencapture terminationStatus];
        if(status == 0){
            //  Success, do something!
            NSLog(@"Terminated like I should!");
        } else {
            //  Error, log trace!
            NSLog(@"Aborted!");
        }
    }
    
    return nil; //  Change!!
}

@end
