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

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize auth;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.title = @"G";
    //self.statusBar.image =    set image later
    
    //  Assign the Menu to the status bar item
    self.statusBar.menu = self.statusMenu;
    self.statusBar.highlightMode = YES;
    
    
    
    [self setGoogleOAuth];
    NSLog(@"%@", auth);
    
}




- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)screenshotButtonPush:(id)sender {
    NSLog(@"Button was pushed!");
    //  Create a new Screenshot Object
    //  On inintiation a screenshot is taken
    Screenshot *testScreenshot = [[Screenshot alloc]init];
    if ([testScreenshot didFinishProperly]) {
        NSLog(@"Everything worked out well!");
        //  TODO:
        //  Upload Image, send Notification, send Link to Clipboard
        
        //NSOperationQueue Test
        Upload *uploadScreenshot = [[Upload alloc]initWithScreenshot:[testScreenshot screenshotImage] andAuth: auth];
        [uploadScreenshot uploadScreenshot];
        
        
    } else {
        if ([testScreenshot internalError]) {
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

- (IBAction)settingsButtonPush:(id)sender {
    _settingsWindow = [[SettingsView alloc]init];
    [_settingsWindow showWindow:self];
}

//
//  Obtains the Google OAtuh GTMOAuth2Authentication-Object from the Keychain.
//  If it can be used to authorize requests, it is saved to the AppDelegate's _auth property
//  The _auth property should be given to all functions, that need to authorize something
//  to keep the times the auth credentials are obtained from the keychain as low as possible.
//
//  TODO: What if the auth from keychain cannot authorize?
//  TODO: What if there is no auth object stored in the keychain?
//
-(void) setGoogleOAuth {
    GoogleOAuth *keychainCredentials = [[GoogleOAuth alloc]init];
    GTMOAuth2Authentication *authFromKeychain = [keychainCredentials getAuthFromKeychain];
    
    if([authFromKeychain canAuthorize]) {
        auth = authFromKeychain;
    } else {
        //  Auth not valid, User needs to Sign in
        NSLog(@"Cannot auth. (Origin: Appdelegate.m)");
    }
    
}

-(BOOL) userIsSignedIn {
    GoogleOAuth *gtmOperator = [[GoogleOAuth alloc]init];
    if([gtmOperator credentialsInKeychain]) {
        return YES;
    } else {
        return NO;
    }

    
}
@end
