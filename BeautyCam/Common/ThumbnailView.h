//
//  ThumbnailView.h
//  PicShow
//
//  Created by LeeSiHyung on 11. 9. 15..
//  Copyright 2011 MezzoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbnailView : UIView {

	UIImage *_thumbnailImage;
    UIImageView *backImage;
    UIImageView *_backFrameImageView;
	BOOL _bSelected;
    
    NSString *_index;
    BOTTOMHORIZONSCROLLVIEWTYPE _type;
    
    float _osVersion;
}

@property (nonatomic, retain) UIImage *thumbnailImage;
@property (nonatomic, assign) BOOL bSelected;
@property (nonatomic, retain) NSString *index;
@property (nonatomic, assign) BOTTOMHORIZONSCROLLVIEWTYPE type;

- (void)setFirst;
- (void)loadThumbnailImage;
- (void)setHorizonType;
- (void)focusInAnimation;
- (void)focusOut;


@end
