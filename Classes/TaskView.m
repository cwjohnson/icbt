//
//  TaskView.m
//  iCBT
//
//  Created by Chad Johnson on 1/15/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "TaskView.h"


@implementation TaskView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		// default to black background
		self.backgroundColor = [UIColor blackColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)context
{
	// Default is to do nothing
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	[self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)dealloc {
    [super dealloc];
}


@end
