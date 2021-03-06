//
//  ViewController.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EditPictureViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"
#import "CustomHttpRequest.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    backImageView.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:backImageView];
    
    NSString *firstStart = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstStart"];
    if (firstStart == nil) {
        
        CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
        [httpRequest requestFirstExec];
        
        // 처음 실행
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"firstStart"];
        // 카메라 사운드
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"cameraSoundSwitch"];
    }

    [self performSelector:@selector(showHomeView) withObject:nil afterDelay:0.2f];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (_adBannerView) {
        [_adBannerView viewShowState:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    if (_adBannerView) {
        [_adBannerView viewShowState:NO];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    if(_homeView){
        [_homeView removeFromSuperview];
        _homeView = nil;
    }
    
    if (_adBannerView) {
        _adBannerView.delegate = nil;
        _adBannerView = nil;
    }
}

#pragma mark -
#pragma mark public

- (void)showHomeView {
    
    if (_homeView == nil) {
        _homeView =[[HomeView alloc] initWithFrame:self.view.bounds];
        _homeView.delegate = self;
    }
    if (_homeView) {
        [_homeView removeFromSuperview];
        [self.view addSubview:_homeView];
        
        
        // 광고
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString* preferredLang = [languages objectAtIndex:0];
        if ([preferredLang isEqualToString:@"ko"]) {
            
            _adBannerView = [[ADBanner alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 48.0f, self.view.frame.size.width, 48.0f)];
            _adBannerView.delegate = self;
            
            // applicationID = 발급받은 어플리케이션 ID, adWindowID = 발급받은 광고 윈도우 ID
            // 발급 받은 어플리케이션ID가 "mezzo/mezzoapps/" 라면 "mezzo/mezzoapps" 끝의 "/"를 제거 하여 주세요.
            //[_adBannerView applicationID:@"msolution/picshow" adWindowID:@"banner" setADBgColor:[UIColor blackColor]];
            [_adBannerView applicationID:@"msolution/beautycamera/" adWindowID:@"banner" setADBgColor:[UIColor clearColor]];
            
            [_adBannerView startBannerAd];
            [self.view addSubview:_adBannerView];
            [_adBannerView showInterstitial];
            
        } else {
            
            _gadBannerView = [[GADBannerView alloc]
                              initWithFrame:CGRectMake(0,
                                                       self.view.frame.size.height - GAD_SIZE_320x50.height,
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
        }
        
        BOOL bcameraMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraModeSwitch"];
        if (bcameraMode) {
            // camera module
            CameraViewController *cameraViewController = [[CameraViewController alloc] init];
            cameraViewController.delegate = self;
            [self.navigationController presentModalViewController:cameraViewController animated:YES];
        }
    }
}

- (void)editImageModule {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest getPicture];
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = NO;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;    
    [self presentModalViewController:pickerController animated:YES];
}

- (void)cameraModule {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest takeCamera];
    
    CameraViewController *cameraViewController = [[CameraViewController alloc] init];
    cameraViewController.delegate = self;
    [self.navigationController presentModalViewController:cameraViewController animated:YES];
}

- (void)settingModule {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest setting];
    
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (void)aboutModule {
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    [httpRequest about];
    
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

#pragma mark -
#pragma mark HomeViewDelegate 

- (void)onHomeButtonClick:(NSInteger)buttonTag {
    
    if (buttonTag == CHOOSE_A_PICTURE_BTN_TAG) {
        [self performSelector:@selector(editImageModule) withObject:nil afterDelay:0.3f];
    }else if (buttonTag == SETTING_PICTURE_BTN_TAG) {
        [self performSelector:@selector(settingModule) withObject:nil afterDelay:1.0f];
    }else if (buttonTag == ABOUT_PICTURE_BTN_TAG) {
        [self performSelector:@selector(aboutModule) withObject:nil afterDelay:1.0f];
    }else if (buttonTag == TAKE_PICTURE_BTN_TAG || buttonTag == TAKE2_PICTURE_BTN_TAG) {
        [self performSelector:@selector(cameraModule) withObject:nil afterDelay:0.3f];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
	   didFinishPickingImage:(UIImage *)originalImage
				 editingInfo:(NSDictionary *)editingInfo
{
	[picker dismissModalViewControllerAnimated:YES];
    
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
        
        if (originalImage.size.width > originalImage.size.height) {
            // 가로 이미지 돌려서 보여준다.
            originalImage = [Util rotateImage:originalImage orientation:UIImageOrientationRight];
        }
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"cameraPictureFilterType"];
        EditPictureViewController *editPictureViewController = [[EditPictureViewController alloc] init];
        [editPictureViewController setImage:originalImage];
        [self.navigationController pushViewController:editPictureViewController animated:NO];
        //[editPictureViewController release];
    }
}

#pragma mark -
#pragma mark CameraViewControllerDelegate

- (void)saveSelectedImage:(UIImage*)editedImage frontmode:(BOOL)bFrontMode {
    
    if (bFrontMode) {
        // 아이폰4 이상의 정면카메라 에서 찍으면 바꾸어줌
        editedImage = [Util rotateImage:editedImage orientation:UIImageOrientationUpMirrored];
    } 
    
    if (editedImage) {
        EditPictureViewController *editPictureViewController =[[EditPictureViewController alloc] init];
        [editPictureViewController setImage:editedImage];
        [self.navigationController pushViewController:editPictureViewController animated:NO];
        //[editPictureViewController release];
    }
}

@end
