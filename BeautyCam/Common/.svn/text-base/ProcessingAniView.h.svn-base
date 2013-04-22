//
//  ProcessingAniView.h
//  NOpenCVProject
//
//  Created by LeeSiHyung on 12. 2. 16..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessingAniView : UIView {
    
    NSTimer *animationTimer;
    
    UIView *blockView;
    UIImageView *loadingBackImageView;
    UIImageView *bgImageView;
    UIImageView *hourImageView;
    UIImageView *minImageView;
    
    NSInteger hourDegree;
    NSInteger minDegree;
}

- (void)loadingWithParentView:(UIView*)parentView;
- (void)unLoading;
- (void)animationStart;
- (void)animationEnd;

@end
