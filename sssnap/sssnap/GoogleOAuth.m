//
//  GoogleOAuth.m
//  sssnap
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
        scope = @"https://www.googleapis.com/auth/plus.me";
        kMyClientID = @"947766948-jfg15iuqdppa55e3btd190jg3hemtoe2.apps.googleusercontent.com";
        kMyClientSecret = @"GMViyz83-cxrjNqwNMs8fQ1X";
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

- (void)windowController:(GTMOAuth2WindowController *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed
    } else {
        // Authentication succeeded
    }
}


@end
