//
//  BottomHorizonScrollView.m
//  Magazine
//
//  Created by LeeSiHyung on 11. 9. 15..
//  Copyright 2011 MezzoMedia. All rights reserved.
//

#import "BottomHorizonScrollView.h"
#import "ThumbnailView.h"

#define THUMBNAIL_IMAGE_LEFT_INTERVAL 3.0f
#define THUMBNAIL_IMAGE_TOP_INTERVAL  2.0f
//81
#define THUMBNAIL_IMAGE_WIDTH  75
#define THUMBNAIL_IMAGE_HEIGHT 125

#define STATUS_CUT_WIDTH 90.0f

@implementation BottomHorizonScrollView

@synthesize currentThumbnailTag = _currentThumbnailTag;
@synthesize type = _type;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        
        self.backgroundColor = [UIColor clearColor];
        self.currentThumbnailTag = 1;
        
		_thumbnailImageViewArray = [[NSMutableArray alloc] init];
        
        _thumbnailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _thumbnailScrollView.delegate = self;
        _thumbnailScrollView.backgroundColor = [UIColor clearColor];
        _thumbnailScrollView.showsVerticalScrollIndicator = NO;
        _thumbnailScrollView.delaysContentTouches = YES;
        [self addSubview:_thumbnailScrollView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thumbnailViewClicked:) name:@"thumbnailViewClicked" object:nil];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
    // Drawing code.
}

- (void)dealloc {
	
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"thumbnailViewClicked" object:nil];
}

#pragma mark -
#pragma mark public
- (void)setThumbnailArray:(NSMutableArray *)thumbnailImageArray {
    
    if (thumbnailImageArray == nil && [thumbnailImageArray count] == 0) {
        return;
    }
    
    CGFloat originX = 0;
    NSUInteger thumbnailImageCnt = 0;
    
    
    CGRect lastThumbnailImageFrame;
    
    if ([_thumbnailImageViewArray count] > 0) {
        for (ThumbnailView *thumbnailView in _thumbnailImageViewArray) {
            [thumbnailView removeFromSuperview];
        }
        [_thumbnailImageViewArray removeAllObjects];
    }
    
    CGSize imagesize = CGSizeMake(THUMBNAIL_IMAGE_WIDTH, THUMBNAIL_IMAGE_HEIGHT);
    for (UIImage *thumbnailImage in thumbnailImageArray) {
        originX = THUMBNAIL_IMAGE_LEFT_INTERVAL + (THUMBNAIL_IMAGE_LEFT_INTERVAL * thumbnailImageCnt) + (imagesize.width * thumbnailImageCnt);
        ThumbnailView *thumbnailView = [[ThumbnailView alloc] initWithFrame:CGRectMake(originX,
                                                                                       THUMBNAIL_IMAGE_TOP_INTERVAL,
                                                                                       imagesize.width, 
                                                                                       imagesize.height)];
                                                            
        thumbnailView.type = _type;
        if (_type == EDITOR_BACKGROUND || _type == CAMERA_BACKGROUND) {
            thumbnailView.tag = BACKGROUND_IMAGE_COUNT - thumbnailImageCnt;
        }  else {
            thumbnailView.tag = thumbnailImageCnt + 1;
        }
        thumbnailView.thumbnailImage = thumbnailImage;
        [thumbnailView loadThumbnailImage];
        [_thumbnailImageViewArray addObject:thumbnailView];
		[_thumbnailScrollView addSubview:thumbnailView];
        
        lastThumbnailImageFrame = thumbnailView.frame;
        
        if (_type == EDITOR_BACKGROUND) {
            NSInteger verticalImageNum = BACKGROUND_IMAGE_COUNT - (thumbnailImageCnt + 1);
            if (verticalImageNum == 1 || verticalImageNum == 4 || verticalImageNum == 7 || verticalImageNum == 8 || verticalImageNum == 14 ||
                verticalImageNum == 20 || verticalImageNum == 22 || verticalImageNum == 25 || verticalImageNum == 29 || verticalImageNum == 30) {
                [thumbnailView setHorizonType];
            }
        }
        
        //;
        thumbnailView = nil;
        thumbnailImageCnt++;
    }
    
    _thumbnailScrollView.contentSize = CGSizeMake(lastThumbnailImageFrame.origin.x + lastThumbnailImageFrame.size.width + THUMBNAIL_IMAGE_TOP_INTERVAL, 
                                                  _thumbnailScrollView.frame.size.height); 
}

  /*
- (void)setThumbnailImages:(UIImage*)_image {
    
  
    if (_image == nil){
        return;
    }
    
    CGFloat originX = 0;
    NSUInteger thumbnailImageCnt = 0;
    
    CGRect lastThumbnailImageFrame;
    NSMutableArray *thumbnailImageArray = nil;
    if ([_thumbnailImageArray count] > 0) {
        [_thumbnailImageArray removeAllObjects];
    }
    if (tempImage) {
        [tempImage release];
        tempImage = nil;
    }
    
    tempImage = [[UIImageView alloc] initWithImage:_image];
    thumbnailImageArray = [Utilities mySettingArray:tempImage.image];
    CGSize imagesize = CGSizeMake(THUMBNAIL_IMAGE_WIDTH, THUMBNAIL_IMAGE_HEIGHT);
    
    for (UIImage *thumbnailImage in thumbnailImageArray) {
        
        originX = THUMBNAIL_IMAGE_LEFT_INTERVAL + (THUMBNAIL_IMAGE_LEFT_INTERVAL * thumbnailImageCnt) + (imagesize.width * thumbnailImageCnt);
        
		ThumbnailView *thumbnailView = [[ThumbnailView alloc] initWithFrame:CGRectMake(originX,
                                                                                       THUMBNAIL_IMAGE_TOP_INTERVAL,
                                                                                       imagesize.width, 
                                                                                       imagesize.height)];
        thumbnailView.iType = _iType;
		thumbnailView.tag = thumbnailImageCnt + 1;
        if (thumbnailView.tag == self.currentThumbnailTag) {
            [thumbnailView setFirst];
        }
		thumbnailView.thumbnailImage = thumbnailImage;
        [thumbnailView loadThumbnailImage];
        [_thumbnailImageArray addObject:thumbnailView];
		[_thumbnailScrollView addSubview:thumbnailView];
        lastThumbnailImageFrame = thumbnailView.frame;
        
        [thumbnailView release];
        thumbnailView = nil;
        
        thumbnailImageCnt++;
    }
    
    _thumbnailScrollView.contentSize = CGSizeMake(lastThumbnailImageFrame.origin.x + lastThumbnailImageFrame.size.width + THUMBNAIL_IMAGE_TOP_INTERVAL, 
                                                  _thumbnailScrollView.frame.size.height); 
    //   [thumbnailImageArray release];
    
}
 */

- (void)selectButton {
    
    if (self.currentThumbnailTag == 0) {
        return;
    }
    
    ThumbnailView *thumbnailView = (ThumbnailView*)[_thumbnailScrollView viewWithTag:self.currentThumbnailTag];
  	if (thumbnailView) {
		[thumbnailView focusInAnimation];
	}
}

- (void)deselectButton {
    
    if (self.currentThumbnailTag == 0) {
        return;
    }
    
    ThumbnailView *thumbnailView = (ThumbnailView*)[_thumbnailScrollView viewWithTag:self.currentThumbnailTag];
  	if (thumbnailView) {
		[thumbnailView focusOut];
	}
}

@end
