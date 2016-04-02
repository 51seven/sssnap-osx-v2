//
//  SettingsView.m
//  sssnap
//
//  Window Controller for the Settings-Window.
//  Not much to see by now.
//
//  Documentation Status: Version 0.2
//  Documentation last changed on: 17/11/14
//
//  Created by Christian Poplawski on 03/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()


@end

@implementation SettingsViewController


-(id) init {
    self = [super initWithWindowNibName:@"SettingsViewController"];
    if(self == nil){
        return nil;
    }
    
    //  Bring Window in front upon activation
    [NSApp activateIgnoringOtherApps:YES];
    [_settingsWindow makeKeyAndOrderFront:self];

    return self;
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Hide Button if user credentials are present in keychain
    GoogleOAuth *auth = [[GoogleOAuth alloc]init];
    if([auth credentialsInKeychain]) {
        NSLog(@"Credentials are in Keychain");
        [_googleSignInButton setHidden:YES];
    }

}

//
//  Call Google Sign In Sheet on click
//
- (IBAction)googleSignInButtonPush:(id)sender {
    GoogleOAuth *auth = [[GoogleOAuth alloc]init];
    [auth displaySignInSheet:_settingsWindow];
    
}


- (void)logOutGoogleButtonPush:(id)sender
{
    GoogleOAuth *auth = [[GoogleOAuth alloc]init];
    [auth removeItemFromKeychain];
    
}


@end
