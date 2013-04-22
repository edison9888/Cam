//
//  EditPictureViewController.m
//  NOpenCVProject
//
//  Created by Moon Sik on 11. 11. 24..
//  Copyright (c) 2011 inamass. All rights reserved.
//

#import "EditPictureViewController.h"
//#import "NUIImagePickerController.h"
#import "SettingViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import "CustomHttpRequest.h"
#import "SA_OAuthTwitterEngine.h"
#import <Twitter/Twitter.h>
#import "AppDelegate.h"

// zoom
#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP     1.5

#define SATURATION_SLIDER_TAG       10000
#define CONTRAST_SLIDER_TAG         10001
#define BRIGHTNESS_SLIDER_TAG       10002
#define ALL_MAKEUP_SLIDER_TAG       10003

#define ACTIONSHEET_CAMERA_TAG      10004
#define ACTIONSHEET_SAVE_TAG        10005

@implementation DetailImageScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesBegan:touches withEvent:event];
	[super touchesBegan: touches withEvent: event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesMoved:touches withEvent:event];
	[super touchesMoved: touches withEvent: event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesCancelled:touches withEvent:event];
	[super touchesCancelled: touches withEvent: event];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
	
	[self.nextResponder touchesEnded: touches withEvent:event]; 	
	[super touchesEnded: touches withEvent: event];
}
@end

@implementation EditPictureViewController

@synthesize locationManager = _locationManager;
//@synthesize saveImage = _saveImage;
@synthesize iType;
@synthesize imageAniView;
@synthesize originalImage = _originalImage;
@synthesize editedimage = _editedimage;
@synthesize preEditImage = _preEditImage;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation: UIStatusBarAnimationNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

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
    
    _bAllMakeUp = NO;
    bottomMenuSelected = -1;
    _editBackgroundType = 0;
    _editFilterType = 0;
    
    // location
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1000.0f;
    
    _bottomMenuScrollView = [[BottomMenuScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, 320, 49)];
    _bottomMenuScrollView.customDelegate = self;
    [self.view addSubview:_bottomMenuScrollView];
    
    _editImageFilter = [[EditImageFilter alloc] init];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectEditFilterNoti:) name:@"selectEditFilterNoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBackgroundNoti:) name:@"selectBackgroundNoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbSessionStateChangedNotification:) name:FBSessionStateChangedNotification
                                               object:nil];
    
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"saturation"];
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"contrast"];
    [[NSUserDefaults standardUserDefaults] setDouble:0.0 forKey:@"brightness"];
    [[NSUserDefaults standardUserDefaults] setDouble:2.0 forKey:@"makeup"];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"selectEditFilterNoti" object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"selectBackgroundNoti" object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:FBSessionStateChangedNotification object:nil];
    
    if (_indicatorView) {
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
    }
    /*
    if (_detailScrollView) {
        [_detailScrollView release];
        _detailScrollView = nil;
    }
    */
    
    if (_editedImageView) {
   
        _editedImageView = nil;
    }
    
    /*
    if (firstMenuSliderBgView) {
        [firstMenuSliderBgView release];
        firstMenuSliderBgView = nil;
    }
    */
    
    if (_imageFilterScrollView) {
        
        _imageFilterScrollView = nil;
    }
  
    if (_processingAniView) {
       
        _processingAniView = nil;
    }
    if (_imageBackgroundScrollView) {
        _imageBackgroundScrollView = nil;
    }
    
    if (_adBannerView) {
        _adBannerView.delegate = nil;
        _adBannerView = nil;
    }
    
    if (_originalImage) {
        _originalImage = nil;
    }
    
    if (_preEditImage) {
        _preEditImage = nil;
    }
    
    if (_editedimage) {
        _editedimage = nil;
    }
    
    if (_editImageFilter) {
    }
    
}

#pragma mark -
#pragma mark public

- (void)initTopMenuButtons {
    
    if (homeBtn == nil) {
        homeBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(160, 10, 0, 0)];
        homeBtn.backgroundColor = [UIColor clearColor];
        [homeBtn addTarget:self action:@selector(homeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [homeBtn setImage:[UIImage imageNamed:@"effect_top_m1.png"] forState:UIControlStateNormal];
        [self.view addSubview:homeBtn];
       
    }
    if (saveBtn == nil) {
        saveBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(160, 10, 0, 0)];
        saveBtn.backgroundColor = [UIColor clearColor];
        [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setImage:[UIImage imageNamed:@"effect_top_m2.png"] forState:UIControlStateNormal];
        [self.view addSubview:saveBtn];
        
    }
    if (orgimageBtn == nil) {
        orgimageBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(160, 10, 0, 0)];
        orgimageBtn.backgroundColor = [UIColor clearColor];
        [orgimageBtn addTarget:self action:@selector(orgimageBtn:) forControlEvents:UIControlEventTouchUpInside];
        [orgimageBtn setImage:[UIImage imageNamed:@"effect_top_m3.png"] forState:UIControlStateNormal];
        [self.view addSubview:orgimageBtn];
     
    }
    if (pictureBtn == nil) {
        pictureBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(160, 10, 0, 0)];
        pictureBtn.backgroundColor = [UIColor clearColor];
        [pictureBtn addTarget:self action:@selector(pictureBtn:) forControlEvents:UIControlEventTouchUpInside];
        [pictureBtn setImage:[UIImage imageNamed:@"effect_top_m4.png"] forState:UIControlStateNormal];
        [self.view addSubview:pictureBtn];
    
    }
    if (infoBtn == nil) {
        infoBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(160, 10, 0, 0)];
        infoBtn.backgroundColor = [UIColor clearColor];
        [infoBtn addTarget:self action:@selector(infoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [infoBtn setImage:[UIImage imageNamed:@"effect_top_m6.png"] forState:UIControlStateNormal];
        [self.view addSubview:infoBtn];
   
    }
}

