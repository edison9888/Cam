//
//  HomeView.m
//  Beautie
//
//  Created by Moon Sik on 12. 1. 11..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView
@synthesize delegate;
/*
     tempBtn.frame = CGRectMake(11, 97, 167, 152);
 */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor =[UIColor clearColor];
        iFirst = 0;
        [self initUIButton];
    }
    return self;
}

-(void) startAnInit
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDidStopSelector:@selector(animationMoveStop)];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
    
        chooseBtn.frame = CGRectMake(11, 147, 167, 152);
        settingBtn.frame =CGRectMake(14, 298, 167, 127);
        aboutBtn.frame =CGRectMake(182, 356, 127, 97);
        take1Btn.frame =CGRectMake(182,150,123,179);
        take2Btn.frame =CGRectMake(151,244,101,78);
        
    } else {
    
        chooseBtn.frame = CGRectMake(11, 97, 167, 152);
        settingBtn.frame =CGRectMake(14, 248, 167, 127);
        aboutBtn.frame =CGRectMake(182, 306, 127, 97);
        take1Btn.frame =CGRectMake(182,100,123,179);
        take2Btn.frame =CGRectMake(151,194,101,78);
        
    }
    
    [UIView commitAnimations];
    
    /*
    [chooseBtn animationStart];
    [settingBtn animationStart];
    [aboutBtn animationStart];
    [take1Btn animationStart];
    [take2Btn animationStart];
    //*/
    
    //[NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void) onTimer
{
    
    UIImageView *leafView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_m2_1.png"]];
    
    // 낙엽의 속셩을 생성하고 시작위치와 끝 위치 그리고 크기와 속도 
    int startX = round(random() %320);
    int endX = round(random() %320);
    
    double scale =1/round(random() %100)+ 1.0;
    double speed =1/round(random() %100)+ 1.0;
    
    leafView.frame = CGRectMake(startX, -100.0, 25.0 * scale,25.0 *scale);
    leafView.alpha = 0.25;
    [self addSubview:leafView];
    [UIView beginAnimations:nil context:(__bridge void*)leafView];
    [UIView setAnimationDuration:5 * speed];
    leafView.frame = CGRectMake(endX, 500.0, 25.0 * scale,25.0 *scale);
    [UIView setAnimationDidStopSelector:@selector(animationDidTimerStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    //[leafView release];
}

- (void)animationDidTimerStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    UIImageView *leafView = (__bridge UIImageView*)context;
    [leafView removeFromSuperview];
}

-(void) initUIButton
{
    if (chooseBtn == nil) {
        chooseBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)]; //CGRectMake(11, 97, 167, 152);CGRectMake(208, 58, 10, 10)
        chooseBtn.reSetSize = YES;
        chooseBtn.backgroundColor = [UIColor clearColor];
        chooseBtn.tag= CHOOSE_A_PICTURE_BTN_TAG;
        [chooseBtn addTarget:self action:@selector(goButton:) forControlEvents:UIControlEventTouchUpInside];
       // [chooseBtn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchDown];
        [chooseBtn setImage:[UIImage imageNamed:@"main_m1.png"] forState:UIControlStateNormal];
        [self addSubview:chooseBtn];
    }
    if (settingBtn == nil) {
        settingBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(0, 480, 1, 1)];//CGRectMake(14, 248, 167, 127);
        settingBtn.reSetSize = YES;
        settingBtn.backgroundColor = [UIColor clearColor];
        settingBtn.tag= SETTING_PICTURE_BTN_TAG;
        [settingBtn addTarget:self action:@selector(goButton:) forControlEvents:UIControlEventTouchUpInside];
       // [settingBtn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchDown];
        [settingBtn setImage:[UIImage imageNamed:@"main_m3.png"] forState:UIControlStateNormal];
        [self addSubview:settingBtn];
    }
    if (aboutBtn == nil) {
        aboutBtn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(320, 480, 1, 1)];//CGRectMake(182, 306, 127, 97);
        aboutBtn.reSetSize = YES;
        aboutBtn.backgroundColor = [UIColor clearColor];
        aboutBtn.tag= ABOUT_PICTURE_BTN_TAG;
        [aboutBtn addTarget:self action:@selector(goButton:) forControlEvents:UIControlEventTouchUpInside];
     //   [aboutBtn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchDown];
        [aboutBtn setImage:[UIImage imageNamed:@"main_m4.png"] forState:UIControlStateNormal];
        [self addSubview:aboutBtn];
    }
    if (take1Btn == nil) {
        take1Btn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(320, 0, 1, 1)];//CGRectMake(182,100,123,179);
        take1Btn.reSetSize = YES;
        take1Btn.backgroundColor = [UIColor clearColor];
        take1Btn.tag= TAKE_PICTURE_BTN_TAG;
        [take1Btn addTarget:self action:@selector(goButton:) forControlEvents:UIControlEventTouchUpInside];
     //   [take1Btn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchDown];
        [take1Btn setImage:[UIImage imageNamed:@"main_m2_2.png"] forState:UIControlStateNormal];
        [self addSubview:take1Btn];
    }
    if (take2Btn == nil) {
        take2Btn = [[MAnimationsButton alloc]initWithFrame:CGRectMake(320, 0, 1, 1)];//CGRectMake(151,194,101,78);
        take2Btn.reSetSize = YES;
        take2Btn.backgroundColor = [UIColor clearColor];
        take2Btn.tag= TAKE_PICTURE_BTN_TAG;
        [take2Btn addTarget:self action:@selector(goButton:) forControlEvents:UIControlEventTouchUpInside];
       // [take2Btn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchDown];
        [take2Btn setImage:[UIImage imageNamed:@"main_m2_1.png"] forState:UIControlStateNormal];
        [self addSubview:take2Btn];
    }
    [self performSelector:@selector(startAnInit) withObject:nil afterDelay:0.2f];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    UIButton *tempDownBtn = (__bridge UIButton*)context;
    NSLog(@"Disabled");
    if (bAnimation) {
        if (tempDownBtn) {
            if (lastRadian > 0) {
                 lastRadian = -15;
            }else{
                lastRadian = 15;   
            }
            [UIView beginAnimations:nil context:(__bridge void*)tempDownBtn];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            tempDownBtn.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
            [UIView commitAnimations];
        }
    }else{
        lastRadian = 0;
        tempDownBtn.transform = CGAffineTransformMakeRotation(degreesToRadians(lastRadian));
    }
}

