//
//  SettingsView.h
//  sssnap
//
//  Created by Christian Poplawski on 03/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GoogleOAuth.h"

@interface SettingsViewController : NSWindowController


@property (strong) IBOutlet NSWindow *settingsWindow;
@property (weak) IBOutlet NSButtonCell *logOutGoogleButton;
@property (weak) IBOutlet NSButton *googleSignInButton;


- (IBAction)signInGoogleButtonPush:(id)sender;
- (IBAction)logOutGoogleButtonPush:(id)sender;

@end
