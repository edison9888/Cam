//
//  SettingViewController.m
//  NOpenCVProject
//
//  Created by Moon Sik on 12. 1. 12..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import "SettingViewController.h"
#import "EditPictureViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "AppDelegate.h"

#define CAMERA_MODE_SWITCH_TAG  9100
#define GIO_SWITCH_TAG          9101
#define FLASH_MODE_SWITCH_TAG   9102
#define CAMERA_SOUND_SWITCH_TAG 9103
#define FACEBOOK_SWITCH_TAG     9104
#define TWITTER_SWITCH_TAG      9105

#define TWITTER_ALERT_VIEW_TAG	5000
#define FACEBOOK_ALERT_VIEW_TAG 5001


@implementation SettingViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = ColorFromRGB(0xf9f9f9);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        // ios5
        UIImage *image = [UIImage imageNamed: @"bar.png"];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    NSString *titleStr = NSLocalizedString(@"settingViewControllerTitle", @"");
    CGFloat fontSize = 19.0f;
    
    UIFont *titleFont = [Util getFont:YES fontSize:fontSize];
    CGSize titleFontSize = [titleStr sizeWithFont:titleFont];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleFontSize.width, titleFontSize.height)];
    titleLabel.textColor = ColorFromRGB(0x383838);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleStr;
    titleLabel.font = titleFont;
    self.navigationItem.titleView = (UIView*)titleLabel;
    //[titleLabel release];
    
    UIImage *backButtonImage = [UIImage imageNamed:NSLocalizedString(@"backBtn", @"")];
    UIImage *backButtonOnImage = [UIImage imageNamed:NSLocalizedString(@"backBtnOn", @"")];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)]; 
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton setImage:backButtonOnImage forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem; 
    //[leftBarButtonItem release];
    //[backButton release];
    
    UIImage *cameraButtonImage = [UIImage imageNamed:@"cam_btn.png"];
    UIImage *cameraButtonOnImage = [UIImage imageNamed:@"cam_btn2.png"];
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cameraButtonImage.size.width, cameraButtonImage.size.height)]; 
    [cameraButton setImage:cameraButtonImage forState:UIControlStateNormal];
	[cameraButton setImage:cameraButtonOnImage forState:UIControlStateHighlighted];
    [cameraButton addTarget:self action:@selector(cameraButton:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem; 
    //[rightBarButtonItem release];
    //[cameraButton release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, 5.0f, self.view.frame.size.width - 5.0f, self.view.frame.size.height - 60.0f) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setBackgroundView:nil];
    [self.view addSubview:_tableView];
    
    // 광고
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if ([preferredLang isEqualToString:@"ko"]) {
        
        _adBannerView = [[ADBanner alloc] initWithFrame:CGRectMake(0,
                                                                   self.view.bounds.size.height - 48.0f - 44.0f,
                                                                   self.view.bounds.size.width,
                                                                   48.0f)];
        _adBannerView.delegate = self;
        
        // applicationID = 발급받은 어플리케이션 ID, adWindowID = 발급받은 광고 윈도우 ID
        // 발급 받은 어플리케이션ID가 "mezzo/mezzoapps/" 라면 "mezzo/mezzoapps" 끝의 "/"를 제거 하여 주세요.
       [_adBannerView applicationID:@"msolution/beautycamera/" adWindowID:@"banner"];
       [_adBannerView startBannerAd];
       [self.view addSubview:_adBannerView];
        
    } else {
        
        _gadBannerView = [[GADBannerView alloc]
                          initWithFrame:CGRectMake(0,
                                                   self.view.bounds.size.height - GAD_SIZE_320x50.height - 44.0f,
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
    
    _settingArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *sectionOneArray = [[NSMutableArray alloc] init];
    
    [sectionOneArray addObject:NSLocalizedString(@"cameraMode", @"cameraMode")];
    [sectionOneArray addObject:NSLocalizedString(@"geotagging", @"geotagging")];
    [sectionOneArray addObject:NSLocalizedString(@"shutterSound", @"shutterSound")];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        // flash 지원됨
        [sectionOneArray addObject:NSLocalizedString(@"flashMode", @"flashMode")];
    }
    
    NSDictionary *sectionOneDict = [NSDictionary dictionaryWithObject:sectionOneArray forKey:@"section"];
                 
    NSArray *sectionTwoArray = nil;
   
    Class ios5Twitter = NSClassFromString(@"TWTweetComposeViewController");
    if (ios5Twitter) {
        
        sectionTwoArray = [NSArray arrayWithObjects:NSLocalizedString(@"facebook", @""),
                           nil];
    
    } else {
        
        sectionTwoArray = [NSArray arrayWithObjects:NSLocalizedString(@"facebook", @""),
                           NSLocalizedString(@"twitter", @""),
                           nil];
    }
    
    NSDictionary *sectionTwoDict = [NSDictionary dictionaryWithObject:sectionTwoArray forKey:@"section"];
    
    [_settingArray addObject:sectionOneDict];
    [_settingArray addObject:sectionTwoDict];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbSessionStateChangedNotification:) name:FBSessionStateChangedNotification
                                               object:nil];
    
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
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (_adBannerView) {
        [_adBannerView viewShowState:YES];
    }
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

#pragma mark -
#pragma mark tableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_settingArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [_settingArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"section"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } 
    
    NSDictionary *settingDict = [_settingArray objectAtIndex:indexPath.section];
    NSArray *sectionArray = [settingDict objectForKey:@"section"];
    
    cell.textLabel.font = [Util getFont:NO fontSize:16.0f];
    cell.textLabel.text = [sectionArray objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            UISwitch *cameraModeSwitch = (UISwitch*)[cell viewWithTag:CAMERA_MODE_SWITCH_TAG];
            if (!cameraModeSwitch) {
                BOOL bCameraModeSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraModeSwitch"];
                cameraModeSwitch = [[UISwitch alloc] init];
                cameraModeSwitch.frame = CGRectMake(cell.frame.size.width - cameraModeSwitch.frame.size.width - 24.0f, 
                                                    7.0f, 
                                                    cameraModeSwitch.frame.size.width, 
                                                    30.0f);
                cameraModeSwitch.tag = CAMERA_MODE_SWITCH_TAG;
                [cameraModeSwitch addTarget:self action:@selector(cameraModeSwitch:) forControlEvents:UIControlEventValueChanged];
                cameraModeSwitch.on = bCameraModeSwitch;
                [cell addSubview:cameraModeSwitch];
                //[cameraModeSwitch release];
            }
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                cameraModeSwitch.enabled = NO;
            }
            
        } else if (indexPath.row == 1) {
            
            UISwitch *geoSwitch = (UISwitch*)[cell viewWithTag:GIO_SWITCH_TAG];
            if (!geoSwitch) {
                BOOL bGeoSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"geoSwitch"];
                geoSwitch = [[UISwitch alloc] init];
                geoSwitch.frame = CGRectMake(cell.frame.size.width - geoSwitch.frame.size.width - 24.0f,
                                             7.0f, 
                                             geoSwitch.frame.size.width, 
                                             30.0f);
                geoSwitch.tag = GIO_SWITCH_TAG;
                [geoSwitch addTarget:self action:@selector(geoSwitchChange:) forControlEvents:UIControlEventValueChanged];
                geoSwitch.on = bGeoSwitch;
                [cell addSubview:geoSwitch];
                //[geoSwitch release];
            }
            
            
        } else if (indexPath.row == 2) {
            
            UISwitch *soundSwitch = (UISwitch*)[cell viewWithTag:CAMERA_SOUND_SWITCH_TAG];
            if (!soundSwitch) {
                BOOL bSoundSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"cameraSoundSwitch"];
                soundSwitch = [[UISwitch alloc] init];
                soundSwitch.tag = CAMERA_SOUND_SWITCH_TAG;
                [soundSwitch addTarget:self action:@selector(cameraSoundSwitch:) forControlEvents:UIControlEventValueChanged];
                soundSwitch.on = bSoundSwitch;
                [cell addSubview:soundSwitch];
                //[soundSwitch release];
            }
            soundSwitch.frame = CGRectMake(cell.frame.size.width - soundSwitch.frame.size.width - 24.0f, 
                                           7.0f, 
                                           soundSwitch.frame.size.width, 
                                           30.0f);
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                soundSwitch.on = NO;
                soundSwitch.enabled = NO;
            }
            
            
        } else if(indexPath.row == 3) {
            
            UISwitch *flashModeSwitch = (UISwitch*)[cell viewWithTag:FLASH_MODE_SWITCH_TAG];
            if (!flashModeSwitch) {
                BOOL bFlashModeSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"flashModeSwitch"];
                flashModeSwitch = [[UISwitch alloc] init];
                flashModeSwitch.frame = CGRectMake(cell.frame.size.width - flashModeSwitch.frame.size.width - 24.0f, 
                                                   7.0f, 
                                                   flashModeSwitch.frame.size.width, 
                                                   30.0f);
                flashModeSwitch.tag = FLASH_MODE_SWITCH_TAG;
                [flashModeSwitch addTarget:self action:@selector(flashModeSwitch:) forControlEvents:UIControlEventValueChanged];
                flashModeSwitch.on = bFlashModeSwitch;
                [cell addSubview:flashModeSwitch];
                //[flashModeSwitch release];
            }
        }
    } else if (indexPath.section == 1) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(indexPath.row == 0) {
            
            _facebookSwitch = (UISwitch*)[cell viewWithTag:FACEBOOK_SWITCH_TAG];
            if (!_facebookSwitch) {
                BOOL bFacebookSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"facebookSwitch"];
                _facebookSwitch = [[UISwitch alloc] init];
                _facebookSwitch.tag = FACEBOOK_SWITCH_TAG;
                [_facebookSwitch addTarget:self action:@selector(facebookSwitch:) forControlEvents:UIControlEventValueChanged];
                _facebookSwitch.on = bFacebookSwitch;
                [cell addSubview:_facebookSwitch];
            }
            _facebookSwitch.frame = CGRectMake(cell.frame.size.width - _facebookSwitch.frame.size.width - 24.0f, 
                                               7.0f, 
                                               _facebookSwitch.frame.size.width, 
                                               30.0f);
        } else if(indexPath.row == 1) {
            
            _twitterSwitch = (UISwitch*)[cell viewWithTag:TWITTER_SWITCH_TAG];
            if (!_twitterSwitch) {
                BOOL bTwitterSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitterSwitch"];
                _twitterSwitch = [[UISwitch alloc] init];
                _twitterSwitch.tag = TWITTER_SWITCH_TAG;
                [_twitterSwitch addTarget:self action:@selector(twitterSwitch:) forControlEvents:UIControlEventValueChanged];
                _twitterSwitch.on = bTwitterSwitch;
                [cell addSubview:_twitterSwitch];
                
            }
            _twitterSwitch.frame = CGRectMake(cell.frame.size.width - _twitterSwitch.frame.size.width - 24.0f, 
                                           7.0f, 
                                           _twitterSwitch.frame.size.width, 
                                           30.0f);
        }
        
        
    }
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -
#pragma mark buttons

