//
//  FailureView.m
//  iCBT
//
//  Created by Chad Johnson on 2/18/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "FailureView.h"


@implementation FailureView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
	
	self.hidden = YES;
	self.backgroundColor = [UIColor blueColor];
	
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
