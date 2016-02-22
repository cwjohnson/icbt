//
//  WisconsinTaskViewController.h
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TaskViewController.h"
#import "Trial.h"
#import "FailureView.h"

@interface WisconsinTaskViewController : TaskViewController <AVAudioPlayerDelegate> {
	NSMutableArray	* stimulusButtons;
	Trial * currentTrial;
	NSTimer * trialTimer;
	NSDictionary *options;
	
	UIImageView * failureView;
	
	AVAudioPlayer * wrongPlayer;
	AVAudioPlayer * successPlayer;
	AVAudioPlayer * currentPlayer;
	AVAudioPlayer * applausePlayer;
}

@property(nonatomic, retain) NSDictionary* options;

-(id) initWithNibName:(NSString *)nib viewClass:(Class)vc options:(NSDictionary *)optionsDict;
-(void) startTask;
-(void) nextTrial;
-(CGPoint) getRandomPointWithinSize:(CGSize)bounds;
-(void) trialTimedOut:(NSTimer *)theTimer;
-(void) handleAnswer:(TrialResult)result;
-(void) handleWrongAnswer;

-(void) setStimuli;
-(void) placeStimuli;
-(void) placeStimuliCurrent;
@end
