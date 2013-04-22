//
//  CameraViewController.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"

#define CAMERA_VIEW_BOTTOM_DISTANCE 60.0f

@implementation CameraViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    _osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    _scrollViewType = CAMERA_NONE;
    _bfrontMode = NO;
    
    CGRect imageViewFrame = self.view.bounds;
    imageViewFrame.size.height -= CAMERA_VIEW_BOTTOM_DISTANCE;
    
    _imageView = [[GPUImageView alloc] initWithFrame:imageViewFrame];
    [self.view addSubview:_imageView];
    
    //_shutterSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:
      //                     [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shutter" ofType:@"wav"]] error:NULL];
    
    
    _bFlashMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"flashModeSwitch"];
    BOOL bCameraSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraSoundSwitch"];
    if (bCameraSound) {
        _stillCamera = [[GPUImageStillCamera alloc] init];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        
        _defaultFilter = [[GPUImageDefaultFilter alloc] init];
        [_stillCamera addTarget:_defaultFilter];
        
        GPUImageView *filterView = (GPUImageView*)_imageView;
        [_defaultFilter addTarget:filterView];
        [_stillCamera startCameraCapture];
        
    } else {
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
        _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        
        _defaultFilter = [[GPUImageDefaultFilter alloc] init];
        [_videoCamera addTarget:_defaultFilter];
        
        GPUImageView *filterView = (GPUImageView*)_imageView;
        [_defaultFilter addTarget:filterView];
        [_videoCamera startCameraCapture]; 
    }
    
    // filter
    _cameraFilter = [[CameraFilter alloc] init];
    _cameraFilter.delgate = self;
    
    [self initUI];
    
    // Add a single tap gesture to focus on the point tapped, then lock focus
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAutoFocus:)];
    [singleTap setDelegate:self];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setCancelsTouchesInView:NO];
    [_imageView addGestureRecognizer:singleTap];
    
    // Add a double tap gesture to reset the focus mode to continuous auto focus
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToContinouslyAutoFocus:)];
    [doubleTap setDelegate:self];
    [doubleTap setNumberOfTapsRequired:2];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [_imageView addGestureRecognizer:doubleTap];
    
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectFilterNoti:) name:@"selectFilterNoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBackgroundNoti:) name:@"selectBackgroundNoti" object:nil];
    
    [self startOpenAnimation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Note: I needed to stop camera capture before the view went off the screen in order to prevent a crash from the camera still sending frames
    if (_stillCamera) {
        [_stillCamera stopCameraCapture];
    }
    
    if (_videoCamera) {
        [_videoCamera stopCameraCapture]; 
    }
	[super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"selectFilterNoti" object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"selectBackgroundNoti" object:nil];
    

}

#pragma mark -
#pragma mark public

