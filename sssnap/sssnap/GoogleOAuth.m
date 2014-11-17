//
//  GoogleOAuth.m
//  sssnap
//
//  This class is responsible for the authentification with Google.
//  The Object is initiated with the needed credentials (e.g. ClientID, scopes, etc).
//  NOTE: This Class has ARC DISABLED because Google wnats it that way.
//
//  Created by Christian Poplawski on 03/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import "GoogleOAuth.h"

@interface GoogleOAuth ()

@end

@implementation GoogleOAuth



-(id) init {
    if(self = [super init]){
        
        //Scopes to be used
        NSString *plusMeScope = @"https://www.googleapis.com/auth/plus.me";
        NSString *userinfoEmailScope = @"https://www.googleapis.com/auth/userinfo.email";
        
        //  Ceredentials
        scope = [GTMOAuth2Authentication scopeWithStrings:plusMeScope, userinfoEmailScope, nil];
        kMyClientID = @"947766948-22hqf8ngu94rmepn5m0ucp5a6mo4jsak.apps.googleusercontent.com";
        kMyClientSecret = @"_2PD85cvQck4dQGAl4Bvqnbc";
        kKeychainItemName = @"sssnap: Google plus";
    }
    
    return self;
}

-(void)displaySignInSheet:(NSWindow *)targetWindow {
    
    GTMOAuth2WindowController *windowController;
    windowController = [[[GTMOAuth2WindowController alloc] initWithScope:scope
                                                                clientID:kMyClientID
                                                            clientSecret:kMyClientSecret
                                                        keychainItemName:kKeychainItemName
                                                          resourceBundle:nil] autorelease];
    
    [windowController signInSheetModalForWindow:targetWindow
                                 delegate:self
                         finishedSelector:@selector(windowController:finishedWithAuth:error:)];
}


- (GTMOAuth2Authentication *) getAuthFromKeychain {
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2WindowController authForGoogleFromKeychainForName:kKeychainItemName
                                                                 clientID:kMyClientID
                                                             clientSecret:kMyClientSecret];
    
    // Retain the authentication object, which holds the auth tokens
    //
    // We can determine later if the auth object contains an access token
    // by calling its -canAuthorize method
    NSLog(@"%@", auth);
    
    return auth;
}

//
//  TODO: Error handling
//  TODO: do something on sucess
//
- (void)windowController:(GTMOAuth2WindowController *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed
    } else {
        // Authentication succeeded
        NSLog(@"%@", [NSDate date]);
        NSLog(@"%@", [auth description]);
        NSLog(@"%@", [auth accessToken]);
    }
}


-(BOOL) credentialsInKeychain {
    GTMOAuth2Authentication *auth = [self getAuthFromKeychain];
    if([auth canAuthorize]) {
        return YES;
    } else {
        return NO;
    }
    
}


@end
