//
//  Tasks.h
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface Tasks : NSObject {
	NSMutableArray *tasksArray;
}

-(int) count;
-(NSDictionary *) taskAtIndex:(int) index;

@property (nonatomic, retain) NSMutableArray *tasksArray;
@end