- (void)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cameraButton:(id)sender {
    
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

-(void)geoSwitchChange:(id)sender {
    
	UISwitch *geoSwitch = (UISwitch*)sender;
	if (geoSwitch.on) {
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"geoSwitch"];
	}
	else {
		[[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"geoSwitch"];
	}    
}

-(void)flashModeSwitch:(id)sender {
    
	UISwitch *flashModeSwitch = (UISwitch*)sender;
	if (flashModeSwitch.on) {
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"flashModeSwitch"];
	}
	else {
		[[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"flashModeSwitch"];
	}
}

- (void)cameraModeSwitch:(id)sender {
    
	UISwitch *cameraModeSwitch = (UISwitch*)sender;
	if (cameraModeSwitch.on) {
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cameraModeSwitch"];
	}
	else {
		[[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cameraModeSwitch"];
	}
}

- (void)cameraSoundSwitch:(id)sender {
    
    UISwitch *cameraSoundSwitch = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setBool:cameraSoundSwitch.isOn forKey:@"cameraSoundSwitch"];
}


- (void)facebookSwitch:(id)sender {
    
    UISwitch *facebookSwitch = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setBool:facebookSwitch.isOn forKey:@"facebookSwitch"];
    
    if (facebookSwitch.isOn == YES) {
        // get the app delegate so that we can access the session property
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        [appDelegate openSessionWithAllowLoginUI:YES];
        
        // facebook 연동
        /*
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        if (delegate && delegate.facebook) {
            Facebook *facebook = delegate.facebook;
            if (![facebook isSessionValid]) {
                NSArray* permissions = [[NSArray alloc] initWithObjects:
                                        @"publish_stream", nil];
                [facebook authorize:permissions delegate:self];
            }
        }
        */
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:NSLocalizedString(@"disconnectFacebook", @"")
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"ok", @""), nil];
        alertView.tag = FACEBOOK_ALERT_VIEW_TAG;
        [alertView show];
    }
}

