//
//  TaskViewController.h
//  iCBT
//
//  Created by Chad Johnson on 1/15/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskView.h"
#import "Task.h"

@interface TaskViewController : UIViewController {

	Class viewClass;
	UIBarStyle barStyle;
	UIStatusBarStyle statusStyle;
	TaskView *taskView;
	NSString *taskInfo;
	Task	*task;
}

@property(nonatomic, readwrite)	UIBarStyle barStyle;
@property(nonatomic, readwrite)	UIStatusBarStyle statusStyle;
@property(nonatomic, readwrite, copy) NSString* taskInfo;
@property(nonatomic, readonly) TaskView *taskView;
@property(nonatomic, retain) Task *task;

-(id)initWithNibName:(NSString *)nib viewClass:(Class)vc;

@end
