//
//  CustomSlider.m
//  Measures
//
//  Created by Michael Neuwert on 4/26/11.
//  Copyright 2011 Neuwert Media. All rights reserved.
//

#import "CustomSlider.h"

#pragma mark - MNEValueTrackingSlider implementations

@implementation CustomSlider

#pragma mark - Private methods

- (void)_constructSlider {
    
    valuePopupImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_numbox.png"]];
    valuePopupImageView.frame = CGRectZero;
    valuePopupImageView.alpha = 0.0f;
    [self addSubview:valuePopupImageView];
    
    UIFont *valueFont = [UIFont fontWithName:@"NanumGothicExtraBold" size:26];
    valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    valueLabel.textAlignment = UITextAlignmentCenter;
    valueLabel.textColor = ColorFromRGB(0xee0a62);
    valueLabel.backgroundColor = [UIColor clearColor];
    valueLabel.font = valueFont;
    [valuePopupImageView addSubview:valueLabel];
}

- (void)_fadePopupViewInAndOut:(BOOL)aFadeIn {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    if (aFadeIn) {
        valuePopupImageView.alpha = 1.0;
    } else {
        valuePopupImageView.alpha = 0.0;
    }
    [UIView commitAnimations];
}

- (void)_positionAndUpdatePopupView {
   
    CGRect _thumbRect = self.thumbRect;
    CGRect popupRect = CGRectOffset(_thumbRect, 0, - (_thumbRect.size.height * 1.0));
    valuePopupImageView.frame = CGRectInset(popupRect, -10, -5);
    [self setPopupValue:self.value];
}

#pragma mark - Memory management

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
        [self _constructSlider];
        
        UIImage *thumbImage = [[UIImage imageNamed:@"slider_btn.png"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"8")];
        UIImage *minColorImage = [[UIImage imageNamed:@"slider_empty.png"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"8")];
        UIImage *maxColorImage = [[UIImage imageNamed:@"slider_fill.png"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"8")];
        
        [self setMinimumTrackImage:minColorImage forState:UIControlStateNormal];
        [self setMaximumTrackImage:maxColorImage forState:UIControlStateNormal];
        [self setThumbImage:thumbImage forState:UIControlStateNormal];
        self.continuous = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _constructSlider];
    }
    return self;
}

- (void)dealloc {
    
    if (valuePopupImageView) {
        //[valuePopupImageView release];
        valuePopupImageView = nil;
    }
    
    if (valueLabel) {
//[valueLabel release];
        valueLabel = nil;
    }
    //[super dealloc];
}

#pragma mark - UIControl touch event tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    [self _positionAndUpdatePopupView];
    [self _fadePopupViewInAndOut:YES]; 
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // Update the popup view as slider knob is being moved
    [self _positionAndUpdatePopupView];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
   
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // Fade out the popoup view
    [self _fadePopupViewInAndOut:NO];
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Custom property accessors

- (CGRect)thumbRect {
   
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds 
                                         trackRect:trackRect
                                             value:self.value];
    return thumbR;
}

- (void)setPopupValue:(float)value {
    
    NSString *valueString = [[NSString alloc] initWithFormat:@"%.1f", value];
    valueLabel.frame = CGRectMake(4.0f, 4.0f, 34.0f, 17.0f);
    valueLabel.text = valueString;
    //[valueString release];
}

@end
