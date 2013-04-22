//
//  AboutViewController.m
//  NOpenCVProject
//
//  Created by Moon Sik on 12. 1. 12..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import "AboutViewController.h"
#import "MezzoAppViewController.h"

#define VERSION_LABEL_TAG 9000

@implementation AboutViewController

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
    
    NSString *titleStr = @"About";
    CGFloat fontSize = 19.0f;
    
    UIFont *titleFont = [Util getFont:YES fontSize:fontSize];
    CGSize titleFontSize = [titleStr sizeWithFont:titleFont];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleFontSize.width, titleFontSize.height)];
    titleLabel.textColor = ColorFromRGB(0x383838);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleStr;
    titleLabel.font = titleFont;
    self.navigationItem.titleView = (UIView*)titleLabel;
    
    UIImage *backButtonImage = [UIImage imageNamed:NSLocalizedString(@"backBtn", @"")];
    UIImage *backButtonOnImage = [UIImage imageNamed:NSLocalizedString(@"backBtnOn", @"")];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)]; 
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton setImage:backButtonOnImage forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem; 
    
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
                                                                   self.view.frame.size.height - 48.0f - 44.0f,
                                                                   self.view.frame.size.width,
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
    
    _aboutArray = [[NSMutableArray alloc] init];
    
    NSArray *sectionOneArray = [NSArray arrayWithObjects:NSLocalizedString(@"mezzomediaApps", @"mezzomediaApps"),
                                NSLocalizedString(@"advertising", @"advertising"),
                                NSLocalizedString(@"version", @"version"), nil];
    NSDictionary *sectionOneDict = [NSDictionary dictionaryWithObject:sectionOneArray forKey:@"section"];
    
    [_aboutArray addObject:sectionOneDict];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    
    //[super dealloc];
    
    if (_adBannerView) {
        _adBannerView.delegate = nil;
        _adBannerView = nil;
    }
    
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
#pragma mark public functions

- (void)sendMail {
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.title = NSLocalizedString(@"inquiries",@"");
    mailViewController.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail])  {
        
        //받는 사람
        [mailViewController setToRecipients:[NSArray arrayWithObjects:@"sp@mezzomedia.co.kr", nil]];
        //제목
        [mailViewController setSubject:NSLocalizedString(@"advertising",@"")];
        //내용
        [mailViewController setMessageBody:NSLocalizedString(@"advertisingMail",@"") isHTML:NO];
        // Modal의 형태로 창을 띄움.
        [self presentModalViewController:mailViewController animated:YES];
        
        UIImage *image = [UIImage imageNamed: @"topbar.png"];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
            // ios5
            [mailViewController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            
        } else {
            UIImageView *naviBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 42.0f)];
            naviBarImageView.image = image;
            naviBarImageView.contentMode = UIViewContentModeCenter;
            [[[mailViewController viewControllers] lastObject] navigationItem].titleView = naviBarImageView;
            [[mailViewController navigationBar] sendSubviewToBack:naviBarImageView];
           
        }
    }
    
}

#pragma mark -
#pragma mark tableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_aboutArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [_aboutArray objectAtIndex:section];
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
    
    NSDictionary *aboutDict = [_aboutArray objectAtIndex:indexPath.section];
    NSArray *sectionArray = [aboutDict objectForKey:@"section"];
    
    cell.textLabel.font = [Util getFont:NO fontSize:16.0f];
    cell.textLabel.text = [sectionArray objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [accessoryButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
            accessoryButton.frame = CGRectMake(0, 0, 15, 15);
            cell.accessoryView = accessoryButton;
            
        } else if (indexPath.row == 1) {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
       
            UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [accessoryButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
            accessoryButton.frame = CGRectMake(0, 0, 15, 15);
            cell.accessoryView = accessoryButton;
           
        } else if (indexPath.row == 2) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *versionLabel = (UILabel*)[cell viewWithTag:VERSION_LABEL_TAG];
            if (!versionLabel) {
                NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
                CGFloat fontSize = 16.0f;
                
                UIFont *versionFont = [Util getFont:NO fontSize:fontSize];
                CGSize versionSize = [version sizeWithFont:versionFont];
                versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - versionSize.width - 30.0f,
                                                                         10.0f,
                                                                         versionSize.width, 
                                                                         versionSize.height)];
                versionLabel.tag = VERSION_LABEL_TAG;
                versionLabel.backgroundColor = [UIColor clearColor];
                versionLabel.font = versionFont;
                versionLabel.text = version;
                [cell addSubview:versionLabel];
               
            } 
        }
    }
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            MezzoAppViewController *mezzoAppViewController = [[MezzoAppViewController alloc] init];
            [self.navigationController pushViewController:mezzoAppViewController animated:YES];
           
            
        } else if (indexPath.row == 1) {
            
            [self sendMail];
            
        }
    }
    
    [_tableView reloadData];
}

#pragma mark -
#pragma mark buttons

- (void)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mar mail Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    switch (result) {
            
        case MFMailComposeResultCancelled:
            break;
            
        case MFMailComposeResultSaved:
            break;
            
        case MFMailComposeResultSent:
            
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"sendMail", @"") 
                                       delegate:nil 
                              cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                              otherButtonTitles:nil] show];
            
            break;
            
        case MFMailComposeResultFailed:
            
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"failMail", @"") 
                                       delegate:nil 
                              cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                              otherButtonTitles:nil] show];
            
            break;
            
    };
    [controller dismissModalViewControllerAnimated:YES];
}


@end
