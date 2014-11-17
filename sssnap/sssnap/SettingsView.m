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

#import "SettingsView.h"

@interface SettingsView ()

@end

@implementation SettingsView

-(id) init {
    self = [super initWithWindowNibName:@"SettingsView"];
    if(self == nil){
        return nil;
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

//
//  Call Google Sign In Sheet on click
//
- (IBAction)signInGoogleButtonPush:(id)sender {
    GoogleOAuth *auth = [[GoogleOAuth alloc]init];
    [auth displaySignInSheet:_setingsWindow];
}
@end
