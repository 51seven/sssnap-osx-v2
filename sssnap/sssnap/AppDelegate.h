//
//  AppDelegate.h
//  sssnap
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SettingsView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (IBAction)screenshotButtonPush:(id)sender;
- (IBAction)quitApp:(id)sender;
- (IBAction)settingsButtonPush:(id)sender;

//  Settings Window
@property (strong) SettingsView *settingsWindow;

//  Status Bar
@property (strong, nonatomic) NSStatusItem *statusBar;
@property (weak) IBOutlet NSMenu *statusMenu;

@end

