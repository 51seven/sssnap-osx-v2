//
//  CustomPopOverView.m
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import "CustomStatusItemView.h"

@implementation CustomStatusItemView

-(instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        _isActive = NO;
        _action = @selector(togglePanel:);

    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    //[super drawRect:dirtyRect];
    
    // Drawing code here.
    
    dirtyRect = CGRectInset(dirtyRect, 2, 2);
    [[NSColor selectedMenuItemColor] set];
    NSRectFill(dirtyRect);
}

-(void) mouseDown:(NSEvent *)theEvent {
    
    // DEBUG
    NSLog(@"Mousedown Event");
    NSLog(@"%@", theEvent);
    
    // Sends the action to toggle the panel. Target is nil, so sharedApplication
    // looks for an object that can respond to the message.
    [NSApp sendAction:self.action to:nil from:self];
    
    //[self changeActivityState];
}


-(void) changeActivityState {
    if(self.isActive)
        self.isActive = NO;
    else
        self.isActive = YES;
}


@end
