//
//  MezzoAppViewController.m
//  EveryDay
//
//  Created by LeeSiHyung on 11. 12. 5..
//  Copyright (c) 2011 MezzoMedia. All rights reserved.
//

#import "MezzoAppViewController.h"

@implementation MezzoAppViewController

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
    
    self.view.backgroundColor = ColorFromRGB(0xf9f9f9);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        // ios5
        UIImage *image = [UIImage imageNamed: @"bar.png"];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    NSString *titleStr = NSLocalizedString(@"mezzomediaAppViewControllerTitle", @"");
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
    
    NSString *requestUrl = @"http://app.mezzomedia.co.kr";
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0f)];
    _webView.delegate = self;
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
	[_webView loadRequest:request];
	[self.view addSubview:_webView];
    
    _loadingView = [LoadingView loadingViewInView:_webView];
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
    
    if (_webView) {
         _webView.delegate = nil;
        //[_webView release];
        _webView = nil;
    }

    //[super dealloc];
}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark buttons

- (void)backButton:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark webDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (_loadingView) {
        [_loadingView removeView];
        _loadingView = nil;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (_loadingView) {
        [_loadingView removeView];
        _loadingView = nil;
    }
    
    if (_webView) {
        [_webView removeFromSuperview];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"pageErrors", @"")
                                                    message:NSLocalizedString(@"networkErrors", @"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"")
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release]; 
}

#pragma mark -
#pragma alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
