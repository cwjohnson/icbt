//
//  Trial.h
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

// a Trial is a set of stimuli which has a correct answer
@interface Trial : NSObject {
	NSMutableArray *stimuli;					// list of stimuli to preset to the user
	int				correctAnswerIndex;			// index into stimuli array indicating the correct answer
	NSTimeInterval	timeAllowed;				// length of time allowed for this trial
}

@property (nonatomic, retain)	NSMutableArray *stimuli;
@property (nonatomic)			int correctAnswerIndex;
@property (nonatomic)			NSTimeInterval timeAllowed;

-(Trial *) init;
-(Trial *) initWithStimuli:(NSArray *) stimuli;
-(NSString *) toString;

@end