- (void)initSliderView {
    
    
    if (firstMenuSliderBgView == nil) {
       
        CGFloat bgImageX = 0;
        CGFloat bgImageWidth = 0;
        CGFloat sliderX = 0;
        
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString* preferredLang = [languages objectAtIndex:0];
        if ([preferredLang isEqualToString:@"ko"]) {
            bgImageX = 13.0f;
            bgImageWidth = 40.0f;
            sliderX = 63.0f;
        } else {
            bgImageX = 4.0f;
            bgImageWidth = 64.0f;
            sliderX = 71.0f;
        }
        
        firstMenuSliderBgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                         self.view.frame.size.height - 49.0f - 120.0f,
                                                                         self.view.frame.size.width,
                                                                         110.0f)];
        
        saturationSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(sliderX, 10.0f, 241.0f, 19.0f)];
        saturationSlider.tag = SATURATION_SLIDER_TAG;
        saturationSlider.minimumValue = 0.0;
        saturationSlider.maximumValue = 2.0;
        [saturationSlider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
        [firstMenuSliderBgView addSubview:saturationSlider];
        //[saturationSlider release];
        [self.view addSubview:firstMenuSliderBgView];
        
        UIImage *labelBgImage = [[UIImage imageNamed:@"slider_text_back.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        UIImageView *saturationSliderBgImageView = [[UIImageView alloc] initWithImage:labelBgImage];
        saturationSliderBgImageView.frame = CGRectMake(bgImageX, 11.0f, bgImageWidth, labelBgImage.size.height);
        [firstMenuSliderBgView addSubview:saturationSliderBgImageView];
        
        NSString *saturationSliderTitle = NSLocalizedString(@"saturation", @"");
        CGFloat sliderFontSize = 12.0f;
        
        UIFont *sliderFont = [Util getFont:YES fontSize:sliderFontSize];
        CGSize sliderSize = [saturationSliderTitle sizeWithFont:sliderFont];
        UILabel *saturationLabel = [[UILabel alloc] initWithFrame:CGRectMake((bgImageWidth / 2) - (sliderSize.width / 2) + bgImageX, 13.0f, sliderSize.width, sliderSize.height)];
        saturationLabel.backgroundColor = [UIColor clearColor];
        saturationLabel.textColor = ColorFromRGB(0xffffff);
        saturationLabel.font = sliderFont;
        saturationLabel.text = saturationSliderTitle;
        [firstMenuSliderBgView addSubview:saturationLabel];
        //[saturationLabel release];
        
        contrastSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(sliderX, 45.0f, 241.0f, 19.0f)];
        contrastSlider.tag = CONTRAST_SLIDER_TAG;
        contrastSlider.minimumValue = 0.0;
        contrastSlider.maximumValue = 4.0;
        [contrastSlider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
        [firstMenuSliderBgView addSubview:contrastSlider];
        //[contrastSlider release];
        
        UIImageView *lightAndDarknessSliderBgImageView = [[UIImageView alloc] initWithImage:labelBgImage];
        lightAndDarknessSliderBgImageView.frame = CGRectMake(bgImageX, 46.0f, bgImageWidth, labelBgImage.size.height);
        [firstMenuSliderBgView addSubview:lightAndDarknessSliderBgImageView];
        
        NSString *contrastSliderTitle = NSLocalizedString(@"contrast", @"");
        
        sliderSize = [contrastSliderTitle sizeWithFont:sliderFont];
        UILabel *contrastLabel = [[UILabel alloc] initWithFrame:CGRectMake((bgImageWidth / 2) - (sliderSize.width / 2) + bgImageX, 48.0f, sliderSize.width, sliderSize.height)];
        contrastLabel.backgroundColor = [UIColor clearColor];
        contrastLabel.textColor = ColorFromRGB(0xffffff);
        contrastLabel.font = sliderFont;
        contrastLabel.text = contrastSliderTitle;
        [firstMenuSliderBgView addSubview:contrastLabel];
        //[contrastLabel release];
        
        UIImageView *brightnessSliderBgImageView = [[UIImageView alloc] initWithImage:labelBgImage];
        brightnessSliderBgImageView.frame = CGRectMake(bgImageX, 81.0f, bgImageWidth, labelBgImage.size.height);
        [firstMenuSliderBgView addSubview:brightnessSliderBgImageView];
        
        brightnessSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(sliderX, 80.0f, 241.0f, 19.0f)];
        brightnessSlider.tag = BRIGHTNESS_SLIDER_TAG;
        brightnessSlider.minimumValue = -0.2;
        brightnessSlider.maximumValue = 0.4;
        [brightnessSlider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
        [firstMenuSliderBgView addSubview:brightnessSlider];
       // [brightnessSlider release];
        
        NSString *brightnessTitle = NSLocalizedString(@"brightness", @"");
        
        sliderSize = [brightnessTitle sizeWithFont:sliderFont];
        UILabel *brightnessLabel = [[UILabel alloc] initWithFrame:CGRectMake((bgImageWidth / 2) - (sliderSize.width / 2) + bgImageX, 83.0f, sliderSize.width, sliderSize.height)];
        brightnessLabel.backgroundColor = [UIColor clearColor];
        brightnessLabel.textColor = ColorFromRGB(0xffffff);
        brightnessLabel.font = sliderFont;
        brightnessLabel.text = brightnessTitle;
        [firstMenuSliderBgView addSubview:brightnessLabel];
       // [brightnessLabel release];
        
        firstMenuSliderBgView.hidden = YES;
        //[firstMenuSliderBgView release];
    } else {
        
        [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"saturation"];
        [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"contrast"];
        [[NSUserDefaults standardUserDefaults] setDouble:0.0 forKey:@"brightness"];
        [[NSUserDefaults standardUserDefaults] setDouble:2.0 forKey:@"makeup"];
        
        saturationSlider.value = 1.0f;
        contrastSlider.value = 1.0f;
        brightnessSlider.value = 0;
    }
    
    /*
    secondMenuSliderBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 390.0f, 320.0f, 20.0f)];
    if (secondMenuSliderBgView) {
        allMakeUpSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(25.0f, 0.0f, 275.0f, 19.0f)];
        allMakeUpSlider.tag = ALL_MAKEUP_SLIDER_TAG;
        allMakeUpSlider.minimumValue = 1.0;
        allMakeUpSlider.maximumValue = 10.0;
        [allMakeUpSlider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
        [secondMenuSliderBgView addSubview:allMakeUpSlider];
        [self.view addSubview:secondMenuSliderBgView];
        
        secondMenuSliderBgView.hidden = YES;
    }
     */
}

- (void)animationinit
{
    UIButton *topMenuBgButton = [[UIButton alloc] initWithFrame:CGRectMake(94, 0, 132, 31)];
    topMenuBgButton.selected = NO;
    [topMenuBgButton setImage:[UIImage imageNamed:@"effect_top_btn.png"] forState:UIControlStateNormal];
    [topMenuBgButton setImage:[UIImage imageNamed:@"effect_top_btn_2.png"] forState:UIControlStateSelected];
    [topMenuBgButton addTarget:self action:@selector(topAnimationMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topMenuBgButton];
    [self performSelector:@selector(topAnimationMenu:) withObject:topMenuBgButton afterDelay:0.2f];
   // [topMenuBgButton release];
}

- (void)setImage:(UIImage*)originalImage
{
    if (originalImage) {
        
        NSLog(@"before setImage imageSize : %@", NSStringFromCGSize(originalImage.size));
        
        if (originalImage.size.width > 960) {
            CGFloat imageHeight = (originalImage.size.height * 960) / originalImage.size.width;
            CGSize resizeSize = CGSizeMake(960, imageHeight);
            originalImage = [Util imageWithImage:originalImage scaledToSize:resizeSize];
        }
        
        NSLog(@"after setImage imageSize : %@", NSStringFromCGSize(originalImage.size));
        
        _bAllMakeUp = NO;
        _editBackgroundType = 0;
        _editFilterType = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:_editBackgroundType forKey:@"editBackgroundType"];
        [[NSUserDefaults standardUserDefaults] setInteger:_editFilterType forKey:@"editFilterType"];
    
        self.originalImage = originalImage;
        self.editedimage = originalImage;
        self.preEditImage = originalImage;
        
        if (_detailScrollView == nil) {
            
            CGRect detailScrollViewFrame = CGRectZero;
            CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
            if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
                detailScrollViewFrame = CGRectMake(0,
                                                   45.0f,
                                                   self.view.frame.size.width,
                                                   self.view.frame.size.height - 49.0f - 89.0f);
            } else {
                detailScrollViewFrame = CGRectMake(0,
                                                   0,
                                                   self.view.frame.size.width,
                                                   self.view.frame.size.height - 49.0f);
            }
            _detailScrollView = [[DetailImageScrollView alloc] initWithFrame:detailScrollViewFrame];
            _detailScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
            _detailScrollView.delegate = self;
            [self.view addSubview:_detailScrollView];
           // [_detailScrollView release];
        } else {
            CGSize detailScrollViewSize = _detailScrollView.frame.size;
            [_detailScrollView setMaximumZoomScale:1.0];
            [_detailScrollView setContentSize:detailScrollViewSize];   
            [_detailScrollView setMinimumZoomScale:1.0];
            [_detailScrollView setZoomScale:0.5];
            [_detailScrollView setScrollEnabled:NO];
            
            _editedImageView.frame = _detailScrollView.bounds;
            _editedImageView.clipsToBounds = YES;
        }
        
        UIViewContentMode mode;
        if (originalImage.size.width > originalImage.size.height) {
            
            
            NSLog(@"UIViewContentModeScaleAspectFit");
            
            if (originalImage.imageOrientation == UIImageOrientationUp) {
                mode = UIViewContentModeScaleAspectFit;
            } else {
                mode = UIViewContentModeScaleAspectFill;
            }
            
            NSLog(@"image orientation : %d", originalImage.imageOrientation);
            
        } else {
            
            mode = UIViewContentModeScaleAspectFill;
            /*
            if (originalImage.imageOrientation == UIImageOrientationRight) {
                mode = UIViewContentModeScaleToFill;
            } else {
                mode = UIViewContentModeScaleToFill;
            }
            */
            NSLog(@"UIViewContentModeScaleToFill");
        }
        
        if (_editedImageView == nil) {
            _editedImageView = [[UIImageView alloc] initWithFrame:_detailScrollView.bounds];
            _editedImageView.clipsToBounds = YES;
            [_detailScrollView addSubview:_editedImageView];
           // [_editedImageView release];
        }
        _editedImageView.contentMode = mode;
        [_editedImageView setImage:originalImage];
        
        // 수정이 필요할듯...
        UIImage *makeUpBongImage = [UIImage imageNamed:@"magic_tool.png"];
        makeUpBongImageView = [[UIImageView alloc] initWithImage:makeUpBongImage];
        makeUpBongImageView.frame = CGRectMake((self.view.frame.size.width / 2) - (makeUpBongImage.size.width / 2),
                                               (self.view.frame.size.height / 2) - (makeUpBongImage.size.height / 2),
                                               makeUpBongImage.size.width,
                                               makeUpBongImage.size.height);
        [_detailScrollView addSubview:makeUpBongImageView];
       // [makeUpBongImageView release];
        makeUpBongImageView.hidden = YES;
        
        // 광고
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString* preferredLang = [languages objectAtIndex:0];
        if ([preferredLang isEqualToString:@"ko"]) {
            
            _adBannerView = [[ADBanner alloc] initWithFrame:CGRectMake(0,
                                                                       self.view.bounds.size.height - 207.0f,
                                                                       self.view.bounds.size.width,
                                                                       48.0f)];
            _adBannerView.delegate = self;
            
            // applicationID = 발급받은 어플리케이션 ID, adWindowID = 발급받은 광고 윈도우 ID
            // 발급 받은 어플리케이션ID가 "mezzo/mezzoapps/" 라면 "mezzo/mezzoapps" 끝의 "/"를 제거 하여 주세요.
            //[_adBannerView applicationID:@"msolution/picshow" adWindowID:@"banner" setADBgColor:[UIColor blackColor]];
            [_adBannerView applicationID:@"msolution/beautycamera/" adWindowID:@"banner"];    
            [_adBannerView startBannerAd];
            [self.view addSubview:_adBannerView];
            _adBannerView.hidden = YES;
            //[_adBannerView release];
        } else {
            
            _gadBannerView = [[GADBannerView alloc]
                              initWithFrame:CGRectMake(0,
                                                       self.view.bounds.size.height - 207.0f,
                                                       GAD_SIZE_320x50.width,
                                                       GAD_SIZE_320x50.height)];
            
            // 광고의 '단위 ID'로 AdMob 게시자 ID를 지정합니다.
            _gadBannerView.adUnitID = ADMOB_ID;
            
            // 광고의 방문 페이지로 사용자를 연결한 후 복구할 UIViewController를
            // 지정하여 뷰 계층에 추가합니다.
            _gadBannerView.rootViewController = self;
            [self.view addSubview:_gadBannerView];
            
            // 기본 요청을 시작하여 광고와 함께 로드합니다.
            [_gadBannerView loadRequest:[GADRequest request]];
            _gadBannerView.hidden = YES;
        }
        
        // init
        [self initTopMenuButtons];
        [self initSliderView];
        [self animationinit];
    }
}

