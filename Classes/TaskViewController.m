    //
//  TaskViewController.m
//  iCBT
//
//  Created by Chad Johnson on 1/15/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "TaskViewController.h"

// TODO: Replace DetailViewController with a TaskViewController
//		TaskViewController must implement <UIPopoverControllerDelegate, UISplitViewControllerDelegate>
//		See: DetailViewController
@implementation TaskViewController

@synthesize barStyle, statusStyle, taskInfo, task;

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

- (id)initWithNibName:(NSString *)nibNameOrNil viewClass:(Class)vc {
 self = [super initWithNibName:nibNameOrNil bundle:nil];
 if (self) {
 // Custom initialization.
	 viewClass = vc;
	 
	 // default bar style is black
	 barStyle = UIBarStyleBlackOpaque;
	 
	 // default status bat style is black opaque
	 statusStyle = UIStatusBarStyleBlackOpaque;
 }
 return self;
 }

-(TaskView *)taskView
{
	if(taskView == nil)
	{
		taskView = [[viewClass alloc] initWithFrame:CGRectZero];
	}
	return taskView;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(void)viewDidLoad
{
	// Add the QuartzView
	[self.view addSubview:self.taskView];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.barStyle = barStyle;
	[[UIApplication sharedApplication] setStatusBarStyle:statusStyle animated:animated];
	self.taskView.frame = self.view.bounds;
}

@end
