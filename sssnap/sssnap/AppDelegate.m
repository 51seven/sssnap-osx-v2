//
//  AppDelegate.m
//  sssnap
//
//  Version: 0.2
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

static NSString *hotkeys = @"shift alt 4";
id refToSelf;

#pragma mark - Initialization

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.popoverController = [[MenubarController alloc]init];
    
    /*
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.title = @"G";
    //self.statusBar.image =    set image later
    
    //  Assign the Menu to the status bar item
    self.statusBar.menu = self.statusMenu;
    self.statusBar.highlightMode = YES;
    */
    
    [self setGoogleOAuth];
    NSLog(@"%@", auth);
    
    //  Register for NotificationCenters
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(screenshotUploadSucceded:) name:@"kScreenshotUploadSucceededNotification" object:nil];
    [[NSUserNotificationCenter defaultUserNotificationCenter]setDelegate:self];
    
    //  Register Hotkeys
    EventHandlerRef gMyHotkeyRef;
    EventHotKeyID gMyHotkeyID;
    EventTypeSpec eventType;
    
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    
    //  Save reference to self so MyHotkeyHandler can refer to it
    refToSelf = self;
    
    InstallApplicationEventHandler(&MyHotkeyHandler, 1, &eventType, nil, nil);
    
    gMyHotkeyID.signature = 'htk1';
    gMyHotkeyID.id = 1;
    
    RegisterEventHotKey(0x15, shiftKey+optionKey, gMyHotkeyID,
                        GetApplicationEventTarget(), 0, &gMyHotkeyRef);
    
}


//
//  Hotkey Handler, simply starts the screenshot process on
//  Hotkey activation.
//
OSStatus MyHotkeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
    
    [refToSelf startScreenshotProcess];
    return noErr;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



#pragma mark - IBAction

- (IBAction)screenshotButtonPush:(id)sender {
    NSLog(@"Button was pushed!");
    [self startScreenshotProcess];
}


//
//  Quit the App
//
- (IBAction)quitApp:(id)sender {
    [NSApp terminate:self];
}


//
//  Open the Window Controller for the Settings Window
//
- (IBAction)settingsButtonPush:(id)sender {
    _settingsWindow = [[SettingsViewController alloc]init];
    [_settingsWindow showWindow:self];
    
}

-(IBAction)togglePanel:(id)sender {
    NSLog(@"Toggle Called, yay!");
}

#pragma mark - Functionality

//
//  Starts the Screenshot process.
//  During the process, a Screenshot is taken, it is uploaded
//  and a Notification is triggered.
//
-(void) startScreenshotProcess {
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


//
//  Checks if the Users is still signed in.
//  Still neede?
//
-(BOOL) userIsSignedIn {
    GoogleOAuth *gtmOperator = [[GoogleOAuth alloc]init];
    if([gtmOperator credentialsInKeychain]) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - NotificationHandler

-(void) screenshotUploadSucceded: (NSNotification *) notification {
    
    //  Reset old screenshotURL
    _screenshotURL = nil;
    
    //  Obtain new screenshotURL
    if([notification object] != nil) {
        NSLog(@"URL Description: %@", [notification object]);
        NSLog(@"This is the extracted screenshotURL: %@", _screenshotURL);
        _screenshotURL = [notification object];
    }
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center
       didActivateNotification:(NSUserNotification *)notification {
    NSLog(@"Hi, you clicked the Notification");
    NSLog(@"The matiching URL is %@", _screenshotURL);

    //  Open URl in default browser
    [[NSWorkspace sharedWorkspace] openURL:_screenshotURL];
}


@end
