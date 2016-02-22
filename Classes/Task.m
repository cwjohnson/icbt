//
//  Task.m
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Task.h"


@implementation Task

@synthesize name;

- (id) initWithName:(NSString *)newName {
	[super init];
	name = newName;
	
	return self;
}
- (void)dealloc {
    [name release], name = nil;
    [super dealloc];
}

- (Trial *)getNextTrial {
	return nil;
}

- (int) getStimulusCount {
	return 0;
}
- (void) reportResult:(TrialResult)result
{
}
- (void)reset {
}

@end
