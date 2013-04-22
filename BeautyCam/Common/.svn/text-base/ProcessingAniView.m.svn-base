//
//  ProcessingAniView.m
//  NOpenCVProject
//
//  Created by LeeSiHyung on 12. 2. 16..
//  Copyright (c) 2012 MezzoMedia. All rights reserved.
//

#import "ProcessingAniView.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * (x) / 360.0)

@implementation ProcessingAniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc {
    //[super dealloc];
}

#pragma mark - 
#pragma mark public -

- (void)loadingWithParentView:(UIView*)parentView {
    
    if (parentView) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (window) {
            blockView = [[UIView alloc] initWithFrame:window.frame];
            blockView.backgroundColor = [UIColor clearColor];
            [window addSubview:blockView];
            
            UIImage *loadingBackImage = [UIImage imageNamed:@"loading_back.png"];
            loadingBackImageView = [[UIImageView alloc] initWithImage:loadingBackImage];
            loadingBackImageView.center = CGPointMake(parentView.frame.size.width / 2, parentView.frame.size.height / 2 - 12.0f);
            [parentView addSubview:loadingBackImageView];  
            
            NSString *processingTitle = NSLocalizedString(@"loading", @"");
            CGFloat processingFontSize = 14.0f;
            
            UIFont *processingFont = [Util getFont:YES fontSize:processingFontSize];
            CGSize processingSize = [processingTitle sizeWithFont:processingFont];
            UILabel *processingLabel = [[UILabel alloc] initWithFrame:CGRectMake((loadingBackImageView.frame.size.width / 2) - (processingSize.width / 2),
                                                                                 60.0f,
                                                                                 processingSize.width, 
                                                                                 processingSize.height)];
            processingLabel.backgroundColor = [UIColor clearColor];
            processingLabel.textColor = ColorFromRGB(0x220a62);
            processingLabel.font = processingFont;
            processingLabel.text = processingTitle;
            [loadingBackImageView addSubview:processingLabel];
            //[processingLabel release];
            
            UIImage *bgImage = [UIImage imageNamed:@"loading_clock1.png"];
            bgImageView = [[UIImageView alloc] initWithImage:bgImage];
            bgImageView.center = CGPointMake(parentView.frame.size.width / 2, parentView.frame.size.height / 2 - 17.0f);
            [parentView addSubview:bgImageView];   
            
            hourDegree = 0;
            UIImage *hourImage = [UIImage imageNamed:@"loading_clock2.png"];
            hourImageView = [[UIImageView alloc] initWithImage:hourImage];
            hourImageView.frame = CGRectMake((parentView.frame.size.width / 2) - hourImage.size.width / 2,
                                             (parentView.frame.size.height / 2) - hourImage.size.height / 2 - 16.0f, 
                                             hourImage.size.width,
                                             hourImage.size.height);
            hourImageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
            [parentView addSubview:hourImageView];  
            
            minDegree = 0;
            UIImage *minImage = [UIImage imageNamed:@"loading_clock3.png"];
            minImageView = [[UIImageView alloc] initWithImage:minImage];
            minImageView.frame = CGRectMake((parentView.frame.size.width / 2) - minImage.size.width / 2,
                                            (parentView.frame.size.height / 2) - minImage.size.height / 2 - 16.0f, 
                                            minImage.size.width,
                                            minImage.size.height);
            minImageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
            CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadians(minDegree));
            minImageView.transform = transform;
            [parentView addSubview:minImageView];  
            
            [self animationStart];
        }
    }
}

- (void)unLoading {
    
    [self animationEnd];
    
    [blockView removeFromSuperview];
    //[blockView release];
    
    [bgImageView removeFromSuperview];
    //[bgImageView release];
    
    [minImageView removeFromSuperview];
    //;
    
    [hourImageView removeFromSuperview];
    //[hourImageView release];
    
    [loadingBackImageView removeFromSuperview];
   // [loadingBackImageView release];
}

- (void)animationStart{
     animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animationUpdate) userInfo:nil repeats:YES];
}

- (void)animationEnd {
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
}

#pragma mark -
#pragma mark timer -

- (void)animationUpdate {
    
    minDegree += 90;
    if (minDegree == 720) {
        minDegree = 0;
        hourDegree += 90;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0]; 
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadians(hourDegree));
    hourImageView.transform = transform;
    
    transform = CGAffineTransformMakeRotation(degreesToRadians(minDegree));
    minImageView.transform = transform;
    
    [UIView commitAnimations];
}

@end