- (void)rollbackToOriginalImage {
    
    if (self.originalImage) {
        
        _bAllMakeUp = NO;
        _editBackgroundType = 0;
        _editFilterType = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:_editBackgroundType forKey:@"editBackgroundType"];
        [[NSUserDefaults standardUserDefaults] setInteger:_editFilterType forKey:@"editFilterType"];
        
        self.editedimage = _originalImage;
        self.preEditImage = _originalImage;
        _editedImageView.image = _originalImage;
    }
    
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"saturation"];
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"contrast"];
    [[NSUserDefaults standardUserDefaults] setDouble:0.0 forKey:@"brightness"];
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"allMakeup"];
}

- (void)allReset {
    
    [self changeADBannerHiddenState:YES];
    
    if (makeUpBongImageView) {
        makeUpBongImageView.hidden = YES;
    }
    
    if (firstMenuSliderBgView) {
        firstMenuSliderBgView.hidden = YES;
    }
    
    if (_bottomMenuScrollView) {
        [_bottomMenuScrollView AllDeselectButtons];
    }
    
    if (_imageBackgroundScrollView) {
        _imageBackgroundScrollView.hidden = YES;
    }
    
    if (_imageFilterScrollView) {
        _imageFilterScrollView.hidden = YES;
       // [_imageFilterScrollView release];
        _imageFilterScrollView = nil;
    }
}

- (void)completeOneEditWithMenuIndex:(NSInteger)menuIndex {
    
    // < 확대모드에서 복귀
    CGSize detailScrollViewSize = _detailScrollView.frame.size;
    [_detailScrollView setMaximumZoomScale:1.0];
    [_detailScrollView setContentSize:detailScrollViewSize];   
    [_detailScrollView setMinimumZoomScale:1.0];
    [_detailScrollView setZoomScale:0.5];
    [_detailScrollView setScrollEnabled:NO];
    
    _editedImageView.frame = _detailScrollView.bounds;
    _editedImageView.clipsToBounds = YES;
    // >
    
    //self.editedimage = _preEditImage;
    if (bottomMenuSelected != menuIndex) {
        self.preEditImage = _editedimage;
    }
    
    if (menuIndex != 0) {
        firstMenuSliderBgView.hidden = YES;
    } 
    
    if (menuIndex != 1) {
        [self changeADBannerHiddenState:YES];
        _imageBackgroundScrollView.hidden = YES;
    } 
    
    if (menuIndex != 2) {
        
        [self changeADBannerHiddenState:YES];
        _imageFilterScrollView.hidden = YES;
    }
    
    if (menuIndex != 3) {
        
    } 
    
    if (menuIndex != 4) {
        makeUpBongImageView.hidden = YES;
    }
    
    bottomMenuSelected = menuIndex;
}

- (void)rotateButtons:(UIDeviceOrientation)willOrientation {
    
    // top buttons
    if (homeBtn && homeBtn.hidden == NO) {
        [homeBtn doRotate:willOrientation];
    }
    if (saveBtn && saveBtn.hidden == NO) {
        [saveBtn doRotate:willOrientation];
    }
    if (orgimageBtn && orgimageBtn.hidden == NO) {
        [orgimageBtn doRotate:willOrientation];
    }
    if (pictureBtn && pictureBtn.hidden == NO) {
        [pictureBtn doRotate:willOrientation];
    }
    if (infoBtn && infoBtn.hidden == NO) {
        [infoBtn doRotate:willOrientation];
    }
    
    if (_bottomMenuScrollView) {
        [_bottomMenuScrollView rotateButtons:willOrientation];
    }
}

- (void)setLoadingView {
    
    if (_processingAniView == nil) {
        _processingAniView = [[ProcessingAniView alloc] init];
    }
    [_processingAniView loadingWithParentView:self.view];
}

