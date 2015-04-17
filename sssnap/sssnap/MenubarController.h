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

@interface MenubarController : NSObject

@property NSStatusItem *statusItem;
@property CustomStatusItemView *statusItemView;
@property PopOverController *viewController;
@property BOOL isActive;

@end