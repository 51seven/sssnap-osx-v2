//
//  UserNotification.h
//  sssnap
//
//  Created by Christian Poplawski on 17/11/14.
//  Copyright (c) 2014 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNotification : NSObject

-(instancetype) init __attribute__((unavailable("Use initWithScreenshot instead")));

@property NSURL *screenshotURL;
@property NSError *uploadError;

-(id) initWithURL: (NSURL *) screenshotURL andError: (NSError *) error;

-(void) sendNotification;
-(void) sendSuccessfulNotification;
-(void) sendErrorNotification: (NSError *) error;

@end
