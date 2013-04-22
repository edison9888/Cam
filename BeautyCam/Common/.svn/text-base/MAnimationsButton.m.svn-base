//
//  MAnimationsButton.m
//  Beautie
//
//  Created by Moon Sik on 12. 1. 11..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import "MAnimationsButton.h"

@implementation MAnimationsButton

@synthesize reSetSize;

-(void) animationStart
{ 
    if (bAnimation == NO) {
        frect = self.frame;
        bAnimation = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.15f];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        self.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
        [UIView commitAnimations];
    }
}

- (void)animationDidStop
{
    if (bAnimation) {
        if (lastRadian == 359) {
            lastRadian = 0;
            self.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
        }
        lastRadian = 359;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.15f];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        self.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
        [UIView commitAnimations];
    }else{
        lastRadian = 0;
        self.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
        if (reSetSize) {
            self.frame = frect;
        }
    }
}

-(void) animationStop
{
    bAnimation = NO;
    self.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
}

- (void)doRotate:(UIDeviceOrientation)willOrientation {
    
    NSInteger degree = 0;
    
    switch (willOrientation) {
        case UIDeviceOrientationPortrait:
        {
            degree = 0;
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
        {
            degree = 360;
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        {
            degree = 180;
        }
            break;
        case UIDeviceOrientationLandscapeRight:
        {            
            degree = -180;
        }
            break;
        case UIDeviceOrientationFaceUp:
        {       
            degree = 0;
        }
            break;
        case UIDeviceOrientationFaceDown:
        {      
            degree = 360;
        }
            break;
        case UIDeviceOrientationUnknown:
        {            
        }
            break;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; 
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadians(degree));
    self.transform = transform;
    [UIView commitAnimations];
}

@end