- (void)twitterSwitch:(id)sender {
    
    UISwitch *twitterSwitch = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setBool:twitterSwitch.isOn forKey:@"twitterSwitch"];
    
    if (twitterSwitch.isOn == YES) {
        
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        SA_OAuthTwitterEngine *oAuthTwitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
        oAuthTwitterEngine.consumerKey = kOAuthConsumerKey;
        oAuthTwitterEngine.consumerSecret = kOAuthConsumerSecret;
        [oAuthTwitterEngine setClearsCookies:YES];
        
        delegate.oAuthTwitterEngine = oAuthTwitterEngine;
        
        SA_OAuthTwitterController *oAuthTwitterController = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:oAuthTwitterEngine
                                                                                                                            delegate:self];
        if (oAuthTwitterController) {
            [self.navigationController presentModalViewController:oAuthTwitterController animated: YES];
        }
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"disconnectTwitter", @"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"ok", @""), nil];
        alertView.tag = TWITTER_ALERT_VIEW_TAG;
        [alertView show];
    }
}

- (void)dealloc {
    
    //[super dealloc];
    
     [[NSNotificationCenter defaultCenter]  removeObserver:self name:FBSessionStateChangedNotification object:nil];
    
    if (_tableView) {
        //[_tableView release];
        _tableView = nil;
    }
    
    if (_settingArray) {
        //[_settingArray release];
        _settingArray = nil;
    }
    
    if (_adBannerView) {
        _adBannerView.delegate = nil;
        _adBannerView = nil;
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

- (void)OAuthTwitterController:(SA_OAuthTwitterController*)controller authenticatedWithUsername:(NSString*)_username {
    
	// 인증성공	
	NSLog(@"Authenicated for %@", _username);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:NSLocalizedString(@"loginTwitter", @"")
                                                       delegate:nil 
                                              cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)OAuthTwitterControllerFailed:(SA_OAuthTwitterController*)controller {
    
	NSLog(@"Authentication Failed!");
}

- (void)OAuthTwitterControllerCanceled:(SA_OAuthTwitterController*)controller {
    
	NSLog(@"Authentication Canceled.");
    _twitterSwitch.on = NO;
}

#pragma mark -
#pragma mark alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	if (buttonIndex == alertView.cancelButtonIndex) {
        
        if (alertView.tag == TWITTER_ALERT_VIEW_TAG) {
            
            _twitterSwitch.on = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"twitterSwitch"];
            
        } else if (alertView.tag == FACEBOOK_ALERT_VIEW_TAG) {
            
            _facebookSwitch.on = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"facebookSwitch"];
        }
        return;
	}
	
	if (alertView.tag == TWITTER_ALERT_VIEW_TAG) {
        
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        if (delegate && delegate.oAuthTwitterEngine) {
            
            SA_OAuthTwitterEngine *oAuthTwitterEngine = delegate.oAuthTwitterEngine;
            if (oAuthTwitterEngine) {
                [oAuthTwitterEngine clearAccessToken];
                [oAuthTwitterEngine setClearsCookies:YES];
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"twitterAuthData"];
            [defaults synchronize];
        }
        
	} else if (alertView.tag == FACEBOOK_ALERT_VIEW_TAG) {
		
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        [appDelegate closeSession];
    }
}

- (void)fbSessionStateChangedNotification:(NSNotification *)notification {
    
    FBSession *session = notification.object;
    
    switch (session.state) {
        case FBSessionStateOpen: {
            
            _facebookSwitch.on = YES;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"loginFacebook", @"")
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            _facebookSwitch.on = NO;
            [[NSUserDefaults standardUserDefaults] setBool:_facebookSwitch.on forKey:@"facebook"];
            break;
        default:
            break;
    }
}

@end