- (void)initUI {
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:_imageView.frame];
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    _backgroundImageView.hidden = YES;
    [self.view addSubview:_backgroundImageView];
    
    UIImage *closeCameraImage = [UIImage imageNamed:@"cam_x.png"];
    UIButton *closeCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                             10.0f,
                                                                             closeCameraImage.size.width,
                                                                             closeCameraImage.size.height)]; 
    [closeCameraButton setImage:closeCameraImage forState:UIControlStateNormal];
    [closeCameraButton addTarget:self action:@selector(closeCameraButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeCameraButton];
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        
        UIImage *frontRearCameraBgImage = [UIImage imageNamed:@"cam_turn_body.png"];
        UIImageView *frontRearCameraBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - frontRearCameraBgImage.size.width,
                                                                                                10.0f,
                                                                                                frontRearCameraBgImage.size.width,
                                                                                                frontRearCameraBgImage.size.height)];
        frontRearCameraBgImageView.image = frontRearCameraBgImage;
        [self.view addSubview:frontRearCameraBgImageView];
        
        UIImage *frontRearCameraImage = [UIImage imageNamed:@"cam_turn_icon.png"];
        frontRearCameraButton = [[MAnimationsButton alloc]initWithFrame:
                                 CGRectMake(self.view.frame.size.width - frontRearCameraImage.size.width - 4.0f,
                                            18.0f,
                                            frontRearCameraImage.size.width,
                                            frontRearCameraImage.size.height)];
        [frontRearCameraButton addTarget:self action:@selector(frontRearCameraButton:) forControlEvents:UIControlEventTouchUpInside];
        [frontRearCameraButton setImage:frontRearCameraImage forState:UIControlStateNormal];
        [frontRearCameraButton setImage:frontRearCameraImage forState:UIControlStateHighlighted];
        [self.view addSubview:frontRearCameraButton];
    }
    
    UIImage *cameraBottomBgImage = [UIImage imageNamed:@"cam_bar_2.png"]; //underbar
    _cameraBottomView= [[UIImageView alloc] initWithImage:cameraBottomBgImage];
    _cameraBottomView.frame = CGRectMake(0.0f, self.view.frame.size.height - cameraBottomBgImage.size.height, 320.0f, cameraBottomBgImage.size.height);
    _cameraBottomView.userInteractionEnabled = YES;
    _cameraBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_cameraBottomView];
    
    UIImage *captureButtonImage = [UIImage imageNamed:@"cam_capture_btn_off.png"];
    _camaraCaptureButton = [[MAnimationsButton alloc] initWithFrame:
                            CGRectMake((_cameraBottomView.frame.size.width / 2) - (captureButtonImage.size.width / 2),
                                       self.view.bounds.size.height - (cameraBottomBgImage.size.height + 20.0f),
                                       captureButtonImage.size.width, 
                                       captureButtonImage.size.height)];
    [_camaraCaptureButton setImage:captureButtonImage forState:UIControlStateNormal];
    [_camaraCaptureButton setImage:[UIImage imageNamed:@"cam_capture_btn.png"] forState:UIControlStateHighlighted];
    [_camaraCaptureButton addTarget:self action:@selector(cameraCaptureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_camaraCaptureButton];
   // [_camaraCaptureButton release];
    
    UIImage *cameraFilterButtonImage = [UIImage imageNamed:@"cam_filter_off.png"];
    UIImage *cameraFilterSelectedButtonImage = [UIImage imageNamed:@"cam_filter.png"];
    _cameraFilterButton = [[MAnimationsButton alloc] initWithFrame:CGRectMake(64, 12.0f , cameraFilterButtonImage.size.width, cameraFilterButtonImage.size.height)];
    [_cameraFilterButton setImage:cameraFilterButtonImage forState:UIControlStateNormal];
    [_cameraFilterButton setImage:cameraFilterSelectedButtonImage forState:UIControlStateSelected];
    [_cameraFilterButton addTarget:self action:@selector(cameraFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    [_cameraBottomView addSubview:_cameraFilterButton];
   // [_cameraFilterButton release];
    
    UIImage *initFilterButtonImage = [UIImage imageNamed:@"cam_return_off.png"];
    UIImage *initFilterButtonSelectImage = [UIImage imageNamed:@"cam_return.png"];
    _initFilterButton = [[MAnimationsButton alloc] initWithFrame:CGRectMake(265,
                                                                            12.0f, 
                                                                            initFilterButtonImage.size.width, 
                                                                            initFilterButtonImage.size.height)];
    [_initFilterButton setImage:initFilterButtonImage forState:UIControlStateNormal];
    [_initFilterButton setImage:initFilterButtonSelectImage forState:UIControlStateSelected];
    [_initFilterButton addTarget:self action:@selector(initFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    _initFilterButton.selected = NO;
    [_cameraBottomView addSubview:_initFilterButton];
    //[_initFilterButton release];
    
    UIImage *backgroudImageButtonImage = [UIImage imageNamed:@"back_filter_off.png"];
    UIImage *backgroudImageButtonSelectImage = [UIImage imageNamed:@"back_filter.png"];
    _cameraBackgroundButton = [[MAnimationsButton alloc] initWithFrame:CGRectMake(225.0f,
                                                                                12.0f, 
                                                                                backgroudImageButtonImage.size.width, 
                                                                                backgroudImageButtonImage.size.height)];
    [_cameraBackgroundButton setImage:backgroudImageButtonImage forState:UIControlStateNormal];
    [_cameraBackgroundButton setImage:backgroudImageButtonSelectImage forState:UIControlStateSelected];
    [_cameraBackgroundButton addTarget:self action:@selector(cameraBackgroundButton:) forControlEvents:UIControlEventTouchUpInside];
    _cameraBackgroundButton.selected = NO;
    [_cameraBottomView addSubview:_cameraBackgroundButton];
    //[_cameraBackgroundButton release];
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        _bfrontMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"frontMode"];
        if (_bfrontMode) {
            //[[self captureManager] toggleCamera];
        } 
    }
    
    UIImage *thumbnailButtonImage = [UIImage imageNamed:@"cam_picbox.png"];
    _thumbnailButton = [[MAnimationsButton alloc] initWithFrame:CGRectMake(19.0f, 
                                                                           14.0f,
                                                                           thumbnailButtonImage.size.width, 
                                                                           thumbnailButtonImage.size.height)];
    [_thumbnailButton setImage:thumbnailButtonImage forState:UIControlStateNormal];
    [_thumbnailButton setImage:thumbnailButtonImage forState:UIControlStateHighlighted];
    [_thumbnailButton addTarget:self action:@selector(cameraEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [_cameraBottomView addSubview:_thumbnailButton];
//[_thumbnailButton release];
    
    // 시작할때 animation
    UIImage *shutterTopImage = [UIImage imageNamed:@"shutter_top.png"];
    _shutterTopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         shutterTopImage.size.width, 
                                                                         shutterTopImage.size.height)];
    _shutterTopImageView.image = shutterTopImage;
    [self.view addSubview:_shutterTopImageView];
   // [_shutterTopImageView release];
    
    UIImage *shutterBottomImage = [UIImage imageNamed:@"shutter_bottom.png"];
    _shutterBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 480 - shutterBottomImage.size.height,
                                                                            shutterBottomImage.size.width,
                                                                            shutterBottomImage.size.height)];
    _shutterBottomImageView.image = shutterBottomImage;
    [self.view addSubview:_shutterBottomImageView];
   // [_shutterBottomImageView release];
}