- (void)deSetLoadingView {
    
    [_processingAniView unLoading];
}


- (NSDictionary*)getGPSDictionaryForLocation:(CLLocation*)location {
    
    NSMutableDictionary *gpsDict = [NSMutableDictionary dictionary];
    
    // GPS tag version
    [gpsDict setObject:@"2.2.0.0" forKey:(NSString*)kCGImagePropertyGPSVersion];
    
    // time and date must be provided a strings, not as an NSDate object
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss.SSSSSS"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [gpsDict setObject:[formatter stringFromDate:location.timestamp] forKey:(NSString*)kCGImagePropertyGPSTimeStamp];
    [formatter setDateFormat:@"yyyy:MM:dd"];
    [gpsDict setObject:[formatter stringFromDate:location.timestamp] forKey:(NSString*)kCGImagePropertyGPSDateStamp];
    //[formatter release];
    
    // latitude
    CGFloat latitude = location.coordinate.latitude;
    if (latitude < 0) {
        latitude -= latitude;
        [gpsDict setObject:@"S" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
    } else {
        [gpsDict setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
    }
    [gpsDict setObject:[NSNumber numberWithFloat:latitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];
    
    // longtitude
    CGFloat longitude = location.coordinate.longitude;
    if (longitude < 0) {
        longitude -= longitude;
        [gpsDict setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
    } else {
        [gpsDict setObject:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
    }
    [gpsDict setObject:[NSNumber numberWithFloat:longitude] forKey:(NSString*)kCGImagePropertyGPSLongitude];
    
    // altitude
    CGFloat altitude = location.altitude;
    if (altitude < 0) {
        altitude -= altitude;
        [gpsDict setObject:@"1" forKey:(NSString*)kCGImagePropertyGPSAltitudeRef];
    } else {
        [gpsDict setObject:@"0" forKey:(NSString*)kCGImagePropertyGPSAltitudeRef];
    }
    [gpsDict setObject:[NSNumber numberWithFloat:altitude] forKey:(NSString*)kCGImagePropertyGPSAltitude];
    
    // speed, must be converted from m/s to km/h
    if(location.speed >= 0) {
        [gpsDict setObject:@"K" forKey:(NSString*)kCGImagePropertyGPSSpeedRef];
        [gpsDict setObject:[NSNumber numberWithFloat:location.speed *3.6] forKey:(NSString*)kCGImagePropertyGPSSpeed];
    }
    
    // heading
    if(location.course >= 0) {
        [gpsDict setObject:@"T" forKey:(NSString*)kCGImagePropertyGPSTrackRef];
        [gpsDict setObject:[NSNumber numberWithFloat:location.course] forKey:(NSString*)kCGImagePropertyGPSTrackRef];
    }
    
    NSLog(@"gpsDict : %@", gpsDict);
    return gpsDict;
}

-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)localError contextInfo:(void*)contextInfo {
    
    if(!localError){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:NSLocalizedString(@"saveCameraRoll", @"") 
                                                           delegate:nil 
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:NSLocalizedString(@"failCameraroll", @"") 
                                                           delegate:nil 
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
}

- (void)editImage {

    [NSThread detachNewThreadSelector:@selector(editImageThread) toTarget:self withObject:nil];
    
    //[self setLoadingView];
    
    CGFloat saturation = [[NSUserDefaults standardUserDefaults] doubleForKey:@"saturation"];
    CGFloat brightness = [[NSUserDefaults standardUserDefaults] doubleForKey:@"brightness"];
    CGFloat contrast = [[NSUserDefaults standardUserDefaults] doubleForKey:@"contrast"];
    
    NSLog(@"before image orientation : %d", _preEditImage.imageOrientation);
    
    UIImageOrientation originalImageOrientation = _preEditImage.imageOrientation;
    
    UIImage *filterImage = [_editImageFilter saturationFilter:_preEditImage value:saturation];
    filterImage = [_editImageFilter brightnessFilter:filterImage value:brightness];    
    filterImage = [_editImageFilter contrastFilter:filterImage value:contrast];
    
    if (_bAllMakeUp) {
        filterImage = [_editImageFilter makeupFilter:filterImage value:2.0];
    }        
    
    if (_editFilterType) {
        filterImage = [_editImageFilter selectFilter:_editFilterType originalImage:filterImage];
    }
    if (_editBackgroundType) {
        if (_osVersion < 4.9) {
            //filterImage = [Util rotateImage:filterImage orientation:orientation];
        } 
        filterImage = [_editImageFilter backgroundImage:_editBackgroundType originalImage:filterImage originalImageOrientation:originalImageOrientation];
    } else {
        if (_osVersion < 4.9) {
            //filterImage = [Util rotateImage:filterImage orientation:orientation];
        }
    }
    
    NSLog(@"after image orientation : %d", filterImage.imageOrientation);
    if (originalImageOrientation != filterImage.imageOrientation) {
        filterImage = [Util rotateImage:filterImage orientation:originalImageOrientation];
        _editedImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    NSLog(@"re image orientation : %d", filterImage.imageOrientation);
    
    _editedImageView.image = filterImage;
    
    [self deSetLoadingView];
}

- (void)rotateImage {
    
    _preEditImage = [Util rotateImage:_preEditImage orientation:UIImageOrientationLeft];
    NSLog(@"rotateImage imageOrientation : %d", _preEditImage.imageOrientation);
    _editedImageView.image = _preEditImage;
                             
}

- (void)changeADBannerHiddenState:(BOOL)bHidden {
    
    if (_adBannerView) {
        _adBannerView.hidden = bHidden;
        [_adBannerView viewShowState:!bHidden];
    } else {
        _gadBannerView.hidden = bHidden;
    }
}

- (void)uploadImageToFacebook:(NSString*)text {

    if (_indicatorView == nil) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (window) {
            _alphaView = [[UIView alloc] initWithFrame:window.bounds];
            _alphaView.backgroundColor = [UIColor blackColor];
            _alphaView.alpha = 0.5f;
            [window addSubview:_alphaView];
            
            CGFloat width = 25.0f;
            _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((window.frame.size.width / 2) - (width / 2),
                                                                                       (window.frame.size.height / 2) - (width / 2) + 10.0f, 
                                                                                       width, 
                                                                                       width)];
            _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _indicatorView.hidesWhenStopped = YES;
            [_indicatorView startAnimating];
            [window addSubview:_indicatorView];
        }
    }
    
    NSData *imageData = UIImageJPEGRepresentation(_editedImageView.image, 90);

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:FBSession.activeSession.accessToken,@"access_token",
                                   text, @"message",
                                   imageData, @"source",
                                   nil];
    
    FBRequest *fbRequest = [FBRequest requestWithGraphPath:@"me/photos"
                                                parameters:params
                                                HTTPMethod:@"POST"];
    
    [fbRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (_alphaView) {
            [_alphaView removeFromSuperview];
            _alphaView = nil;
        }
        
        if (_indicatorView) {
            [_indicatorView stopAnimating];
            [_indicatorView removeFromSuperview];
            _indicatorView = nil;
        }
        
        if (error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"failFacebook", @"")
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                                      otherButtonTitles:nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"uploadFacebook", @"")
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }];
}

- (void)uploadImageToTwitter:(NSString *)text {
    
    if (_indicatorView == nil) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (window) {
            _alphaView = [[UIView alloc] initWithFrame:window.bounds];
            _alphaView.backgroundColor = [UIColor blackColor];
            _alphaView.alpha = 0.5f;
            [window addSubview:_alphaView];
            
            CGFloat width = 25.0f;
            _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((window.frame.size.width / 2) - (width / 2),
                                                                                       (window.frame.size.height / 2) - (width / 2) + 10.0f, 
                                                                                       width, 
                                                                                       width)];
            _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _indicatorView.hidesWhenStopped = YES;
            [_indicatorView startAnimating];
            [window addSubview:_indicatorView];
        }
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (delegate && delegate.oAuthTwitterEngine) {
        
        SA_OAuthTwitterEngine *oAuthTwitterEngine = delegate.oAuthTwitterEngine;
        if (oAuthTwitterEngine) {
            [oAuthTwitterEngine uploadImage:_editedImageView.image text:text requestType:MGTwitterPublicTimelineRequest responseType:MGTwitterStatuses];
            //[_oAuthTwitterEngine sendUpdate: [NSString stringWithFormat: @"%@", text]];
        }
    }
}

