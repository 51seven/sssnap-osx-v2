//
//  CustomPopOverView.h
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelController.h"

@interface CustomStatusItemView : NSView

@property BOOL isActive;
@property SEL action;


-(void) mouseDown:(NSEvent *)theEvent;

@end
