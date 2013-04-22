//
//  LoadingView.h
//  EveryDay
//
//  Created by lee ho on 11. 11. 20..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView {
    
}

+ (id)loadingViewInView:(UIView *)superview;
- (void)removeView;
- (CGPathRef)newPathWithRoundRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;

@end
