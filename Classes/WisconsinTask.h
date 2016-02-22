//
//  WisconsinTask.h
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
	LEVEL_SQUARE,
	NUM_LEVELS
} TaskLevel;

typedef enum {
	ANSWERTYPE_SHAPE = 0,
	ANSWERTYPE_COLOR
} AnswerType;

@interface WisconsinTaskLevel {
	AnswerType		answerType;
	StimulusColor	color;
	StimulusShape	shape;
}
@end

@interface WisconsinTask : Task {
	int trialCount;
	int levelTrialCount;
	int levelTrialSuccessCount;
	int maxLevel;
	NSArray *randomLevels;
	
	StimulusShape lastShape;
	StimulusColor lastColor;
	
	Trial *		currentTrial;
	TaskLevel	currentLevel;
	
	NSMutableArray *randomLevelStimulus;
}

@property(nonatomic, retain) Trial * currentTrial;
@property(nonatomic) TaskLevel currentLevel;
@property(nonatomic, retain) NSMutableArray * randomLevelStimulus;

-(id) initWithOptions:(NSDictionary *)options;
-(Trial *) getNextTrial;
-(Trial *) getNextLevelTrialWithColor:(StimulusColor)requiredColor andShape:(StimulusShape)requiredShape;
-(Trial *) getNextLevelTrialWithColor:(StimulusColor)requiredColor;
-(Trial *) getNextLevelTrialWithShape:(StimulusShape)requiredShape;
-(void) randomizeLevels;

//-(void) nextRandomShape;
//-(void) nextRandomColor;

-(int) getStimulusCount;

-(void) resetLevel;
-(void) advanceLevel;
@end
