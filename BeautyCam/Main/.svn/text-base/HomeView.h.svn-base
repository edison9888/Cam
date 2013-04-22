//
//  HomeView.h
//  Beautie
//
//  Created by Moon Sik on 12. 1. 11..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAnimationsButton.h"

#define CHOOSE_A_PICTURE_BTN_TAG    10
#define SETTING_PICTURE_BTN_TAG     11
#define ABOUT_PICTURE_BTN_TAG       12
#define TAKE_PICTURE_BTN_TAG        13
#define TAKE2_PICTURE_BTN_TAG       14

@protocol HomeViewDelegate
- (void)onHomeButtonClick:(NSInteger)buttonTag;
@end

@interface HomeView : UIView {
    
    __unsafe_unretained id <HomeViewDelegate> delegate;

    
    MAnimationsButton * chooseBtn;
    MAnimationsButton * settingBtn;
    MAnimationsButton * aboutBtn;
    MAnimationsButton * take1Btn;
    MAnimationsButton * take2Btn;
    
    int lastRadian;
    int iFirst;
    
    BOOL bAnimation;
}

@property (nonatomic, assign) id <HomeViewDelegate> delegate;


- (void)initUIButton;
- (IBAction)goButton:(id)sender;

@end
