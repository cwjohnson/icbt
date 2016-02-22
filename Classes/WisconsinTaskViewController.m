    //
//  WisconsinTaskViewController.m
//  iCBT
//
//  Created by Chad Johnson on 1/14/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "WisconsinTaskViewController.h"
#import "WisconsinTask.h"
#import "Stimulus.h"
#import "StimulusUIButton.h"
#import "FailureView.h"

#define STIMULUS_WIDTH 130
#define STIMULUS_HEIGHT 130

@implementation WisconsinTaskViewController

@synthesize options;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


- (id)initWithNibName:(NSString *)nibNameOrNil viewClass:(Class)vc options:(NSDictionary *)optionsDict {
	self = [super initWithNibName:nibNameOrNil viewClass:vc];
	if (self) {
		// Custom initialization.
		options = optionsDict;
	}
	return self;
 }

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSEnumerator * enumerator = [options keyEnumerator];
	id key;
	while ((key = [enumerator nextObject]))
	{
		NSLog(@"key=[%@] value=[%@]", (NSString *)key, [options valueForKey:(NSString *)key]);
	}
	
	// make the task
	task = [[WisconsinTask alloc] initWithOptions:self.options];

	self.title = [options objectForKey:@"title"];
	
	// how many stimuli will we get from the task
	int stimulusCount = [task getStimulusCount];
	
	// construct an array to hold our stimuus buttons
	stimulusButtons = [[NSMutableArray alloc] init];
	
	CGFloat y = 210.0;
	// contruct a button for each stimuli
	for (int i = 0 ; i < stimulusCount ; i++)
	{
		StimulusUIButton * button = [StimulusUIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:@selector(stimulusTouched:) forControlEvents:UIControlEventTouchDown];
		button.frame = CGRectMake(80.0, y, 130.0, 130.0);
		[stimulusButtons addObject:button];
		
		[self.view addSubview:button];
		
		y += 140.0;
	}	
	
	// add the failure subview....it will be "unhidden" when a failure response is received
	//failureView = [[FailureView alloc] initWithFrame:self.view.frame];
	UIImage *invalidImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invalid" ofType:@"png"]];
	failureView = [[UIImageView alloc] initWithImage:invalidImage];
	failureView.backgroundColor = [UIColor blueColor];
	[self.view addSubview:failureView];
	
	// initialize audio for success and failure
	currentPlayer = nil;
	NSBundle *mainBundle = [NSBundle mainBundle];
	NSError *err = nil;
	NSURL *buzzerURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"buzzer" ofType:@"wav"]];
	wrongPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:buzzerURL error:&err];
	if (!wrongPlayer)
	{
		NSLog(@"no wrongPlayer: %@", [err localizedDescription]);
	}
	wrongPlayer.delegate = self;
	//wrongPlayer.volume = 0.1;			// match volume with success
	[wrongPlayer setNumberOfLoops:0];
	[wrongPlayer prepareToPlay];
	
	NSURL *successURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"ding" ofType:@"wav"]];
	successPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:successURL error:&err];
	if (!successPlayer)
	{
		NSLog(@"no successPlayer: %@", [err localizedDescription]);
	}
	successPlayer.delegate = self;
	NSLog(@"success volume=%g", successPlayer.volume);
	[successPlayer setNumberOfLoops:0];
	[successPlayer prepareToPlay];
	
	NSURL *applauseURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"applause" ofType:@"mp3"]];
	applausePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:applauseURL error:&err];
	if (!applausePlayer)
	{
		NSLog(@"no applausePlayer: %@", [err localizedDescription]);
	}
	applausePlayer.delegate = self;
	[applausePlayer setNumberOfLoops:0];
	[applausePlayer prepareToPlay];
}

-(void) stimulusTouched:(id) which
{
	// stop the timer
	[trialTimer invalidate];
	trialTimer = nil;
	
	NSLog (@"stimulus touched %@", ((StimulusUIButton *)which).titleLabel);
	
	StimulusUIButton * touched = which;
	
	bool correct = false;
	int index = 0;
	while (!correct && index < [stimulusButtons count])
	{
		StimulusUIButton * o = [stimulusButtons objectAtIndex:index];
		o.enabled = NO;
		correct = ( o == touched && index == currentTrial.correctAnswerIndex);
		++index;
	}
	
	[self handleAnswer:(correct ? SUCCESS : FAILURE)];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}
 */

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self placeStimuliCurrent];

	failureView.bounds = self.view.bounds;
	[failureView setNeedsLayout];
}

- (void)startTask
{
	[task reset];
	
	[self nextTrial];
}

- (void)nextTrial
{
	// get the next trial from the task
	currentTrial = [task getNextTrial];
	
	if (currentTrial == nil)	// test is complete for now restart the test.
	{
		[task reset];
		
		[self handleAnswer:COMPLETE];
	}
	
	if (currentTrial != nil)
	{		
		// start the timeout timer
		trialTimer = [NSTimer scheduledTimerWithTimeInterval:currentTrial.timeAllowed target:self selector:@selector(trialTimedOut:) userInfo:NULL repeats:NO];
		
		// set and place the stimuli
		[self setStimuli];
		
		// make sure the failure view is hidden
		failureView.hidden = YES;
	
		NSLog(@"%@", [currentTrial toString]);
	} else {
		NSLog (@"Failed to get a trial from the task");
	}	
}

