//
//  LoadingView.m
//  EveryDay
//
//  Created by lee ho on 11. 11. 20..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    //rect.size.height -= 1;
    //rect.size.width -= 1;
    
    const CGFloat RECT_PADDING = 0.0;
    rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
    
    /*
    const CGFloat ROUND_RECT_CORNER_RADIUS = 1.0;
    CGPathRef roundRectPath =
    [self newPathWithRoundRect:rect cornerRadius:ROUND_RECT_CORNER_RADIUS];
    */
    
    const CGFloat ROUND_RECT_CORNER_RADIUS = 0.0;
    CGPathRef roundRectPath = [self newPathWithRoundRect:rect cornerRadius:ROUND_RECT_CORNER_RADIUS];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGFloat BACKGROUND_OPACITY = 0.85;
    CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
    CGContextAddPath(context, roundRectPath);
    CGContextFillPath(context);
    
    /*
    const CGFloat STROKE_OPACITY = 0.25;
    CGContextSetRGBStrokeColor(context, 0, 0, 0, STROKE_OPACITY);
    CGContextAddPath(context, roundRectPath);
    CGContextStrokePath(context);
    */
    
    CGPathRelease(roundRectPath);
}

#pragma mark -
#pragma mark public

+ (id)loadingViewInView:(UIView *)superview {
    
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:[superview frame]];
	if (!loadingView) {
		return nil;
	}
	
	loadingView.opaque = NO;
	loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[superview addSubview:loadingView];
    
	const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
	const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
	CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	UILabel *loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
	loadingLabel.text = NSLocalizedString(@"Loading...", nil);
	loadingLabel.textColor = [UIColor whiteColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = UITextAlignmentCenter;
	loadingLabel.font = [Util getFont:NO fontSize:[UIFont labelFontSize]];
	loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
	
	[loadingView addSubview:loadingLabel];
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] 
                                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[loadingView addSubview:activityIndicatorView]; 
    activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[activityIndicatorView startAnimating];
	
	CGFloat totalHeight = loadingLabel.frame.size.height + activityIndicatorView.frame.size.height;
	labelFrame.origin.x = floor(0.5 * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH));
	labelFrame.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));
	loadingLabel.frame = labelFrame;
	
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x = 0.5 * (loadingView.frame.size.width - activityIndicatorRect.size.width);
	activityIndicatorRect.origin.y = loadingLabel.frame.origin.y - 15.0f;
	activityIndicatorView.frame = activityIndicatorRect;
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[superview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	return loadingView;
}

- (void)removeView {
    
	UIView *superview = [self superview];
	[super removeFromSuperview];
    
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[superview layer] addAnimation:animation forKey:@"layerAnimation"];
}

//
// NewPathWithRoundRect
//
// Creates a CGPathRect with a round rect of the given radius.
//
- (CGPathRef)newPathWithRoundRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius {
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
                      rect.origin.x,
                      rect.origin.y + rect.size.height - cornerRadius);
    
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        cornerRadius);
    
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y,
                        cornerRadius);
    
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}

@end
