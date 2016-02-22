//
//  RootViewController.h
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tasks.h"

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
	Tasks *tasks;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet Tasks *tasks;

@end