- (void)startOpenAnimation {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startCloseAnimation)];
    [_shutterTopImageView setCenter:CGPointMake(160, - 120)];
    [_shutterBottomImageView setCenter:CGPointMake(160, 480 + 120)];
    [UIView commitAnimations];
}

- (void)startCloseAnimation {
    
    [_shutterTopImageView removeFromSuperview];
    [_shutterBottomImageView removeFromSuperview];
    
    _backgroundImageView.hidden = NO;
}

- (void)getCameraImage {
    
    UIImage *stillImage = nil;
    
    if (_scrollViewType == CAMERA_FILTER) {
        stillImage = [_cameraFilter getFilterImage:_cameraFilterScrollView.currentThumbnailTag];
        
    } else {
        stillImage = [_defaultFilter imageFromCurrentlyProcessedOutput];
    }
    
    if (stillImage == nil) {
        stillImage = [_defaultFilter imageFromCurrentlyProcessedOutput];
    }
    
    if (stillImage.size.width > stillImage.size.height) {
        // 가로 이미지 돌려서 보여준다.
        //stillImage = [Util rotateImage:stillImage orientation:UIImageOrientationRight];
    }
    
    if (_cameraBackgroundScrollView.currentThumbnailTag > 0) {
        stillImage = [_cameraFilter backgroundImage:_cameraBackgroundScrollView.currentThumbnailTag originalImage:stillImage];
    } 
    
    //UIImageWriteToSavedPhotosAlbum(stillImage, nil, nil, nil); 
    
    if (stillImage) {
        if (_thumbnailButton) {
            [_thumbnailButton setImage:stillImage forState:UIControlStateNormal];
            [_thumbnailButton setImage:stillImage forState:UIControlStateHighlighted];
        }
        UIImageWriteToSavedPhotosAlbum(stillImage, nil, nil, nil);
        _saveImage = stillImage;
    }
    
    if (_videoCamera && !_bfrontMode) {
        [_videoCamera flashOff];
    }
}

- (void)rotateButtons:(UIDeviceOrientation)willOrientation {
    
    [frontRearCameraButton doRotate:willOrientation];
    [_camaraCaptureButton doRotate:willOrientation];
    [_initFilterButton doRotate:willOrientation];
    [_cameraFilterButton doRotate:willOrientation];
    [_cameraBackgroundButton doRotate:willOrientation];
    [_thumbnailButton doRotate:willOrientation];
}

- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates {
    
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    CGSize frameSize = [_imageView frame].size;
    
    if (_bfrontMode) {
        viewCoordinates.x = frameSize.width - viewCoordinates.x;
    }    
    pointOfInterest = CGPointMake(viewCoordinates.y / frameSize.height, 1.f - (viewCoordinates.x / frameSize.width));
    return pointOfInterest;
}
    
#pragma mark -
#pragma mark thread

