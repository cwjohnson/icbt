//
//  StimulusUIButton.h
//  iCBT
//
//  Created by Chad Johnson on 1/18/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stimulus.h"

@interface StimulusUIButton : UIButton {
	Stimulus	* stimulus;
	CGPoint	 relativeLoc;
}

// we are going to draw our own buttons
-(void)drawRect:(CGRect)rect;

@property(nonatomic, retain) Stimulus * stimulus;
@property(nonatomic) CGPoint relativeLoc;
@end