- (void)showTwitterTextViewController {
    
    SocialTextViewController *socialTextViewController = [[SocialTextViewController alloc] init];
    socialTextViewController.delegate = self;
    socialTextViewController.socialType = TWEET;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:socialTextViewController];
    [self presentModalViewController:navigationController animated:YES];   
}

#pragma mark -
#pragma mark Thread

- (void)editImageThread {
   
    @autoreleasepool {
        
        [self setLoadingView];
    }
    
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    /*
    CGFloat saturation = [[NSUserDefaults standardUserDefaults] doubleForKey:@"saturation"];
    CGFloat brightness = [[NSUserDefaults standardUserDefaults] doubleForKey:@"brightness"];
    CGFloat contrast = [[NSUserDefaults standardUserDefaults] doubleForKey:@"contrast"];

    UIImage *filterImage = [_editImageFilter saturationFilter:_preEditImage value:saturation];
    //filterImage = [_editImageFilter brightnessFilter:filterImage value:brightness];    
    //filterImage = [_editImageFilter contrastFilter:filterImage value:contrast];
    
    if (_bAllMakeUp) {
        filterImage = [_editImageFilter makeupFilter:filterImage value:2.0];
    }        
    
    if (_editFilterType) {
        filterImage = [_editImageFilter selectFilter:_editFilterType originalImage:filterImage];
    }
    if (_editBackgroundType) {
        if (_osVersion < 4.9) {
            //filterImage = [Util rotateImage:filterImage orientation:orientation];
        } 
        filterImage = [_editImageFilter backgroundImage:_editBackgroundType originalImage:filterImage];
    } else {
        if (_osVersion < 4.9) {
            //filterImage = [Util rotateImage:filterImage orientation:orientation];
        }
    }
    
    _editedImageView.image = filterImage;
    
    [self deSetLoadingView];
    
    //[pool release];
     */
}

- (void)showEditFiltersThread {
    
   // NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    @autoreleasepool {
        if (_imageFilterScrollView == nil) {
            _imageFilterScrollView = [[BottomHorizonScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                               self.view.bounds.size.height - (_bottomMenuScrollView.frame.size.height + 105.0f + 7.0f),
                                                                                               self.view.bounds.size.width,
                                                                                               105)];
            _imageFilterScrollView.type = EDITOR_FILTER;
            [_imageFilterScrollView setThumbnailArray:[_editImageFilter makeFilterImages:_editedimage]];
            [self.view addSubview:_imageFilterScrollView];
            [self changeADBannerHiddenState:NO];
        }else{
            
            if (_imageFilterScrollView.hidden == NO) {
                _imageFilterScrollView.hidden = YES;
            } else {
                [_imageFilterScrollView setThumbnailArray:[_editImageFilter makeFilterImages:_editedimage]];
                _imageFilterScrollView.hidden = NO;
                [self changeADBannerHiddenState:NO];
            }
        }
        
        [self deSetLoadingView];
    }
    //[pool release];
}

- (void)showBackgroundImagesThread
{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    @autoreleasepool {
        
        if (_imageBackgroundScrollView == nil) {
            _imageBackgroundScrollView = [[BottomHorizonScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                                   self.view.bounds.size.height - (_bottomMenuScrollView.frame.size.height + 105.0f + 7.0f),
                                                                                                   self.view.bounds.size.width,
                                                                                                   105)];
            _imageBackgroundScrollView.type = EDITOR_BACKGROUND;
            
            NSMutableArray * imageArray = [[NSMutableArray alloc] init];
            for (int i = BACKGROUND_IMAGE_COUNT; i >0; i--) {
                NSString *imageFileName = nil;
                if (i < 10) {
                    imageFileName = [NSString stringWithFormat:@"back_effect_0%d.png", i];
                } else {
                    imageFileName = [NSString stringWithFormat:@"back_effect_%d.png", i];
                }
                UIImage * tempImage = [UIImage imageNamed:imageFileName];
                [imageArray addObject:[Util resize:tempImage width:75 height:125]];
            }
            [_imageBackgroundScrollView setThumbnailArray:imageArray];
            [self.view addSubview:_imageBackgroundScrollView];
            [self changeADBannerHiddenState:NO];
        }else{
            
            if (_imageBackgroundScrollView.hidden == YES) {
                _imageBackgroundScrollView.hidden = NO;
                [self changeADBannerHiddenState:NO];
            } else {
                _imageBackgroundScrollView.hidden = YES;
                [_imageBackgroundScrollView deselectButton];
            }
        }
        [self deSetLoadingView];
    }
    

    //[pool release];
}

#pragma mark -
#pragma mark ScrollView

- (void)scrollResize:(CGSize)photoSize {
  
    if (_detailScrollView.maximumZoomScale != 2.0f){
        
        [_detailScrollView setScrollEnabled:YES];  
        _detailScrollView.maximumZoomScale = 3.0;
        [_detailScrollView setMinimumZoomScale:1.0];
        [_detailScrollView setZoomScale:1.0];
        _detailScrollView.clipsToBounds = YES;
        // lovemuz98 13.01.18 주석처리
        //[_editedImageView setCenter:[_detailScrollView center]];
        [_detailScrollView setBounces:YES];
    }
}

#pragma mark -
#pragma mark buttons

- (void)topAnimationMenu:(id)sender
{
    UIButton *topBgButton = (UIButton*)sender;
    topBgButton.selected = !topBgButton.selected;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationDidStopSelector:@selector(animationMoveStop)];
    if (topBgButton.selected) {
        topBgButton.frame = CGRectMake(94, 0, 132, 31);
        homeBtn.frame = CGRectMake(61, 17, 39, 39);
        saveBtn.frame = CGRectMake(97.5, 35,39, 39);
        // 중간
        orgimageBtn.frame = CGRectMake(138, 41, 39, 39);
        pictureBtn.frame = CGRectMake(179, 35, 39, 39);
        infoBtn.frame = CGRectMake(215, 17, 39, 39);
        
        [homeBtn animationStart];
        [saveBtn animationStart];
        [orgimageBtn animationStart];
        [pictureBtn animationStart];
        [infoBtn animationStart];
    }else{
        topBgButton.frame = CGRectMake(94, -8, 132, 31);
        homeBtn.frame = CGRectMake(160, 10, 0, 0);
        saveBtn.frame = CGRectMake(160, 10, 0, 0);
        orgimageBtn.frame = CGRectMake(160, 10, 0, 0);
        pictureBtn.frame = CGRectMake(160, 10, 0, 0);
        infoBtn.frame = CGRectMake(160, 10, 0, 0);
        
        [homeBtn animationStart];
        [saveBtn animationStart];
        [orgimageBtn animationStart];
        [pictureBtn animationStart];
        [infoBtn animationStart];
    }
    
    [UIView commitAnimations];
}

-(void)animationMoveStop {
    
    [homeBtn animationStop];
    [saveBtn animationStop];
    [orgimageBtn animationStop];
    [pictureBtn animationStop];
    [infoBtn animationStop];
}

