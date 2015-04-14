//
//  AppDelegate.h
//  sssnap
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SettingsView.h"
#import "Screenshot.h"
#import "Upload.h"
#import "GoogleOAuth.h"
#import "GTMOAuth2Authentication.h"
#import "ServerAuth.h"
#import <Carbon/Carbon.h>

#import "MainMenuController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

- (IBAction)screenshotButtonPush:(id)sender;
- (IBAction)quitApp:(id)sender;
- (IBAction)settingsButtonPush:(id)sender;

- (BOOL) userIsSignedIn;



//  Settings Window
@property (strong) SettingsView *settingsWindow;

//  Status Bar
@property (strong, nonatomic) NSStatusItem *statusBar;
@property (weak) IBOutlet NSMenu *statusMenu;

//  Auth object to Authenticate with Google
@property (strong) GTMOAuth2Authentication *auth;

//  Screenshot URL
@property (strong) NSURL *screenshotURL;

@property MainMenuController *popoverController;


@end

