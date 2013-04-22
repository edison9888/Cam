//
//  CameraViewController.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 MezzoMedia. All rights reserved.
//

#import "GPUImage.h"
#import "MAnimationsButton.h"
#import "BottomHorizonScrollView.h"
#import "ADBanner.h"
#import "ProcessingAniView.h"
#import "CameraFilter.h"

@protocol CameraViewControllerDelegate
@optional
- (void)saveSelectedImage:(UIImage*)editedImage frontmode:(BOOL)bFrontMode;
@end

@interface CameraViewController : UIViewController <UIGestureRecognizerDelegate, ADBannerDelegate, CameraFilterDelegate> {
    
    __unsafe_unretained id <CameraViewControllerDelegate> _delegate; 
    
    AVAudioPlayer* _shutterSoundPlayer;
    
    GPUImageView *_imageView;
    GPUImageVideoCamera *_videoCamera;
    GPUImageStillCamera *_stillCamera;
    GPUImageDefaultFilter *_defaultFilter;
    GPUImageShowcaseFilterType _cameraFilterType;
    
    CameraFilter *_cameraFilter;
    
    BottomHorizonScrollView *_cameraFilterScrollView;
    BottomHorizonScrollView *_cameraBackgroundScrollView;
    ProcessingAniView *_processingAniView;
    
    UIImageView *_backgroundImageView;
    UIImageView *_cameraBottomView;
    UIImageView *_shutterTopImageView;
    UIImageView *_shutterBottomImageView;
    
    MAnimationsButton *frontRearCameraButton;
    MAnimationsButton *_camaraCaptureButton;
    MAnimationsButton *_initFilterButton;
    MAnimationsButton *_cameraFilterButton;
    MAnimationsButton *_cameraBackgroundButton;
    MAnimationsButton *_thumbnailButton;
    
    UIImage *_saveImage;
   
    BOTTOMHORIZONSCROLLVIEWTYPE _scrollViewType;
    
    float _osVersion;
    
    BOOL _bfrontMode;
    BOOL _bFlashMode;
}

@property (nonatomic, assign) id <CameraViewControllerDelegate> delegate;

- (void)initUI;
- (void)startOpenAnimation;
- (void)startCloseAnimation;
- (void)rotateButtons:(UIDeviceOrientation)willOrientation;
- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates;

@end
