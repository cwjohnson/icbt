//
//  StimulusUIButton.m
//  iCBT
//
//  Created by Chad Johnson on 1/18/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "StimulusUIButton.h"


@implementation StimulusUIButton

@synthesize stimulus;
@synthesize relativeLoc;

-(void)drawRect:(CGRect)rect{
	NSLog(@"%x %d %d\n", (int)self, stimulus.color, stimulus.shape);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	switch (stimulus.color)
	{
		case STIMULUS_COLOR_RED:
			CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
			CGContextSetRGBFillColor  (context, 1.0, 0.0, 0.0, 1.0);
			break;
		case STIMULUS_COLOR_GREEN:
			CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
			CGContextSetRGBFillColor  (context, 0.0, 1.0, 0.0, 1.0);
			break;
		case STIMULUS_COLOR_BLUE:
			CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
			CGContextSetRGBFillColor  (context, 0.0, 0.0, 1.0, 1.0);
			break;
		case STIMULUS_COLOR_YELLOW:
			CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
			CGContextSetRGBFillColor  (context, 1.0, 1.0, 0.0, 1.0);
			break;
	}
	switch (stimulus.shape)
	{
		case CIRCLE:
			CGContextStrokeEllipseInRect(context, rect);
			CGContextFillEllipseInRect(context, rect);
			break;
		case TRIANGLE:
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, 0.0, rect.size.height);
			CGContextAddLineToPoint(context, rect.size.width / 2.0, 0.0);
			CGContextAddLineToPoint(context, rect.size.width, rect.size.height);	
			CGContextFillPath(context);
			break;
		case SQUARE:
			CGContextFillRect(context, rect);
			CGContextStrokePath(context);
			break;
	}

	// Draw them with a 2.0 stroke width so they are a bit more visible.
	//CGContextSetLineWidth(context, 2.0);
	
	// Add Rect to the current path, then stroke it
	//CGContextAddRect(context, CGRectMake(30.0, 30.0, 60.0, 60.0));


	/*
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(ctx,[ UIColorredColor].CGColor);
    CGContextBeginPath(ctx); 
	CGContextSetLineWidth(ctx, 3.0);
    CGContextMoveToPoint(ctx,rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(ctx, rect.size.width,rect.size.height);
    CGContextDrawPath(ctx,kCGPathStroke);
	 */
}
@end
