//
//  Stimulus.h
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum StimulusShape
{
	CIRCLE = 0,
	SQUARE,
	TRIANGLE
} StimulusShape;

typedef enum StimulusColor
{
	STIMULUS_COLOR_RED,
	STIMULUS_COLOR_GREEN,
	STIMULUS_COLOR_BLUE,
	STIMULUS_COLOR_YELLOW
} StimulusColor;

// stimuli is a shape of a given color
@interface Stimulus : NSObject {
	StimulusColor	color;
	StimulusShape	shape;
}

@property (nonatomic)	StimulusColor	color;
@property (nonatomic)	StimulusShape	shape;

-(NSString *)toString;
@end
