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
#import "PanelController.h"

@interface MenubarController : NSObject

@property NSStatusItem *statusItem;
@property CustomStatusItemView *statusItemView;
@property PanelController *viewController;
@property BOOL isActive;

@end
