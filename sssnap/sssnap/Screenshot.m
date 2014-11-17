//
//  Screenshot.m
//  sssnap
//
//  Screenshot class. Every time the screenshot hotkey is triggered, a new Screenshot Object is created.
//  A Screenshot Object has the following properties:
//  @screenshotData: The actual screenshot to be sent to the server.
//  @didFinishProperly: Informs the sender if the screenshot process finished properly.
//  @internalError: If the task did not finish properly, there are two possibilities:
//      1. The user canceled the screenshot, no internal error, wait for the next task.
//      2. An internal error accured, should better not be happening.
//  To be continued!
//
//  Documentation Status: Version 0.2
//  Documentation last changed: 20/10/14
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
        _screenshotImage = [self takeScreenshot];
    }
    
    return self;
}

//
//  Captures a screenshot using the built in screencapture command.
//  Returns the data to the screenshot Object.
//
-(NSImage*) takeScreenshot {
    
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
            
            //  Init a pasteboard and copy it's contents to an array
            NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
            NSArray *classes = [[NSArray alloc] initWithObjects: [NSImage class], nil];
            NSDictionary *options = [NSDictionary dictionary];
            NSArray *copiedItems = [pasteboard readObjectsForClasses:classes options:options];
            
            //  Check if there are elements from the clipboard in the array
            if ([copiedItems count]) {
                //  There should only be one element which should be an Image
                if([[copiedItems objectAtIndex:0] isKindOfClass:[NSImage class]]) {
                    //  Retrieve the image and set it as the Screenshots data
                    NSImage *image = [copiedItems objectAtIndex:0];
                    _didFinishProperly = YES;
                    NSLog(@"%@", [image description]);
                    return image;
                } else {
                    //  No Image in clipboard where one should be
                    //  Eception?
                    _didFinishProperly = NO;
                    _internalError = YES;
                }
            } else {
                //  No items in the clipboard
                //  Exception?
                _didFinishProperly = NO;
                _internalError = YES;
            }
        } else {
            //  User did not finish taking the screenshot
            //  Programm should not throw an exception or error message, just wait for the next Screenshot
            _didFinishProperly = NO;
            _internalError = NO;
        }
    }
    
    return nil;
}


@end
