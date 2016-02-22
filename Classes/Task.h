//
//  Task.h
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trial.h"

typedef enum TrialResult
{
	SUCCESS = 0,
	FAILURE,
	TIMEOUT,
	COMPLETE
} TrialResult;

@interface Task : NSObject {
	NSString * name;
	
}
- (id) initWithName:(NSString *) name;
- (void) reset;
- (Trial *) getNextTrial;
- (int) getStimulusCount;
- (void) reportResult:(TrialResult) result;


@property (nonatomic, retain) NSString * name;

@end
