//
//  EditPictureViewController.h
//  NOpenCVProject
//
//  Created by Moon Sik on 11. 11. 24..
//  Copyright (c) 2011 inamass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomSlider.h"
#import "BottomHorizonScrollView.h"
#import "MAnimationsButton.h"
#import "ProcessingAniView.h"
#import "BottomMenuScrollView.h"
#import "ADBanner.h"
#import "GADBannerView.h"
#import "EditImageFilter.h"
#import "CameraViewController.h"
//#import "Facebook.h"
#import "SA_OAuthTwitterController.h" 
#import "SocialTextViewController.h"
#import "InfoView.h"

typedef enum {
	ScrollViewModeNotInitialized,           // view has just been loaded
	ScrollViewModePaging,                   // fully zoomed out, swiping enabled
	ScrollViewModeZooming,                  // zoomed in, panning enabled
} ScrollViewMode;

@interface DetailImageScrollView : UIScrollView {
}
@end

@interface EditPictureViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate, BottomMenuScrollViewDelegate, ADBannerDelegate, CameraViewControllerDelegate, SA_OAuthTwitterControllerDelegate, SocialTextViewControllerDelegate> {
    
    EditImageFilter *_editImageFilter;
    
    CLLocationManager *_locationManager;
    
    // 광고
    ADBanner *_adBannerView;
    GADBannerView *_gadBannerView;
    
    // 메인 스크롤뷰.
    DetailImageScrollView *_detailScrollView;
    
    // 
    MAnimationsButton *homeBtn;
    MAnimationsButton *saveBtn;
    MAnimationsButton *orgimageBtn;
    MAnimationsButton *pictureBtn;
    MAnimationsButton *infoBtn;
    
    ScrollViewMode scrollViewMode;
    BottomHorizonScrollView *_imageFilterScrollView;
    BottomHorizonScrollView *_imageBackgroundScrollView;
    
    ProcessingAniView *_processingAniView;
    // bottom
    BottomMenuScrollView *_bottomMenuScrollView;
    
    // sliderviews
    UIView *firstMenuSliderBgView;
    //UIView *secondMenuSliderBgView;
    CustomSlider *saturationSlider;
    CustomSlider *contrastSlider;
    CustomSlider *brightnessSlider;
    //CustomSlider *allMakeUpSlider;
    
    UIImageView *makeUpBongImageView;
    
    UIImage *_originalImage;
    UIImage *_preEditImage;
    UIImage *_editedimage;
    UIImageView *_editedImageView;;
    
    NSInteger _editFilterType;
    NSInteger _editBackgroundType;
    
    SLIDER_TYPE sliderType;
    
    // 점검 ㅡㅡㅡ
    int iType;
    
    double doubleSlider;
    
    // 선택
    NSInteger bottomMenuSelected;
    
    CGPoint _startPoint;
    
    BOOL _bAllMakeUp;

    
    float _osVersion;
    
    
    UIView *_alphaView;
    UIActivityIndicatorView *_indicatorView;
    
    // info
    InfoView *_infoView;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) int iType;
@property (nonatomic, retain) UIImageView *imageAniView;
@property (nonatomic, retain) UIImage *originalImage;
@property (nonatomic, retain) UIImage *preEditImage;
@property (nonatomic, retain) UIImage *editedimage;

- (void)allReset;
// mainImage
- (void)setImage:(UIImage*)originalImage;
// slider
- (void)initSliderView;
// topMenu
- (void)initTopMenuButtons;
- (void)animationinit;
//
- (void)rotateButtons:(UIDeviceOrientation)willOrientation;
// loading
- (void)setLoadingView;
- (void)deSetLoadingView;
// editImage
- (void)rollbackToOriginalImage;
- (void)completeOneEditWithMenuIndex:(NSInteger)menuIndex;
// image gps
- (NSDictionary*)getGPSDictionaryForLocation:(CLLocation*)location;
//
- (void)editImage;
- (void)changeADBannerHiddenState:(BOOL)bHidden;
- (void)showTwitterTextViewController;
- (void)uploadImageToFacebook:(NSString*)text;
- (void)uploadImageToTwitter:(NSString*)text;
@end
