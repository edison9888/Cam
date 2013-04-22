//
//  SocialTextViewController.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 5. 9..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialTextViewController.h"
#import <QuartzCore/QuartzCore.h>

#define TEXTVIEW_MAX_LENGTH 90

@implementation SocialTextViewController

@synthesize delegate = _delegate;
@synthesize socialType = _socialType;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        // ios5
        UIImage *image = [UIImage imageNamed: @"topbar.png"];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    NSString *titleStr = nil;
    if (_socialType == FACEBOOK) {
        titleStr = NSLocalizedString(@"facebook", @"");
    } else if (_socialType == TWEET) {
        titleStr = NSLocalizedString(@"twitter", @"");
    }
    CGFloat fontSize = 17.0f;
    
    UIFont *titleFont = [Util getFont:YES fontSize:fontSize];
    CGSize titleFontSize = [titleStr sizeWithFont:titleFont];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleFontSize.width, titleFontSize.height)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleStr;
    titleLabel.font = titleFont;
    self.navigationItem.titleView = (UIView*)titleLabel;
    
    UIImage *backButtonImage = [UIImage imageNamed:NSLocalizedString(@"closeBtn", @"")];
    UIImage *backButtonOnImage = [UIImage imageNamed:NSLocalizedString(@"closeBtnOn", @"")];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)]; 
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton setImage:backButtonOnImage forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem; 
    //[leftBarButtonItem release];
    //[backButton release];
    
    UIImage *sendButtonImage = [UIImage imageNamed:NSLocalizedString(@"sendBtn", @"")];
    UIImage *sendButtonOnImage = [UIImage imageNamed:NSLocalizedString(@"sendBtnOn", @"")];
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sendButtonImage.size.width, sendButtonImage.size.height)]; 
    [sendButton setImage:sendButtonImage forState:UIControlStateNormal];
	[sendButton setImage:sendButtonOnImage forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem; 
    //[rightBarButtonItem release];
    //[cameraButton release];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 320.0f - 20.0f, 170.0f)];
    [_textView setBackgroundColor:[UIColor clearColor]];
    [_textView setFont:[UIFont systemFontOfSize:15.0f]];
    [_textView setTextColor:[UIColor grayColor]];
    //tweetTextView.contentInset = UIEdgeInsetsZero;
    //tweetTextView.showsHorizontalScrollIndicator = NO;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.scrollEnabled = YES;
    _textView.editable = YES;
    _textView.delegate = self;
    //tweetTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textView.layer.cornerRadius = 1;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [[UIColor grayColor] CGColor];
    //fbMessageTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_textView];
    
    NSString *byteString = [NSString stringWithFormat:@"%d", TEXTVIEW_MAX_LENGTH];
	UIFont *byteFont = [UIFont boldSystemFontOfSize:15];
	_textLengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(280.0f, 185.0f, 50.0f, 20.0f)];
	[_textLengthLabel setFont:byteFont];
	[_textLengthLabel setTextColor:[UIColor grayColor]];
	[_textLengthLabel setBackgroundColor:[UIColor clearColor]];
	[_textLengthLabel setText:byteString];
	[self.view addSubview:_textLengthLabel];
    
    [_textView becomeFirstResponder];
    
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[_textView resignFirstResponder];
}

#pragma mark -
#pragma mark public

-(NSInteger) displayTextLength:(NSString*)text {
	
	NSInteger textLength = [text length];
	NSInteger textLengthUTF8 = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"Counting Text Length : %d", textLength);
	NSInteger correntLength = (textLengthUTF8 - textLength)/2 + textLength;
	
	return correntLength;
}

#pragma mark -
#pragma mark buttons

- (void)backButton:(id)sender {
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)sendButton:(id)sender {

    NSString *text = NSLocalizedString(@"sendPhoto",@"");
    text = [text stringByAppendingFormat:@"\r\n%@", _textView.text];
    
    if (_socialType == FACEBOOK) {
        [self.delegate uploadToFacebook:text];
    } else if (_socialType == TWEET) {
        [self.delegate uploadToTwitter:text];
    }
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
    NSMutableString *beforeText = nil;
	
	beforeText = [NSString stringWithFormat:@"%@%@", textView.text, text];
	
	if (range.length == 0) {
		if ([text isEqualToString:@"\n"]) {
			[textView resignFirstResponder];
			return NO;
		}
	}
	
     NSInteger textLength = [self displayTextLength:beforeText];
     if (textLength > TEXTVIEW_MAX_LENGTH) {
         return NO;
     } 
     
     if (_textLengthLabel) {
         NSString *byteString = [NSString stringWithFormat:@"%d", TEXTVIEW_MAX_LENGTH - textLength];
         [_textLengthLabel setText:byteString];
     }
	
	return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
	
	// Get the new dimensions for the text view
	CGSize newSize = [_textView.text sizeWithFont:[UIFont systemFontOfSize:15.0f]  constrainedToSize:CGSizeMake(_textView.frame.size.width,9999) lineBreakMode:UILineBreakModeWordWrap];
	NSInteger newSizeHeight = newSize.height;
	
    // maxHeight = 50;
	NSInteger maxHeight = 110;
    
	// If the message is over 4 lines, let the text scroll and expansion stop
	_textView.scrollEnabled = (newSizeHeight > maxHeight) ? YES : NO;
}

@end
