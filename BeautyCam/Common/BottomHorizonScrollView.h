//
//  BottomHorizonScrollView.h
//  Magazine
//
//  Created by LeeSiHyung on 11. 9. 15..
//  Copyright 2011 MezzoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomHorizonScrollView : UIView <UIScrollViewDelegate> {
	
	NSMutableArray *_thumbnailImageViewArray;
    UIScrollView *_thumbnailScrollView;
    
    NSInteger _currentThumbnailTag;
    BOTTOMHORIZONSCROLLVIEWTYPE _type;
}

@property (nonatomic, assign) NSInteger currentThumbnailTag;
@property (nonatomic, assign) BOTTOMHORIZONSCROLLVIEWTYPE type;

//- (void)setThumbnailImages:(UIImage *)_image;
- (void)setThumbnailArray:(NSMutableArray *)thumbnailImageArray;
- (void)selectButton;
- (void)deselectButton;

@end