//
//  PopOverController.m
//  sssnap
//
//  Created by Christian Poplawski on 08/02/15.
//  Copyright (c) 2015 51seven. All rights reserved.
//

#import "PopOverController.h"



@implementation PopOverController

- (instancetype)init
{
    self = [super initWithNibName:@"PopOverController" bundle:nil];
    if (self) {
        self.popover = [[NSPopover alloc] init];
        self.popover.contentViewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}



@end
