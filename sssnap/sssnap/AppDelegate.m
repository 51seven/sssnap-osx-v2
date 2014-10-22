//
//  AppDelegate.m
//  sssnap
//
//  Version: 0.1
//
//  Created by Christian Poplawski on 17/10/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "AppDelegate.h"
#import "Screenshot.h"
#import "Upload.h"

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
        //  TODO:
        //  Upload Image, send Notification, send Link to Clipboard
        Upload *uploadScreenshot = [[Upload alloc]initWithScreenshot:testScreenshot.screenshotImage];
        NSURL *screenshotURL = [uploadScreenshot screenshotURL];
        NSLog(@"%@", screenshotURL);
    } else {
        if (testScreenshot.internalError) {
            //  Everything is ruined, run!
            NSLog(@"Ooops, internal error!");
        } else {
            //  Nothing hapened, wait for next Screenshot.
            NSLog(@"User aborted!");
            return;
        }
    }
}


- (IBAction)quitApp:(id)sender {
    [NSApp terminate:self];
}
@end
