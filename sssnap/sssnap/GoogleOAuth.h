//
//  GoogleOAuth.h
//  sssnap
//
//  Created by Christian Poplawski on 03/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GTMOAuth2WindowController.h"
#import "GTMOAuth2Authentication.h"

@interface GoogleOAuth : NSWindowController{
    NSString *scope;
    NSString *MyClientID;
    NSString *MyClientSecret;
    NSString *KeychainItemName;
}

- (void)displaySignInSheet: (NSWindow *)targetWindow;
- (GTMOAuth2Authentication *) getAuthFromKeychain;
- (BOOL) credentialsInKeychain;
- (void) removeItemFromKeychain;

@end
