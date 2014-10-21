//
//  AppDelegate.m
//  sssnap
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "AppDelegate.h"
#import "Screenshot.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

//  Synthesize the status bar item
@synthesize statusBar = _statusBar;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.title = @"G";
    //self.statusBar.image =    set image later
    
    //  Assign the Menu to the status bar item
    self.statusBar.menu = self.statusMenu;
    self.statusBar.highlightMode = YES;
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)screenshotButtonPush:(id)sender {
    NSLog(@"Button was pushed!");
    //  Create a new Screenshot Object
    //  On inintiation a screenshot is taken
    Screenshot *testScreenshot = [[Screenshot alloc]init];
    if (testScreenshot.didFinishProperly) {
        NSLog(@"Everything worked out well!");
    } else {
        if (testScreenshot.internalError) {
            NSLog(@"Ooops, internal error!");
        } else {
            NSLog(@"User aborted!");
        }
    }
}
- (IBAction)quitApp:(id)sender {
    [NSApp terminate:self];
}
@end
