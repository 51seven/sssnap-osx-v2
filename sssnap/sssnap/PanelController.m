//
//  PopOverController.m
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import "PanelController.h"



@implementation PanelController

- (instancetype)init
{
    self = [super initWithNibName:@"PanelController" bundle:nil];
    if (self) {
        /*
        self.popover = [[NSPopover alloc] init];
        self.popover.contentViewController = self;
         */
        
        self.panel = [[NSPanel alloc] init];
        self.panel.contentViewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}



@end