- (void)infoBtn:(id)sender {

    if (!_infoView) {
        _infoView = [[InfoView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_infoView];
    } else {
        _infoView.hidden = !_infoView.hidden;
    }
}

- (void)homeBtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveBtn:(id)sender {
    
    UIActionSheet *actionSheetMenu = [[UIActionSheet alloc] initWithTitle:nil 
                                                                 delegate:self 
                                                        cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles: NSLocalizedString(@"facebook", @""),  NSLocalizedString(@"twitter", @""), NSLocalizedString(@"cameraRoll", @""), nil];
    [actionSheetMenu setTag:ACTIONSHEET_SAVE_TAG];
    [actionSheetMenu showInView:self.view];
}

- (void)orgimageBtn:(id)sender {
    
    [self rollbackToOriginalImage];
}

- (void)pictureBtn:(id)sender {
    
    UIActionSheet *actionSheetMenu = [[UIActionSheet alloc] initWithTitle:nil 
                                                                 delegate:self 
                                                        cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"takePhoto", @""), NSLocalizedString(@"photoAlbum", @""), nil];
    [actionSheetMenu setTag:ACTIONSHEET_CAMERA_TAG];
    [actionSheetMenu showInView:self.view];
    //;
}

- (void)cameraButton {

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:NSLocalizedString(@"notCamera", @"") 
                                                           delegate:nil 
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    CameraViewController *cameraViewController = [[CameraViewController alloc] init];
    cameraViewController.delegate = self;
    [self.navigationController presentModalViewController:cameraViewController animated:YES];
    //[cameraViewController release];
}

-(void)moveSlider:(id)sender {
    
    NSLog(@"moveSlider");
    
    CustomSlider *slider = (CustomSlider*)sender;
    if (slider) { 
        
         //[self setLoadingView];
        
        float value = slider.value;
        NSLog(@"slider Value : %f", value);
        switch (slider.tag) {
            case SATURATION_SLIDER_TAG:
            {
                if (sliderType != SATURATION_SLIDER) {
                    sliderType = SATURATION_SLIDER;
                    //self.preEditImage = _editedimage;
                }
                
                
                
                [[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"saturation"];
                [self editImage];
                /*
                NSString *valueString = [[NSString alloc] initWithFormat:@"%f", value];
                [NSThread detachNewThreadSelector:@selector(saturationThread:) toTarget:self withObject:valueString];
                [valueString release];
                 */
            }
                break;
            case CONTRAST_SLIDER_TAG:
            {
                if (sliderType != CONTRAST_SLIDER) {
                    sliderType = CONTRAST_SLIDER;
                    //self.preEditImage = _editedimage;
                }
                
                [[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"contrast"];
                [self editImage];
                /*
                NSString *valueString = [[NSString alloc] initWithFormat:@"%f", value];
                [NSThread detachNewThreadSelector:@selector(contrastThread:) toTarget:self withObject:valueString];
                [valueString release];
                 */
            }
                break;
            case BRIGHTNESS_SLIDER_TAG:
            {
                if (sliderType != BRIGHTNESS_SLIDER) {
                    sliderType = BRIGHTNESS_SLIDER;
                    //self.preEditImage = _editedimage;
                }
    
                [[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"brightness"];
                [self editImage];
                /*
                NSString *valueString = [[NSString alloc] initWithFormat:@"%f", value];
                [NSThread detachNewThreadSelector:@selector(brightnessThread:) toTarget:self withObject:valueString];
                [valueString release];
                 */
            }
                break;
            case ALL_MAKEUP_SLIDER_TAG:
            {
      
                if (sliderType != MAKEUP_SLIDER) {
                    sliderType = MAKEUP_SLIDER;
                    //self.preEditImage = _editedimage;
                }
                
                [[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"makeup"];
                [self editImage];
                /*
                NSString *valueString = [[NSString alloc] initWithFormat:@"%f", value];
                [NSThread detachNewThreadSelector:@selector(makeupThread:) toTarget:self withObject:valueString];
                [valueString release];
                 */
            }
                break;
        }
    }
}

#pragma mark -
#pragma mark Touch Event

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint prevLocation = [touch previousLocationInView:_detailScrollView];
    
    BOOL bBottomDeselect = YES;
    
    if (_infoView && _infoView.hidden == NO) {
        _infoView.hidden = YES;
    }
    
    if (firstMenuSliderBgView.hidden == NO) {
        firstMenuSliderBgView.hidden = YES;
    } else {
        if (bottomMenuSelected == 0) {
            firstMenuSliderBgView.hidden = NO;
            [_bottomMenuScrollView selectButton:bottomMenuSelected];
            bBottomDeselect = NO;
        }
    }
    /*
    if (secondMenuSliderBgView.hidden == NO) {
        secondMenuSliderBgView.hidden = YES;
    } else {
        if (bottomMenuSelected == 1) {
            secondMenuSliderBgView.hidden = NO;
            [_bottomMenuScrollView selectButton:bottomMenuSelected];
            bBottomDeselect = NO;
        }
    }
    */
    
    if (_imageBackgroundScrollView.hidden == NO) {
        _imageBackgroundScrollView.hidden = YES;
    } else {
        if (bottomMenuSelected == 1) {
            _imageBackgroundScrollView.hidden = NO;
            [_bottomMenuScrollView selectButton:bottomMenuSelected];
            [self changeADBannerHiddenState:NO];
            bBottomDeselect = NO;
        }
    }

    
    if (_imageFilterScrollView.hidden == NO) {
        _imageFilterScrollView.hidden = YES;
    } else {
        if (bottomMenuSelected == 2) {
            _imageFilterScrollView.hidden = NO;
            [self changeADBannerHiddenState:NO];
            [_bottomMenuScrollView selectButton:bottomMenuSelected];
            bBottomDeselect = NO;
        }
    }
    
    if (makeUpBongImageView.hidden == YES) {
        if (_bottomMenuScrollView.hidden == NO) {
            if (bBottomDeselect) {
                 [_bottomMenuScrollView AllDeselectButtons];
                [self changeADBannerHiddenState:YES];
            }
        }
    } else {
        
        NSLog(@" photoSize.width =%f, photoSize.height=%f", _editedImageView.image.size.width, _editedImageView.image.size.height);
        CGPoint scpoint =prevLocation ;
        
        if (_detailScrollView.zoomScale  < 1 ) {
            NSLog(@"=========> scpoint x=%f y =%f scrollView.zoomScale =%f",prevLocation.x,prevLocation.y,_detailScrollView.zoomScale);
            scpoint = CGPointMake(prevLocation.x *(2 - _detailScrollView.zoomScale) ,  prevLocation.y  *(2 - _detailScrollView.zoomScale) );
            
        }else if(_detailScrollView.zoomScale  > 1 ){
            NSLog(@"------------> scpoint x=%f y =%f scrollView.zoomScale =%f",prevLocation.x,prevLocation.y,_detailScrollView.zoomScale);
            scpoint = CGPointMake(prevLocation.x /_detailScrollView.zoomScale ,  prevLocation.y  /_detailScrollView.zoomScale );
        }
        NSLog(@"scpoint x=%f y =%f",scpoint.x,scpoint.y);
        CGRect rect = CGRectMake(scpoint.x - 10, scpoint.y - 10, 40, 40);
        
        
        UIImageOrientation originalOrientation = _editedImageView.image.imageOrientation;
        
        UIImage *filterImage = [EditImageFilter NSmooth:_editedImageView.image RECT:rect];
        if (originalOrientation != UIImageOrientationUp) {
            filterImage = [Util rotateImage:filterImage orientation:originalOrientation];
        }
        //UIImage *filterImage = [_editImageFilter selectBlurFilter:_preEditImage point:CGPointMake(scpoint.x / 320, scpoint.y / 320)];
        [_editedImageView setImage:filterImage];
        
        
        CGRect frame = makeUpBongImageView.frame;
        frame.origin.x = prevLocation.x;
        frame.origin.y = prevLocation.y;
        
        //frame.origin.x = scpoint.x - (_detailScrollView.zoomScale);
        //frame.origin.y = scpoint.y - (_detailScrollView.zoomScale);
        makeUpBongImageView.frame = frame;
        
        NSLog(@"makeUpBongImageViewFrame : %@", NSStringFromCGRect(frame));
    }
    
    /*
     if (subViewSelect == 24) {
     NSLog(@" photoSize.width =%f, photoSize.height=%f", imageView.image.size.width, imageView.image.size.height);
     CGPoint scpoint =prevLocation ;
     
     if (_detailScrollView.zoomScale  < 1 ) {
     NSLog(@"=========> scpoint x=%f y =%f scrollView.zoomScale =%f",prevLocation.x,prevLocation.y,_detailScrollView.zoomScale);
     scpoint = CGPointMake(prevLocation.x *(2 - _detailScrollView.zoomScale) ,  prevLocation.y  *(2 - _detailScrollView.zoomScale) );
     
     }else if(_detailScrollView.zoomScale  > 1 ){
     NSLog(@"------------> scpoint x=%f y =%f scrollView.zoomScale =%f",prevLocation.x,prevLocation.y,_detailScrollView.zoomScale);
     scpoint = CGPointMake(prevLocation.x /_detailScrollView.zoomScale ,  prevLocation.y  /_detailScrollView.zoomScale );
     }
     NSLog(@"scpoint x=%f y =%f",scpoint.x,scpoint.y);
     CGRect rect = CGRectMake(scpoint.x - 10, scpoint.y - 10, 20, 20);
     [imageView setImage:[Utilities NSmooth:imageView.image RECT:rect]];
     }
     */
}

#pragma mark -
#pragma mark Notification

- (void)orientationChanged:(NSNotification *)notification {
    
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self rotateButtons:orientation];
}

- (void)selectBackgroundNoti:(NSNotification*)notification {
    
    //[self setLoadingView];
    
    [_imageBackgroundScrollView deselectButton];
    _editBackgroundType = [[NSUserDefaults standardUserDefaults] integerForKey:@"editBackgroundType"]; 
    _imageBackgroundScrollView.currentThumbnailTag = _editBackgroundType;
    [_imageBackgroundScrollView selectButton];
    
    [self editImage];
    /*
    NSString *valueString = [[NSString alloc] initWithFormat:@"%d", _editBackgroundType];
    [NSThread detachNewThreadSelector:@selector(backgroudImageThread:) toTarget:self withObject:valueString];
    [valueString release];
    */
}

- (void)selectEditFilterNoti:(NSNotification*)notification {
    
    //[self setLoadingView];
    
    [_imageFilterScrollView deselectButton];
    _editFilterType = [[NSUserDefaults standardUserDefaults] integerForKey:@"editFilterType"];
    _imageFilterScrollView.currentThumbnailTag = _editFilterType;
    
    [self editImage];
    
    /*
    NSString *valueString = [[NSString alloc] initWithFormat:@"%d", _editFilterType];
    [NSThread detachNewThreadSelector:@selector(editFilterThread:) toTarget:self withObject:valueString];
    [valueString release];
     */
}

#pragma mark -
#pragma mark BottomMenuScrollViewDelegate

- (void)BottomMenuFirstButton {    
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest editPicture];
    
    [self completeOneEditWithMenuIndex:0];
    
    firstMenuSliderBgView.hidden = !firstMenuSliderBgView.hidden;
    if (firstMenuSliderBgView.hidden == NO) {
        saturationSlider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:@"saturation"];
        brightnessSlider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:@"brightness"];
        contrastSlider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:@"contrast"];
    }
}

