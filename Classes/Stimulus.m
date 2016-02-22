//
//  Stimulus.m
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Stimulus.h"


@implementation Stimulus

@synthesize color, shape;

-(NSString *)toString
{
	NSMutableString * str = [NSMutableString stringWithCapacity:0];
	switch (self.color)
	{
		case STIMULUS_COLOR_RED:
			[str appendString:@"RED "];
			break;
		case STIMULUS_COLOR_GREEN:
			[str appendString:@"GREEN "];
			break;
		case STIMULUS_COLOR_BLUE:
			[str appendString:@"BLUE "];
			break;
		case STIMULUS_COLOR_YELLOW:
			[str appendString:@"YELLOW "];
			break;
	}
	
	switch (self.shape)
	{
		case CIRCLE:
			[str appendString:@"CIRCLE"];
			break;
		case SQUARE:
			[str appendString:@"SQUARE"];
			break;
		case TRIANGLE:
			[str appendString:@"TRIANGLE"];
			break;
	}

	return str;
}
@end
