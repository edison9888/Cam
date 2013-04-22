//
//  BottomMenuScrollView.h
//  NOpenCVProject
//
//  Created by LeeSiHyung on 12. 2. 23..
//  Copyright (c) 2012 MezzomMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomMenuScrollViewDelegate
- (void)BottomMenuFirstButton;
- (void)BottomMenuSecondButton;
- (void)BottomMenuThirdButton;
- (void)BottomMenuFourthButton;
- (void)BottomMenuFifthButton;
- (void)BottomMenuSixthButton;
@end

@interface BottomMenuScrollView : UIScrollView {
    
    __unsafe_unretained id <BottomMenuScrollViewDelegate> _customDelegate; 
    NSMutableArray *_buttonBgArray;
    NSMutableArray *_buttonArray;
    NSInteger selectedOrder;
}

@property (nonatomic, assign) id <BottomMenuScrollViewDelegate> customDelegate;

- (void)initBgImage;
- (void)initButtons;
- (void)selectButton:(NSInteger)order;
- (void)AllDeselectButtons;
- (void)rotateButtons:(UIDeviceOrientation)willOrientation;

@end
