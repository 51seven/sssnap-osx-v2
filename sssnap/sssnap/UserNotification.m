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
        //  There was an Error, delegate the Error to errorDelegate
        //  for further actions.
        [self delegateError:_uploadError];
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
    
    NSString *screenshotURLString = [_screenshotURL absoluteString];
    NSString *notificationTitle = [@"Success - " stringByAppendingString:screenshotURLString];
    
    NSUserNotification *sucessNotification = [[NSUserNotification alloc] init];
    sucessNotification.title = notificationTitle;
    sucessNotification.subtitle = @"A Link has ben copied to your Clipboard";
    sucessNotification.informativeText = @"Or click this notification to open your screenshot";
    sucessNotification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:sucessNotification];
    
}


-(void) delegateError: (NSError *) error {
    NSNumber *errorCode = [NSNumber numberWithInteger:[_uploadError code]];
    NSString *minorTitle = @"We had some trouble here";
    NSString *criticalTitle = @"Oops, something went terribly wrong";
    
    if([errorCode integerValue] < 100) {
        NSString *clipboardErrorText = @"Link is not in your clipboard. Don't worry, just click here to see your Screenshot.";
        [self sendErrorNotification:minorTitle and:clipboardErrorText];
    } else if ([errorCode integerValue] == 301){
        // TODO: Check the internet connection and Server availability
        NSString *authenticationErrorText = @"There was an error parsing the response from the server";
        [self sendErrorNotification:criticalTitle and:authenticationErrorText];
    } else if ([errorCode integerValue] == 300) {
        // TODO: Check the internet connection and Server availability
        NSString *uploadErrorText = @"Something went wrong during the Upload";
        [self sendErrorNotification:criticalTitle and:uploadErrorText];
    } else if ([errorCode integerValue] == 404) {
        // TODO: Check the internet connection and Server availability
        NSString *uploadErrorText = @"Something went wrong during the Upload";
        [self sendErrorNotification:criticalTitle and:uploadErrorText];
    } else if([errorCode integerValue] == 401) {
        NSString *authErrorText = @"Something went wrong with your authentication";
        [self sendErrorNotification:criticalTitle and:authErrorText];
    }
    
}

//
//  Triggers a notification with custom error title and text
//
-(void) sendErrorNotification: (NSString *) title and: (NSString *) informativeText {
    NSUserNotification *sucessNotification = [[NSUserNotification alloc] init];
    sucessNotification.title = title;
    sucessNotification.informativeText = informativeText;
    sucessNotification.soundName = NSUserNotificationDefaultSoundName;
    
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center deliverNotification:sucessNotification];

    
    
    //[[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:sucessNotification];

}

//
//  TODO: Implement
//
-(void) clickableErrorNotification: (NSString *) title and: (NSString *) informativeText {
    
}


@end