- (IBAction) goButton:(id)sender
{
    MAnimationsButton * tempDownBtn = (MAnimationsButton *)sender;
    
    if (tempDownBtn.tag == TAKE_PICTURE_BTN_TAG) {
        
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                                message:NSLocalizedString(@"notCamera", @"") 
                                                               delegate:nil 
                                                      cancelButtonTitle:NSLocalizedString(@"ok", @"") 
                                                      otherButtonTitles:nil];
            [alertView show];

            return;
        }
    }
    
    if (tempDownBtn) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationDidStopSelector:@selector(animationMoveStop)];
        if (tempDownBtn == take1Btn ||  tempDownBtn == take2Btn ) {
            take2Btn.hidden = YES;
            [take1Btn animationStart];
             take1Btn.frame = CGRectMake( 250, 58, 10, 10);
        }else{
            [tempDownBtn animationStart];
            tempDownBtn.frame = CGRectMake( 250, 58, 10, 10);
        }
        [UIView commitAnimations];
    }
    if (delegate) {
        [delegate onHomeButtonClick:tempDownBtn.tag];
    }
}

-(void)animationMoveStop
{
    [chooseBtn animationStop];
    [settingBtn animationStop];
    [aboutBtn animationStop];
    [take1Btn animationStop];
    [take2Btn animationStop];
     take2Btn.hidden = NO;
    if (iFirst == 0) {
        iFirst =1;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05f];
        [UIView setAnimationDidStopSelector:@selector(animationMoveStop)];
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
            
            chooseBtn.frame = CGRectMake(11, 147, 167, 152);
            settingBtn.frame =CGRectMake(14, 298, 167, 127);
            aboutBtn.frame =CGRectMake(182, 356, 127, 97);
            take1Btn.frame =CGRectMake(182,150,123,179);
            take2Btn.frame =CGRectMake(151,244,101,78);
            
        } else {
            
            chooseBtn.frame = CGRectMake(11, 97, 167, 152);
            settingBtn.frame =CGRectMake(14, 248, 167, 127);
            aboutBtn.frame =CGRectMake(182, 306, 127, 97);
            take1Btn.frame =CGRectMake(182,100,123,179);
            take2Btn.frame =CGRectMake(151,194,101,78);
            
        }
        [UIView commitAnimations];
    }else if(iFirst == 1){
        iFirst =2;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05f];
        [UIView setAnimationDidStopSelector:@selector(animationMoveStop)];
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
            
            chooseBtn.frame = CGRectMake(11, 147, 167, 152);
            settingBtn.frame =CGRectMake(14, 298, 167, 127);
            aboutBtn.frame =CGRectMake(182, 356, 127, 97);
            take1Btn.frame =CGRectMake(182,150,123,179);
            take2Btn.frame =CGRectMake(151,244,101,78);
            
        } else {
            
            chooseBtn.frame = CGRectMake(11, 97, 167, 152);
            settingBtn.frame =CGRectMake(14, 248, 167, 127);
            aboutBtn.frame =CGRectMake(182, 306, 127, 97);
            take1Btn.frame =CGRectMake(182,100,123,179);
            take2Btn.frame =CGRectMake(151,194,101,78);
            
        }
        [UIView commitAnimations];
    }
    /*
    chooseBtn.frame = CGRectMake(11, 97, 167, 152);
    settingBtn.frame =CGRectMake(14, 248, 167, 127); 
    aboutBtn.frame =CGRectMake(182, 306, 127, 97);
    take1Btn.frame =CGRectMake(182,100,123,179);
    take2Btn.frame =CGRectMake(151,194,101,78);
    */
}
- (void)dealloc
{
    if (chooseBtn) {
        [chooseBtn animationStop];
        //[chooseBtn release];
        chooseBtn = nil;
    }
    if (settingBtn) {
        [settingBtn animationStop];
        //[settingBtn release];
        settingBtn = nil;
    }
    if (take1Btn) {
        [take1Btn animationStop];
        //[take1Btn release];
        take1Btn = nil;
    }
    if (take2Btn) {
        [take2Btn animationStop];
        //[take2Btn release];
        take2Btn = nil;
    }
    if (aboutBtn) {
        [aboutBtn animationStop];
        //[aboutBtn release];
        aboutBtn = nil;
    }

   
}
@end