- (void)BottomMenuSecondButton {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest background];
    
    [self completeOneEditWithMenuIndex:1];
    
    if (_imageBackgroundScrollView == nil || _imageBackgroundScrollView.hidden == YES) {
        [self setLoadingView];
    }
    [NSThread detachNewThreadSelector:@selector(showBackgroundImagesThread) toTarget:self withObject:nil];
}

- (void)BottomMenuThirdButton {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest filter];
    
    [self completeOneEditWithMenuIndex:2];
    
    if (_imageFilterScrollView == nil || _imageFilterScrollView.hidden == YES) {
        [self setLoadingView];
    }
    [NSThread detachNewThreadSelector:@selector(showEditFiltersThread) toTarget:self withObject:nil];
}

- (void)BottomMenuFourthButton {  
    
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest makeUp];
    
    [self completeOneEditWithMenuIndex:3];
    
    makeUpBongImageView.hidden = !makeUpBongImageView.hidden;
    
    [self scrollResize:_editedImageView.image.size];

}

- (void)BottomMenuFifthButton {    
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest allMakeUp];
    
    [self completeOneEditWithMenuIndex:4];
    
    _bAllMakeUp = YES;
    
    [self editImage];
    
    //[NSThread detachNewThreadSelector:@selector(makeupThread:) toTarget:self withObject:nil];
    
    /*
     secondMenuSliderBgView.hidden = !secondMenuSliderBgView.hidden;
     if (secondMenuSliderBgView.hidden == NO) {
     allMakeUpSlider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:@"makeup"];
     }
     */
    
    /*
     if (sliderType != MAKEUP_SLIDER) {
     sliderType = MAKEUP_SLIDER;
     self.preEditImage = _editedimage;
     
     [[NSUserDefaults standardUserDefaults] setFloat:allMakeUpSlider.value forKey:@"makeup"];
     NSString *valueString = [[NSString alloc] initWithFormat:@"%f", allMakeUpSlider.value];
     [NSThread detachNewThreadSelector:@selector(makeupThread:) toTarget:self withObject:valueString];
     [valueString release];
     }
     */
}