-(void)setStimuli
{	
	[self placeStimuli];
		
	for (int i = 0 ; i < [currentTrial.stimuli count] ; i++)
	{
		NSArray * stimuli = currentTrial.stimuli;
		Stimulus *s = [stimuli objectAtIndex:i];
		
		StimulusUIButton *button = [stimulusButtons objectAtIndex:i];
		button.stimulus = s;
		button.enabled = YES;
		
		//NSString * str = [NSString stringWithFormat:@"color[%d] shape[%d]", s.color, s.shape];
		//[button setTitle:str forState:UIControlStateNormal];		
		
		// force a redraw
		[button setNeedsDisplay];
	}
}

- (void)placeStimuli
{
	// what is the space we have to play with
	CGSize boundsSize = self.view.bounds.size;
	
	CGSize boundedSize = boundsSize;
	
	boundedSize.width = boundsSize.width - STIMULUS_WIDTH;
	boundedSize.height = boundsSize.height - STIMULUS_HEIGHT;
	
	double minimumDist = sqrt(STIMULUS_WIDTH * STIMULUS_HEIGHT) * 2;
	
	int placed = 0;
	while (placed < [currentTrial.stimuli count])
	{
		StimulusUIButton *button = [stimulusButtons objectAtIndex:placed];
		CGPoint newLoc = [self getRandomPointWithinSize:boundedSize];

		bool outside = true;
		if (placed > 0)
		{
			int j = 0;
			while (outside && j < placed)
			{
				StimulusUIButton *testButton = [stimulusButtons objectAtIndex:j];
				float x2 = (newLoc.x - testButton.frame.origin.x) * (newLoc.x - testButton.frame.origin.x);
				float y2 = (newLoc.y - testButton.frame.origin.y) * (newLoc.y - testButton.frame.origin.y);
				double dist = sqrt(x2 + y2);
				outside = (dist > minimumDist);
				//NSLog(@"newLoc[%f,%f] test[%f,%f]", newLoc.x, newLoc.y, testButton.frame.origin.x, testButton.frame.origin.y);
				//NSLog(@"dist[%f] > minimumDist[%f] = %d", dist, minimumDist, outside);
				
				++j;
			}
		}
		if (outside)
		{
			CGPoint relativeLoc;
			relativeLoc.x = newLoc.x / boundsSize.width;
			relativeLoc.y = newLoc.y / boundsSize.height;
			button.relativeLoc = relativeLoc;
			
			//button.frame = CGRectMake(newLoc.x, newLoc.y, STIMULUS_WIDTH, STIMULUS_HEIGHT);
			++placed;
		}
		
		[self placeStimuliCurrent];
	}
}

-(void)placeStimuliCurrent
{
	CGSize boundsSize = self.view.bounds.size;
	
	int placed = 0;
	while (placed < [currentTrial.stimuli count])
	{				
		StimulusUIButton *button = [stimulusButtons objectAtIndex:placed];
		
		button.frame = CGRectMake(button.relativeLoc.x * boundsSize.width, button.relativeLoc.y * boundsSize.height, STIMULUS_WIDTH, STIMULUS_HEIGHT);
		
		++placed;
	}		
}
- (CGPoint)getRandomPointWithinSize:(CGSize)bounds
{
	CGPoint point;
	
	point.x = (float) (arc4random() % (uint32_t) bounds.width);
	point.y = (float) (arc4random() % (uint32_t) bounds.height);
	
	return point;
}

- (void)trialTimedOut:(NSTimer *)theTimer
{
	NSLog(@"TIMEOUT!!!!!");
	// remove the timer
	[trialTimer invalidate];
	trialTimer = nil;
	
	// report the result
	//[task reportResult:TIMEOUT];
	
	// play wrong sound
	currentPlayer = wrongPlayer;
	[self handleAnswer:TIMEOUT];

}


-(void) handleAnswer:(TrialResult)result
{
	// report to the task
	[self.task reportResult:result];
	
	NSLog(@"correct[%d]\n", (result == SUCCESS) ? YES : NO);
	
	switch (result)
	{
		case SUCCESS:
			currentPlayer = successPlayer;
			break;
		case FAILURE: case TIMEOUT:
			failureView.hidden = NO;		// show the failure view
			currentPlayer = wrongPlayer;
			break;
		case COMPLETE:
			currentPlayer = applausePlayer;
	}
	
	[currentPlayer prepareToPlay];
	[currentPlayer play];
	
}

-(void) handleWrongAnswer
{
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{


	if (currentPlayer == applausePlayer)
	{
		UINavigationController *nav = self.navigationController;	// if the current player is the applause player
		[nav popViewControllerAnimated:YES];	// then we are finished
		return;
	}

	// load up the next trial
	[self nextTrial];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

// enable the timeout timer
- (void)viewWillAppear:(BOOL)animated
{
	[self startTask];
}

// stop any sounds
// disable the timeout timer
- (void)viewWillDisappear:(BOOL)animated
{
	if (trialTimer != nil && [trialTimer isValid] == YES)
	{
		[trialTimer invalidate];
		trialTimer = nil;
	}
	if (wrongPlayer.isPlaying == YES)
	{
		[wrongPlayer stop];
	}
	if (successPlayer.isPlaying == YES)
	{
		[successPlayer stop];
	}
	if (applausePlayer.isPlaying == YES)
	{
		[applausePlayer stop];
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[task dealloc], task=nil;

	[failureView release];

	if (wrongPlayer.isPlaying == YES)
	{
		[wrongPlayer stop];
	}
	[wrongPlayer dealloc], wrongPlayer=nil;
	if (successPlayer.isPlaying == YES)
	{
		[successPlayer stop];
	}
	[successPlayer dealloc], successPlayer=nil;
	if (applausePlayer.isPlaying == YES)
	{
		[applausePlayer stop];
	}
	[applausePlayer dealloc], applausePlayer=nil;
}


@end
