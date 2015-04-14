//
//  PopOverController.m
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import "MainMenuController.h"

@implementation MainMenuController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Set up StatusBar icon
        CGFloat thickness = [[NSStatusBar systemStatusBar] thickness];
        self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:thickness];
        self.customView = [[CustomStatusItemView alloc] initWithFrame:NSMakeRect(0, 0, thickness, thickness)];
        [self.statusItem setView:self.customView];
        [self.statusItem setHighlightMode:YES];
        
        
        //Add observer for click events on custom view
        [self.customView addObserver:self forKeyPath:@"isActive" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
        
        //Init Popover Viewcontroller
        self.viewController = [[PopOverController alloc] init];
    }
    
    return self;
}


//Observer for changes in activity state of custom view
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"isActive"]) {
        // DEBUG
        NSLog(@"Active state changed!");
        NSLog(@"%hhd", self.customView.isActive);
        
        self.isActive = self.customView.isActive;
        
        if(self.isActive)
            [self openPopover];
         else
            [self closePopover];
        
    }
}


-(void) openPopover {
    NSLog(@"I was called at least");
    [self.viewController.popover showRelativeToRect:[self.customView frame]
                                             ofView:self.customView
                                      preferredEdge:NSMinYEdge];
}

-(void) closePopover {
    [self.viewController.popover performClose:self];
}

@end