- (void)backgroudImageThread {

    @autoreleasepool {
        NSMutableArray *backgroundImageArray = [[NSMutableArray alloc] init];
        for (int i = BACKGROUND_IMAGE_COUNT; i >0; i--) {
            NSString *imageFileName = nil;
            if (i < 10) {
                imageFileName = [NSString stringWithFormat:@"back_effect_0%d.png", i];
            } else {
                imageFileName = [NSString stringWithFormat:@"back_effect_%d.png", i];
            }
            UIImage *backgroundImage = [UIImage imageNamed:imageFileName];
            [backgroundImageArray addObject:[Util resize:backgroundImage width:75 height:125]];
        }
        
        _cameraBackgroundScrollView = [[BottomHorizonScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                                self.view.bounds.size.height - (_cameraBottomView.frame.size.height + 105.0f + 30.0f),
                                                                                                320,
                                                                                                105)];
        _cameraBackgroundScrollView.type = CAMERA_BACKGROUND;
        _cameraBackgroundScrollView.currentThumbnailTag = 0;
        [_cameraBackgroundScrollView setThumbnailArray:backgroundImageArray];
        [self.view addSubview:_cameraBackgroundScrollView];
        
        [_processingAniView unLoading];
    }
}

#pragma mark -
#pragma mark buttons

- (void)closeCameraButton:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];  
}

- (void)frontRearCameraButton:(id)sender {
    
    _bfrontMode = !_bfrontMode;
    if (_videoCamera) {
        [_videoCamera rotateCamera];
    } else {
        [_stillCamera rotateCamera];
    }
}

- (void)cameraCaptureButton:(id)sender {
    
    if (_videoCamera && _bFlashMode && !_bfrontMode) {
        [_videoCamera flashOn];
    }
    
    // Flash the screen white and fade it out to give UI feedback that a still image was taken
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.bounds];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [[[self view] window] addSubview:flashView];
    
    [UIView animateWithDuration:.1f
                     animations:^{
                         
                         
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                         //[flashView release];
                     }
     ];
    
    /*
    BOOL bCameraSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraSoundSwitch"];
    if (bCameraSound) {
        
        [_shutterSoundPlayer stop];
        [_shutterSoundPlayer setNumberOfLoops:1];
        _shutterSoundPlayer.volume = 0.5f;
        [_shutterSoundPlayer play];
    } 
    */
    
    BOOL bCameraSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraSoundSwitch"];
    if (bCameraSound) {
        
        [_stillCamera capturePhotoAsImageProcessedUpToFilter:nil withCompletionHandler:^(UIImage *processedImage, NSError *error){
            
        }];
    } 

    [self performSelector:@selector(getCameraImage) withObject:nil afterDelay:1.0];
}

- (void)cameraEditButton:(id)sender  {
    

    /*
    if (_osVersion < 4.9) {
        if (editedImage.size.width > editedImage.size.height) {
            // 가로 이미지 돌려서 보여준다.
            //editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationUpMirrored];
            //editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationUpMirrored];
            //editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationRight];
        }
    }
    */
    
    // 이거 왜 이래야되나..
    _saveImage = [Util rotateImage:_saveImage orientation:UIImageOrientationUpMirrored];
    _saveImage = [Util rotateImage:_saveImage orientation:UIImageOrientationUpMirrored];
    
    
    if (_cameraBackgroundScrollView.currentThumbnailTag > 0) {
        _saveImage = [_cameraFilter backgroundImage:_cameraBackgroundScrollView.currentThumbnailTag originalImage:_saveImage];
    } 
    
    if (_saveImage != nil) {
        [self dismissModalViewControllerAnimated:YES];
       // if ([[self delegate] respondsToSelector:@selector(saveSelectedImage:frontmode:)]) {
            [[self delegate] saveSelectedImage:_saveImage frontmode:_bfrontMode];
        //}
    }
}

- (void)initFilterButton:(id)sender  {
    
    _scrollViewType = CAMERA_NONE;
    
    if (_cameraBackgroundScrollView) {
        [_cameraBackgroundScrollView deselectButton];
        _cameraBackgroundScrollView.currentThumbnailTag = 0;
        _cameraBackgroundScrollView.hidden = YES;
        _cameraBackgroundButton.selected = NO;
    }
    
    if (_cameraFilterScrollView) {
         [_cameraFilterScrollView deselectButton];
        _cameraFilterScrollView.currentThumbnailTag = 0;
        _cameraFilterScrollView.hidden = YES;
        _cameraFilterButton.selected = NO;
    }
    
    if (_backgroundImageView) {
        _backgroundImageView.image = nil;
    }
    
    [_defaultFilter removeAllTargets];
    GPUImageView *filterView = (GPUImageView *)_imageView;
    [_defaultFilter addTarget:filterView];
}

