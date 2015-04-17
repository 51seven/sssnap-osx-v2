//
//  PopOverController.m
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import "MenubarController.h"

@implementation MenubarController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // Set dimensions for StatusItemView
        // Thickness of systemStatusBar is used for height and width to achieve a square item
        CGFloat thickness = [[NSStatusBar systemStatusBar] thickness];
        NSRect measurements = NSMakeRect(0, 0, thickness, thickness);
        
        self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:thickness];
        self.statusItemView = [[CustomStatusItemView alloc] initWithFrame:measurements];
        [self.statusItem setView:self.statusItemView];
        
        /*
        [self.statusItem setHighlightMode:YES];
        */
        
        /*Add observer for click events on custom view
        [self.statusItemView addObserver:self forKeyPath:@"isActive" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
        
        //Init Popover Viewcontroller
        self.viewController = [[PopOverController alloc] init];
         */
    }
    
    return self;
}


/*Observer for changes in activity state of custom view
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"isActive"]) {
        // DEBUG
        NSLog(@"Active state changed!");
        NSLog(@"%hhd", self.statusItemView.isActive);
        
        self.isActive = self.statusItemView.isActive;
        
        if(self.isActive)
            [self openPopover];
         else
            [self closePopover];
        
    }
}
 */


@end
