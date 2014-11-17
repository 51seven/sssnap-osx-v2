//
//  ServerAuth.h
//  sssnap
//
//  Created by Christian Poplawski on 04/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMOAuth2Authentication.h"
#import "GoogleOAuth.h"

@interface ServerAuth : NSObject

@property GTMOAuth2Authentication * auth;

-(NSMutableArray *) getUserCredentials;
-(NSMutableDictionary *) authRequestAndSend: (NSMutableURLRequest*) request;


@end
