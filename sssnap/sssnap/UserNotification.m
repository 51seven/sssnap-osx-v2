//
//  UserNotification.m
//  sssnap
//
//  This class triggers a Notification to display for the User.
//  The class is always inited with a screenshotURL and an error.
//  The class decides what to display depending on the Error.
//  A UserNotification has the following properties:
//  @_screenshotURL: The URL of the Screenshot on the server. May be nil in some cases, but is always
//                   covered by an mathcing error.
//  @_uploadError: Error coming from Upload.m. There are three diferrent possible errors:
//                      1. Error during HTTP- Request.
//                      2. Error during JSON parsing of the Request's results.
//                      3. Error during copying to clipboard (minor).
//
//  Documentation Status: Version 0.2
//  Documentation last changed on: 17/11/14
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
    
    return self;
}


//
//  This function only decides if a regular Notifcation or an Erro Notifications
//  needs to be sent, depending on the Error.
//  This (besides init) is the only function the may be called from outside this
//  class. The Error must always be checked.
//
-(void) sendNotification {
    if(_uploadError != nil) {
        //  There was an Error, delegate the Error to sendErrorNotification
        //  for further actions.
        [self sendErrorNotification:_uploadError];
    } else {
        //  No error, sned the default Notification
        [self sendSuccessfulNotification];
    }
}


//
//  Sends a default Notification.
//  By now, this notification only informs the User that the upload was successful
//  and a link has been copied to his clipboard.
//  TODO: Make clickable.
//
-(void) sendSuccessfulNotification {
    
    NSUserNotification *sucessNotification = [[NSUserNotification alloc] init];
    sucessNotification.title = @"Upload Successful!";
    sucessNotification.informativeText = @"A Link has ben copied to your Clipboard.";
    sucessNotification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:sucessNotification];
    
}


//
//  Handles the different types of Errors
//  TODO: Implement
//
-(void) sendErrorNotification: (NSError *) error {
    //  TODO: Catch errors.
}

@end
