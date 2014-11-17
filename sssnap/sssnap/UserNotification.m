//
//  UserNotification.m
//  sssnap
//
//  Created by Christian Poplawski on 17/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "UserNotification.h"

@implementation UserNotification

-(id) initWithURL: (NSURL *) screenshotURL andError: (NSError *) error {
    if(self = [super init]) {
        _screenshotURL = screenshotURL;
        _uploadError = error;
    }
    
    if(_uploadError != nil) {
        [self sendErrorNotification:_uploadError];
    } else {
        [self sendSuccessfulNotification];
    }
    
    return self;
}

-(void) sendSuccessfulNotification {
    
    //  Test Notification
    NSUserNotification *sucessNotification = [[NSUserNotification alloc] init];
    sucessNotification.title = @"Hello, World!";
    sucessNotification.informativeText = @"A notification";
    sucessNotification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:sucessNotification];
    
}

-(void) sendErrorNotification: (NSError *) error {
    //  TODO: Catch errors.
}

@end
