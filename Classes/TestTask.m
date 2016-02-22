//
//  TestTask.m
//  iCBT
//
//  Created by Chad Johnson on 1/13/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "TestTask.h"
#import "Stimulus.h"

#define MAXTRIALCOUNT			100		// total number of trials
#define TIMEOUTLENGTH			2		// length of error 
#define TRIALTIMEALLOWANCE		10.0	// time allowed for each trial (seconds)
#define STIMULICOUNT			3		// total number of stimuli
#define MINIMUMSUCCESS			5		// minimum number of success required to move to next level


@implementation TestTask

@synthesize currentLevel, currentTrial;

-(id) init
{
	[super initWithName:@"Wisconsin CST"];
	
	[self reset];
	
	self.currentTrial = [[Trial	alloc] init];
	for (int i = 0 ; i < STIMULICOUNT ; i++)
	{
		[self.currentTrial.stimuli addObject:[[Stimulus alloc] init]];
	}
	
	lastColor = arc4random() % 4;
	lastShape = arc4random() % 3;
	
	return self;
}

-(int) getStimulusCount
{
	return STIMULICOUNT;
}

// get the next trial
// return nil when done;
-(Trial *)getNextTrial
{
	NSLog(@"TestTask: currentLevel[%d] sucesses[%d/%d] trialCount[%d]\n", currentLevel, levelTrialSuccessCount, MINIMUMSUCCESS, trialCount);
	if (++trialCount > MAXTRIALCOUNT)
		return nil;
	
	++levelTrialCount;

	switch (currentLevel) {
		case LEVEL_RED:
			currentTrial = [self getNextLevelTrialWithColor:STIMULUS_COLOR_RED];
			break;
		case LEVEL_TRIANGLE:
			currentTrial = [self getNextLevelTrialWithShape:TRIANGLE];
			break;
		// 2011/02/18 only perform one shift for demo purposes
		/*
		case LEVEL_GREEN:
			currentTrial = [self getNextLevelTrialWithColor:STIMULUS_COLOR_GREEN];
			break;
		case LEVEL_SQUARE:
			currentTrial = [self getNextLevelTrialWithShape:SQUARE];
			break;
		 */
		default:
			return (nil);	// completed
	}
	currentTrial.timeAllowed = TRIALTIMEALLOWANCE;
	
	// TODO: factor up a new trial
	return currentTrial;
}

-(Trial *)getNextLevelTrialWithColor:(StimulusColor)requiredColor
{
	NSMutableDictionary *colorsDict = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *shapesDict = [[NSMutableDictionary alloc] init];
	
	StimulusColor colors[STIMULICOUNT] = {0};
	StimulusShape shapes[STIMULICOUNT] = {0};
	
	bool haveColor = FALSE;
	while (!haveColor)
	{
		int index = 0;
		[colorsDict removeAllObjects];
		while ([colorsDict count] < STIMULICOUNT)
		{
			NSNumber *color = [NSNumber numberWithUnsignedInt:(arc4random() % 4)];
			if ([colorsDict objectForKey:color] != nil)
			{
				continue;	// already have this color
			}
			[colorsDict setObject:color forKey:color];
			colors[index] = [color intValue];
			if (!haveColor)
			{
				haveColor = ([color intValue] == requiredColor);
				if (haveColor) currentTrial.correctAnswerIndex = index;
			}

			++index;
		}
	}
	
	bool newShape = FALSE;
	while (!newShape)
	{
		int index = 0;
		[shapesDict removeAllObjects];
		while ([shapesDict count] < STIMULICOUNT)
		{
			NSNumber *shape = [NSNumber numberWithUnsignedInt:(arc4random() % 3)];
			if ([shapesDict objectForKey:shape] != nil)
			{
				continue;	// already have this shape
			}
			[shapesDict setObject:shape forKey:shape];
			shapes[index] = [shape intValue];
			if (!newShape && index == currentTrial.correctAnswerIndex)
			{
				newShape = ([shape intValue] != lastShape);
			}
			++index;
		}
	}
	lastShape = shapes[currentTrial.correctAnswerIndex];
	
	// no longer need the dicts
	[shapesDict release], shapesDict = nil;
	[colorsDict release], colorsDict = nil;
	
	// set the stimuli
	for (int i = 0 ; i < STIMULICOUNT ; i++)
	{
		Stimulus *s = (Stimulus *)[self.currentTrial.stimuli objectAtIndex:i];
		s.color = colors[i];
		s.shape = shapes[i];	
	}
	
	return currentTrial;
}

-(Trial *)getNextLevelTrialWithShape:(StimulusShape)requiredShape
{
	NSMutableDictionary *colorsDict = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *shapesDict = [[NSMutableDictionary alloc] init];
	
	StimulusColor colors[STIMULICOUNT] = {0};
	StimulusShape shapes[STIMULICOUNT] = {0};
	
	bool haveShape = FALSE;
	while (!haveShape)
	{
		int index = 0;
		[shapesDict removeAllObjects];
		while ([shapesDict count] < STIMULICOUNT)
		{
			NSNumber *shape = [NSNumber numberWithUnsignedInt:(arc4random() % 3)];
			if ([shapesDict objectForKey:shape] != nil)
			{
				continue;	// already have this shape
			}
			[shapesDict setObject:shape forKey:shape];
			shapes[index] = [shape intValue];
			if (!haveShape)
			{
				haveShape = ([shape intValue] == requiredShape);
				if (haveShape) currentTrial.correctAnswerIndex = index;
			}
			++index;
		}
	}
	
	bool newColor = FALSE;
	while (!newColor)
	{
		int index = 0;
		[colorsDict removeAllObjects];
		while ([colorsDict count] < STIMULICOUNT)
		{
			NSNumber *color = [NSNumber numberWithUnsignedInt:(arc4random() % 4)];
			if ([colorsDict objectForKey:color] != nil)
			{
				continue;	// already have this color
			}
			[colorsDict setObject:color forKey:color];
			colors[index] = [color intValue];
			if (!newColor && index == currentTrial.correctAnswerIndex)
			{
				newColor = ([color intValue] != lastColor);
			}
			++index;
		}
	}
	lastColor = colors[currentTrial.correctAnswerIndex];

	
	// no longer need the dicts
	[shapesDict release], shapesDict = nil;
	[colorsDict release], colorsDict = nil;
	
	// set the stimuli
	for (int i = 0 ; i < STIMULICOUNT ; i++)
	{
		Stimulus *s = (Stimulus *)[self.currentTrial.stimuli objectAtIndex:i];
		s.color = colors[i];
		s.shape = shapes[i];	
	}
	
	return currentTrial;
}

-(void) reportResult:(TrialResult)result
{
	if (result == SUCCESS)	
		++levelTrialSuccessCount;
	else {
		// FIXME: does a failure reset the level
		[self resetLevel];
	}

	if (levelTrialSuccessCount >= MINIMUMSUCCESS)
	{
		// advance to the next level
		[self advanceLevel];
	}
	
}

// reset the current level
//	clear success counter
-(void) resetLevel
{
	levelTrialSuccessCount = 0;
}

// advance to the next level
//	reset level counters
//	switch to the next level
-(void) advanceLevel
{
	levelTrialCount = 0;
	++currentLevel;
	
	[self resetLevel];
}

-(void) reset
{
	levelTrialSuccessCount = trialCount = levelTrialCount = 0;

	currentLevel = LEVEL_RED;
}

-(void) dealloc
{
	[super dealloc];
}
@end
