//
//  PopOverController.h
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "CustomStatusItemView.h"
#import "PopOverController.h"

@interface MainMenuController : NSObject

@property NSStatusItem *statusItem;
@property CustomStatusItemView *customView;
@property PopOverController *viewController;
@property BOOL isActive;

@end
