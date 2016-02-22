//
//  Trial.m
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Trial.h"
#import "Stimulus.h"

@implementation Trial

@synthesize stimuli, correctAnswerIndex, timeAllowed;

-(Trial *) init
{
	self.stimuli = [[NSMutableArray alloc] init];
	
	return self;
}

-(Trial *) initWithStimuli:(NSArray *) newStimuli
{
	self.stimuli = [[NSMutableArray alloc] initWithArray:newStimuli];
	
	return self;
}

-(NSString *) toString
{
	NSMutableString * str = [NSMutableString stringWithCapacity:0];
	[str appendString:@"Trial\n"];
	
	for (int i = 0 ; i < self.stimuli.count ; i++)
	{
		if (i == correctAnswerIndex)	[str appendString:@" *"];
		else							[str appendString:@"  "];

		Stimulus * s = (Stimulus *)[self.stimuli objectAtIndex:i];
		[str appendFormat:@"  %d: %@\n", i, [s toString]];
	}
	
	return str;
}

@end
