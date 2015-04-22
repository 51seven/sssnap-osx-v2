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

static NSString * const kClientIDKey = @"ClientID";
static NSString * const kClientSecretKey = @"ClientSecret";

-(id) init {
    if(self = [super init]){
        
        
        // Scopes to be used
        NSString *plusMeScope = @"https://www.googleapis.com/auth/plus.me";
        NSString *userinfoEmailScope = @"https://www.googleapis.com/auth/userinfo.email";
        
        // Set credentials
        scope = [GTMOAuth2Authentication scopeWithStrings:plusMeScope, userinfoEmailScope, nil];
        MyClientID = [self credentialsForKey:kClientIDKey];
        MyClientSecret = [self credentialsForKey:kClientSecretKey];
        KeychainItemName = @"sssnap: Google plus";
    }
    
    return self;
}

-(void)displaySignInSheet:(NSWindow *)targetWindow {
    
    GTMOAuth2WindowController *windowController;
    windowController = [[[GTMOAuth2WindowController alloc] initWithScope:scope
                                                                clientID:MyClientID
                                                            clientSecret:MyClientSecret
                                                        keychainItemName:KeychainItemName
                                                          resourceBundle:nil] autorelease];
    
    [windowController signInSheetModalForWindow:targetWindow
                                 delegate:self
                         finishedSelector:@selector(windowController:finishedWithAuth:error:)];
}


- (GTMOAuth2Authentication *) getAuthFromKeychain {
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2WindowController authForGoogleFromKeychainForName:KeychainItemName
                                                                 clientID:MyClientID
                                                             clientSecret:MyClientSecret];
    
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

- (void)removeItemFromKeychain
{
    [GTMOAuth2WindowController removeAuthFromKeychainForName:KeychainItemName];
    [GTMOAuth2WindowController revokeTokenForGoogleAuthentication:[self getAuthFromKeychain]];
}

#pragma mark - G+ Credentials

/**
 *  Returns the Google+ App-Credentials for a given key.
 *
 *  @param theKey the key for which the value is desired 
 *
 *  @return The Value for the desired key
 *
 *  @note theKey can only be 'ClientID' or 'ClientSecret'
 *
 */
-(NSString *) credentialsForKey: (NSString *) theKey {
    
    NSString *credentials;
    NSDictionary *credentialsDict = [self appCredentials];
    
    if (credentialsDict) {
        credentials = [credentialsDict valueForKey:theKey];
    } else {
        NSLog(@"Credentials.plist doesn't seem to exist.");
        credentials = nil;
    }
    
    return credentials;
}


/**
 *  Returns a dictionary with the Google+ App-Credentials like ClientID and ClientSecret
 *  from a .plist file.
 *
 *  @return An NSDictionary with the credentials
 *
 *  @note The .plist file containing the credentials will not be pushed to git and can only be accessed
 *        from the built app. Sorry, brah.
 *
 */
-(NSDictionary *) appCredentials {
    
    NSDictionary *credentialsDict;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Credentials" ofType:@"plist"];
    
    if(!path) {
        NSLog(@"Credentials.plist was not found.");
        credentialsDict = nil;
    } else {
         credentialsDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    // Debug
    NSLog(@"%@", path);
    
    return credentialsDict;
}


@end













