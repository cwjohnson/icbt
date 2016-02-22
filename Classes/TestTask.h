//
//  TestTask.h
//  iCBT
//
//  Created by Chad Johnson on 1/13/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Task.h"
#import "Trial.h"
#import "Stimulus.h"

typedef enum {
	LEVEL_RED = 0,
	LEVEL_TRIANGLE,
	LEVEL_GREEN,
	LEVEL_SQUARE
} TaskLevel;

@interface TestTask : Task {
	int trialCount;
	int levelTrialCount;
	int levelTrialSuccessCount;
	
	StimulusShape lastShape;
	StimulusColor lastColor;
	
	Trial *		currentTrial;
	TaskLevel	currentLevel;
}

@property(nonatomic, retain) Trial * currentTrial;
@property(nonatomic) TaskLevel currentLevel;

-(Trial *) getNextTrial;
-(Trial *) getNextLevelTrialWithColor:(StimulusColor)requiredColor;
-(Trial *) getNextLevelTrialWithShape:(StimulusShape)requiredShape;

-(int) getStimulusCount;

-(void) resetLevel;
-(void) advanceLevel;
@end
