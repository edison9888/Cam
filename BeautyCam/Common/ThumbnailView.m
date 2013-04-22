//
//  ThumbnailView.m
//  Magazine
//
//  Created by LeeSiHyung on 11. 9. 15..
//  Copyright 2011 MezzoMedia. All rights reserved.
//

#import "ThumbnailView.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_INTERVAL      5.0f
#define ACTIVITY_VIEW_TAG   9999

#define ALPHA_VALUE 1.0f
#define IMAGE_WIDTH 55
#define IMAGE_HEIGHT 85

@implementation ThumbnailView
@synthesize thumbnailImage = _thumbnailImage;
@synthesize bSelected = _bSelected;
@synthesize index = _index;
@synthesize type = _type;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        _osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
		self.bSelected = NO;
		//self.backgroundColor = [UIColor clearColor];
        self.alpha = ALPHA_VALUE;
        
        if (_osVersion < 4.9) {
            
            UIImage *frameImage = [UIImage imageNamed:@"effect_frame_2.png"];
            _backFrameImageView = [[UIImageView alloc] initWithImage:frameImage];
            _backFrameImageView.frame = CGRectMake(0, 0, frameImage.size.width, frameImage.size.height);
            [self addSubview:_backFrameImageView];
            _backFrameImageView.hidden = YES;
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	
    if (backImage) {
        //[backImage release];
        backImage = nil;
    }
    
    if (_backFrameImageView) {
        //[_backFrameImageView release];
        _backFrameImageView = nil;
    }
    
    self.thumbnailImage = nil;
    
    //[super dealloc];
}

#pragma mark -
#pragma mark general function

- (void)setFirst {
    
    self.bSelected = YES;
    
    self.alpha = 1.0;
    
    if (_osVersion >= 4.9) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"effect_frame_2.png"]];
    } else {
        _backFrameImageView.hidden = NO;
    }
}

- (void)loadThumbnailImage {
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView*)[self viewWithTag:ACTIVITY_VIEW_TAG];
    if (indicator) {
        [indicator removeFromSuperview];
    }
	
	float originX = 10;
	float originY = 10;
	float width = IMAGE_WIDTH;
	float height =IMAGE_HEIGHT;
    
    if (backImage == nil) {
        backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"effect_frame.png"]];
        backImage.frame = CGRectMake(4, 5, 67, 95);
        [self addSubview:backImage];
    }
    
    UIViewContentMode mode;
    if (self.thumbnailImage.size.width > self.thumbnailImage.size.height) {
        
        if (self.thumbnailImage.imageOrientation == UIImageOrientationUp) {
            mode = UIViewContentModeScaleAspectFit;
        } else {
            mode = UIViewContentModeScaleAspectFill;
        }
        
    } else {
        
        if (_osVersion < 4.9 && _type == EDITOR_FILTER) {
            if (self.thumbnailImage.imageOrientation == UIImageOrientationUp) {
                //self.thumbnailImage = [Util rotateImage:self.thumbnailImage orientation:UIImageOrientationRight];
            }
        }
        mode = UIViewContentModeScaleToFill;
    }
    
	UIButton *thumbnailImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
    thumbnailImageBtn.backgroundColor = ColorFromRGB(0xebebeb);
    [[thumbnailImageBtn imageView] setContentMode:mode];
	[thumbnailImageBtn setImage:self.thumbnailImage forState:UIControlStateNormal];
    [thumbnailImageBtn setImage:self.thumbnailImage forState:UIControlStateHighlighted];
	[thumbnailImageBtn addTarget:self action:@selector(onThumbnailImageBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:thumbnailImageBtn];
	//[thumbnailImageBtn release];
}

- (void)setHorizonType {

    UIImage *verticalImage = [UIImage imageNamed:@"vertical_btn.png"];
    UIImageView *verticalImageView = [[UIImageView alloc] initWithImage:verticalImage];
    verticalImageView.frame = CGRectMake((self.frame.size.width / 2) - (verticalImage.size.width / 2), 
                                         0, 
                                         verticalImage.size.width, 
                                         verticalImage.size.height);
    [self addSubview:verticalImageView];
    //[verticalImageView release];
}

- (void)focusInAnimation {
    
	self.bSelected = YES;
    
    if (_osVersion >= 4.9) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"effect_frame_2.png"]];
    } else {
        _backFrameImageView.hidden = NO;
    }
    [UIView beginAnimations:@"focusInAnimation" context:NULL];
	[UIView setAnimationDuration:0.7f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)focusOut {
	
	self.bSelected = NO;
    
    if (_osVersion >= 4.9) {
        self.backgroundColor = [UIColor clearColor];
    } else {
        _backFrameImageView.hidden = YES;
    }
    
    self.alpha = ALPHA_VALUE;
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark buttons function

- (void)onThumbnailImageBtn:(id)sender {
    
    [self focusInAnimation];
    
    switch (_type) {
        case CAMERA_FILTER:
        {
            [[NSUserDefaults standardUserDefaults] setInteger:self.tag forKey:@"cameraFilterType"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectFilterNoti" object:nil userInfo:nil];
        }
            break;
            
        case CAMERA_BACKGROUND:
        {
            [[NSUserDefaults standardUserDefaults] setInteger:self.tag forKey:@"cameraBackgroundType"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectBackgroundNoti" object:nil userInfo:nil];
        }
            break;
            
        case EDITOR_FILTER:
        {
            [[NSUserDefaults standardUserDefaults] setInteger:self.tag forKey:@"editFilterType"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectEditFilterNoti" object:nil userInfo:nil];
            
        }
            break;
            
        case EDITOR_BACKGROUND:
        {
            [[NSUserDefaults standardUserDefaults] setInteger:self.tag forKey:@"editBackgroundType"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectBackgroundNoti" object:nil userInfo:nil];
        }
            break;
    }
}

@end
