//
//  Tasks.m
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Tasks.h"
#import "WisconsinTask.h"
#import "TaskView.h"
#import "WisconsinTaskViewController.h"

@implementation Tasks

@synthesize tasksArray;

// initialize list of tasks that are available
-(id) init
{
	[super init];
	tasksArray = [[NSMutableArray alloc] init];
	
	{
		// Wisconsin short task
		NSMutableDictionary * optionsDict = [[NSMutableDictionary alloc] initWithCapacity:2];
		[optionsDict setObject:@"1" forKey:@"maxLevel"];
		[optionsDict setObject:@"Wisconsin CST - Short" forKey:@"title"];
		TaskViewController *controller;
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		controller = [[WisconsinTaskViewController alloc] initWithNibName:@"TaskView" viewClass:[TaskView class] options:optionsDict];
		[dict setObject:controller forKey:@"controller"];
		[dict setObject:@"Wisconsin CST - Short" forKey:@"title"];
		[dict setObject:@"WisconsinTask" forKey:@"taskinfo"];
		[dict setObject:controller forKey:@"controller"];
		//[optionsDict release];
		[controller release];
		
		[tasksArray addObject:dict];
		[dict release];
	}
	
	{
		// Wisconsin long task
		NSMutableDictionary * optionsDict = [[NSMutableDictionary alloc] initWithCapacity:2];
		[optionsDict setObject:@"3" forKey:@"maxLevel"];
		[optionsDict setObject:@"Wisconsin CST - Long" forKey:@"title"];
		TaskViewController *controller;
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		controller = [[WisconsinTaskViewController alloc] initWithNibName:@"TaskView" viewClass:[TaskView class] options:optionsDict];
		[dict setObject:controller forKey:@"controller"];
		[dict setObject:@"Wisconsin CST - Long" forKey:@"title"];
		[dict setObject:@"WisconsinTask" forKey:@"taskinfo"];
		[dict setObject:controller forKey:@"controller"];
		//[optionsDict release];
		[controller release];
		
		[tasksArray addObject:dict];
		[dict release];
	}
	
	return self;
}

-(int) count
{
	return [tasksArray count];
}

-(NSDictionary *) taskAtIndex:(int)index
{
	return [tasksArray objectAtIndex:index];
}

-(void)dealloc
{
	[tasksArray release], tasksArray=nil;
	[super dealloc];
}
@end
