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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)screenshotButtonPush:(id)sender {
    NSLog(@"Button was pushed!");
    //  Create a new Screenshot Object
    //  On inintiation a screenshot is taken
    Screenshot *testScreenshot = [[Screenshot alloc]init];
}
@end
