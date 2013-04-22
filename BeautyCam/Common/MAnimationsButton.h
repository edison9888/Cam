//
//  MAnimationsButton.h
//  Beautie
//
//  Created by Moon Sik on 12. 1. 11..
//  Copyright (c) 2012 inamass. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MAnimationsButton : UIButton {
    BOOL bAnimation;
    int lastRadian;
    CGRect frect;
    BOOL reSetSize;    
}

@property (nonatomic, assign)BOOL reSetSize;

- (void)animationStart;
- (void)animationStop;
- (void)doRotate:(UIDeviceOrientation)willOrientation;

@end