- (void)BottomMenuSixthButton {  
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest setting];
    
    [self completeOneEditWithMenuIndex:5];
    
    [_bottomMenuScrollView AllDeselectButtons];
    
    SettingViewController * settingView = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingView animated:YES];
    //[settingView release];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale  {
    
    // 줌인/줌아웃 처리하기.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView  {
        
    return _editedImageView;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    ALAssetsLibraryWriteImageCompletionBlock completionBlock = ^(NSURL *assetUrl, NSError *error) {
        if (error != nil || assetUrl == nil) {
            NSLog(@"Failed to save photo : %@", error);
            NSLog(@"assetUrl : %@", assetUrl);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"failCameraroll", @"")
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                                      otherButtonTitles:nil];
            [alertView show];
        } else {
            NSLog(@"Url is : %@", [assetUrl absoluteString]);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"saveCameraRoll", @"")
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    };
    
    NSMutableDictionary *metaDataDict = [[NSMutableDictionary alloc] init];
    [metaDataDict setObject:[self getGPSDictionaryForLocation:newLocation] forKey:(NSString*)kCGImagePropertyGPSDictionary];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[_editedimage CGImage] metadata:metaDataDict completionBlock:completionBlock];
    //[library release];
    //[metaDataDict release];
    
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"locationManager Error : %@", error);
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (actionSheet.tag == ACTIONSHEET_CAMERA_TAG) {
        
        if (buttonIndex == 0) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self performSelector:@selector(cameraButton) withObject:nil afterDelay:0.2f];
            } else {
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                                        message:NSLocalizedString(@"notCamera", @"") 
                                                                       delegate:nil 
                                                              cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                              otherButtonTitles:nil];
                    [alertView show];
                    
                    return;
                }
                //[alert release];
            }
        } else if (buttonIndex == 1) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            pickerController.allowsEditing = NO;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:pickerController animated:YES];
        }
        
    } else if (actionSheet.tag == ACTIONSHEET_SAVE_TAG) {
        
        if (buttonIndex == 0) {
            
            if ([FBSession.activeSession isOpen]) {
                SocialTextViewController *socialTextViewController = [[SocialTextViewController alloc] init];
                socialTextViewController.delegate = self;
                socialTextViewController.socialType = FACEBOOK;
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:socialTextViewController];
                [[self navigationController] presentModalViewController:navigationController animated:YES];
            } else {
                AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
                [appDelegate openSessionWithAllowLoginUI:YES];
            }
            
        } else if (buttonIndex == 1) {
            
            Class ios5Twitter = NSClassFromString(@"TWTweetComposeViewController");
            if (ios5Twitter) {
                
                TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
                [twitter setInitialText:NSLocalizedString(@"sendPhoto",@"")];
                [twitter addImage:_editedImageView.image];
                [self presentModalViewController:twitter animated:YES];
                
                [twitter setCompletionHandler:^(TWTweetComposeViewControllerResult result){
                    
                    if (result == TWTweetComposeViewControllerResultDone) {
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                                            message:NSLocalizedString(@"uploadTwitter", @"") 
                                                                           delegate:nil 
                                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                                  otherButtonTitles:nil];
                        [alertView show];
                    }   
                    [self dismissModalViewControllerAnimated:YES];
                }];
                
            } else {
            
                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                if (delegate && delegate.oAuthTwitterEngine) {
                    
                    SA_OAuthTwitterEngine *oAuthTwitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
                    oAuthTwitterEngine.consumerKey = kOAuthConsumerKey;
                    oAuthTwitterEngine.consumerSecret = kOAuthConsumerSecret;
                    [oAuthTwitterEngine setClearsCookies:YES];
                    
                    delegate.oAuthTwitterEngine = oAuthTwitterEngine;
                    
                    SA_OAuthTwitterController *oAuthTwitterController = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:oAuthTwitterEngine
                                                                                                                                        delegate: self];
                    if (oAuthTwitterController) {
                        [self presentModalViewController:oAuthTwitterController animated: YES];
                    } else {
                        SocialTextViewController *socialTextViewController = [[SocialTextViewController alloc] init];
                        socialTextViewController.delegate = self;
                        socialTextViewController.socialType = TWEET;
                        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:socialTextViewController];
                        [[self navigationController] presentModalViewController:navigationController animated:YES];    
                    }
                }
            }
            
        } else if (buttonIndex == 2) {
            
            // 지오태킹 켜 있으면
            BOOL bGeoSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"geoSwitch"];
            if (bGeoSwitch) {
                [_locationManager startUpdatingLocation];
            } else {
                UIImageWriteToSavedPhotosAlbum(_editedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
}

#pragma mark -
#pragma mark imagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
   
    [self allReset];
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (originalImage.size.width > originalImage.size.height) {
        // 가로 이미지 돌려서 보여준다.
        originalImage = [Util rotateImage:originalImage orientation:UIImageOrientationRight];
    }
    
    /*
    UIImageOrientation originalImageOrientation = originalImage.imageOrientation;
    
    if (originalImageOrientation == UIImageOrientationRight) {
        if (originalImage.size.width > originalImage.size.height) {
            originalImage = [Util rotateImage:originalImage orientation:UIImageOrientationRight];
        }
        
    } else if (originalImageOrientation == UIImageOrientationLeft) {
        if (originalImage.size.width > originalImage.size.height) {
            originalImage = [Util rotateImage:originalImage orientation:UIImageOrientationLeft];
        }
    }
    */
    
    if (originalImage) {
        [self setImage:originalImage];
    }    
}

#pragma mark -
#pragma mark CameraViewControllerDelegate

- (void)saveSelectedImage:(UIImage*)editedImage frontmode:(BOOL)bFrontMode {
    
    [self allReset];
    
    if (bFrontMode) {
        // 아이폰4 이상의 정면카메라 에서 찍으면 바꾸어줌
        editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationRightMirrored];
        editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationRight];
    } 
    
    [self setImage:editedImage];
}

#pragma mark -
#pragma mark SA_OAuthTwitterEngineDelegate
- (void)storeCachedTwitterOAuthData:(NSString*)data forUsername:(NSString*)username {
	
    NSLog(@"storeCachedTwitterOAuthData data : %@ username : %@", data, username);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  
    
    [defaults setObject:data forKey:@"twitterAuthData"];  
    [defaults synchronize];
}

- (NSString*)cachedTwitterOAuthDataForUsername:(NSString*)username {  
    return [[NSUserDefaults standardUserDefaults] objectForKey: @"twitterAuthData"];  
}

#pragma mark -
#pragma mark SA_OAuthTwitterControllerDelegate

- (void)OAuthTwitterController:(SA_OAuthTwitterController*)controller authenticatedWithUsername:(NSString *)_username {
	
    NSLog(@"Authenicated for %@", _username);
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"twitterSwitch"];
    [self performSelector:@selector(showTwitterTextViewController) withObject:nil afterDelay:3.0]; 
}

- (void)OAuthTwitterControllerFailed:(SA_OAuthTwitterController*)controller {
	
    NSLog(@"Authentication Failed!");
}

- (void)OAuthTwitterControllerCanceled:(SA_OAuthTwitterController*)controller {
    
	NSLog(@"Authentication Canceled.");
}

#pragma mark -
#pragma mark TwitterEngineDelegate

- (void)requestSucceeded:(NSString *)requestIdentifier {
	
    NSLog(@"Request %@ succeeded", requestIdentifier);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
	    
    if (_alphaView) {
        [_alphaView removeFromSuperview];
        _alphaView = nil;
    }
    
    if (_indicatorView) {
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
        _indicatorView = nil;
    }
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:NSLocalizedString(@"uploadTwitter", @"") 
                                                       delegate:nil 
                                              cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)requestFailed:(NSString*)requestIdentifier withError:(NSError*)error {
    
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
    NSLog(@"error.domain: %@", error.domain);
    
    if (![error.domain hasSuffix:@"NSXMLParserErrorDomain Code"] && error.code != 4) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
        
        if (_alphaView) {
            [_alphaView removeFromSuperview];
            _alphaView = nil;
        }
        
        if (_indicatorView) {
            [_indicatorView stopAnimating];
            [_indicatorView removeFromSuperview];
            _indicatorView = nil;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:NSLocalizedString(@"failTwitter", @"") 
                                                           delegate:nil 
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark -
#pragma mark SocialViewControllerDelegate

- (void)cancelText {
    
}

- (void)uploadToFacebook:(NSString*)text {
    
    [self uploadImageToFacebook:text];
}

- (void)uploadToTwitter:(NSString*)text {
    
    [self uploadImageToTwitter:text];
}

#pragma mark -
#pragma mark fbSession

- (void)fbSessionStateChangedNotification:(NSNotification *)notification {
    
    FBSession *session = notification.object;
    
    switch (session.state) {
        case FBSessionStateOpen: {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"facebookSwitch"];
            
            SocialTextViewController *socialTextViewController = [[SocialTextViewController alloc] init];
            socialTextViewController.delegate = self;
            socialTextViewController.socialType = FACEBOOK;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:socialTextViewController];
            [[self navigationController] presentModalViewController:navigationController animated:YES];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed: {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"facebookSwitch"];
        }
            break;
        default:
            break;
    }
}


@end