- (void)cameraFilterButton:(id)sender  {
    
    _scrollViewType = CAMERA_FILTER;
    
    if (_cameraBackgroundScrollView.hidden == NO) {
        _cameraBackgroundScrollView.hidden = YES;
        _cameraBackgroundButton.selected = NO;
    }
        
    UIButton *settingButton = (UIButton*)sender;
    settingButton.selected = !settingButton.selected;
    
    if (_cameraFilterScrollView == nil) {
        
        _cameraFilterScrollView = [[BottomHorizonScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                            self.view.bounds.size.height - (_cameraBottomView.frame.size.height + 105.0f + 30.0f),
                                                                                            320,
                                                                                            105)];
        _cameraFilterScrollView.type = CAMERA_FILTER;
        _cameraFilterScrollView.currentThumbnailTag = 0;
        [_cameraFilterScrollView setThumbnailArray:[_cameraFilter makeFilterImages:nil]];
        [self.view addSubview:_cameraFilterScrollView];
    } else {
        
        _cameraFilterScrollView.hidden = !_cameraFilterScrollView.hidden;
    }
}

- (void)cameraBackgroundButton:(id)sender {
    
    //_scrollViewType = CAMERA_BACKGROUND;
    
    if (_cameraFilterScrollView.hidden == NO) {
        _cameraFilterScrollView.hidden = YES;
        _cameraFilterButton.selected = NO;
    }
    
    UIButton *backgroudImageButton = (UIButton*)sender;
    backgroudImageButton.selected = !backgroudImageButton.selected;
    
    if (_cameraBackgroundScrollView == nil) {
        
        _processingAniView = [[ProcessingAniView alloc] init];
        [_processingAniView loadingWithParentView:self.view];
        
        [NSThread detachNewThreadSelector:@selector(backgroudImageThread) toTarget:self withObject:nil];
        
    } else {
        
        _cameraBackgroundScrollView.hidden = !_cameraBackgroundScrollView.hidden;
    }
}

#pragma mark -
#pragma mark Notification

- (void)orientationChanged:(NSNotification *)notification {
    
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self rotateButtons:orientation];
}
- (void)selectFilterNoti:(NSNotification *)notification {
    
    [_cameraFilterScrollView deselectButton];
    NSInteger cameraFilterType = [[NSUserDefaults standardUserDefaults] integerForKey:@"cameraFilterType"];
    [_cameraFilter selectFilter:cameraFilterType defaultFilter:_defaultFilter];
    _cameraFilterScrollView.currentThumbnailTag = cameraFilterType;
    [_cameraFilterScrollView selectButton];
}

- (void)selectBackgroundNoti:(NSNotification *)notification {
    
    [_cameraBackgroundScrollView deselectButton];
    NSInteger cameraBackgroundType = [[NSUserDefaults standardUserDefaults] integerForKey:@"cameraBackgroundType"];
    
    NSString *imageFileName = nil;
    if (cameraBackgroundType < 10) {
        imageFileName = [NSString stringWithFormat:@"back_effect_0%d.png", cameraBackgroundType];
    } else {
        imageFileName = [NSString stringWithFormat:@"back_effect_%d.png", cameraBackgroundType];
    }
    UIImage *backgroundImage = [UIImage imageNamed:imageFileName];
    _backgroundImageView.image = backgroundImage;
    _cameraBackgroundScrollView.currentThumbnailTag = cameraBackgroundType;
    [_cameraBackgroundScrollView selectButton];
}


#pragma mark -
#pragma mark UIGestureRecognizerDelegate

// Auto focus at a particular point. The focus mode will change to locked once the auto focus happens.
- (void)tapToAutoFocus:(UIGestureRecognizer *)gestureRecognizer {
    
    if (_cameraFilterScrollView.hidden == NO) {
        _cameraFilterScrollView.hidden = YES;
        _cameraFilterButton.selected = NO;
    }
    
    if (_cameraBackgroundScrollView.hidden == NO) {
        _cameraBackgroundScrollView.hidden = YES;
        _cameraBackgroundButton.selected = NO;
    }
    
    CGPoint tapPoint = [gestureRecognizer locationInView:_imageView];
    CGPoint convertedFocusPoint = [self convertToPointOfInterestFromViewCoordinates:tapPoint];
    [_videoCamera autoFocusAtPoint:convertedFocusPoint];
}

- (void)tapToContinouslyAutoFocus:(UIGestureRecognizer *)gestureRecognizer {
    
    [_videoCamera continuousFocusAtPoint:CGPointMake(.5f, .5f)];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if ([touch.view isKindOfClass:[UIButton class]]) return FALSE;
    return TRUE;
}

#pragma mark -
#pragma mark cameraFilterDelegate

- (void)setCameraFilter:(GPUImageOutput<GPUImageInput>*)filter {
    
    if (filter) {
        GPUImageView *filterView = (GPUImageView *)_imageView;
        [filter addTarget:filterView];
    }
}



@end
