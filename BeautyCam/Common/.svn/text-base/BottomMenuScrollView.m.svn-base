//
//  BottomMenuScrollView.m
//  NOpenCVProject
//
//  Created by LeeSiHyung on 12. 2. 23..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import "BottomMenuScrollView.h"
#import "MAnimationsButton.h"

#define BUTTON_COUNT 6
#define BG_IMAGEVIEW_TAG 9000

@implementation BottomMenuScrollView 

@synthesize customDelegate = _customDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delaysContentTouches = YES;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        UIImage *backgroundColorImage = [UIImage imageNamed:@"bar_back.png"];
        backgroundColorImage = [backgroundColorImage stretchableImageWithLeftCapWidth:backgroundColorImage.size.width 
                                                                         topCapHeight:backgroundColorImage.size.height];
        self.backgroundColor = [UIColor colorWithPatternImage:backgroundColorImage];
        
        [self initBgImage];
        [self initButtons];
    }
    return self;
}

- (void)initBgImage {
    
    _buttonBgArray = [[NSMutableArray alloc] initWithCapacity:BUTTON_COUNT];
    
    for (NSInteger i = 0; i < BUTTON_COUNT; i++) {
        UIImage *bgImage = [UIImage imageNamed:@"effect_m1_body_off.png"];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
        bgImageView.frame = CGRectMake(bgImage.size.width * i, 0, bgImage.size.width, bgImage.size.height);
        [self addSubview:bgImageView];
        [_buttonBgArray addObject:bgImageView];
    }
}
    
- (void)initButtons {
    
    _buttonArray = [[NSMutableArray alloc] init];
    
    UIImage *bgImage = [UIImage imageNamed:@"effect_m1_body_off.png"];
    
    UIImage *mainFirstNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomFirstMenuOffImage",@"")];
    MAnimationsButton *mainFirstButton = [[MAnimationsButton alloc]initWithFrame:
                                          CGRectMake((bgImage.size.width / 2) - (mainFirstNormalImage.size.width / 2),
                                                     (bgImage.size.height / 2) - (mainFirstNormalImage.size.height / 2),
                                                     mainFirstNormalImage.size.width,
                                                     mainFirstNormalImage.size.height)];
    [mainFirstButton addTarget:self action:@selector(mainFirstButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainFirstButton setImage:mainFirstNormalImage forState:UIControlStateNormal];
    [mainFirstButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFirstMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainFirstButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFirstMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainFirstButton];
    [self addSubview:mainFirstButton];
    
    UIImage *mainSecondNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomSecondMenuOffImage",@"")];
    MAnimationsButton *mainSecondButton = [[MAnimationsButton alloc]initWithFrame:
                                           CGRectMake((bgImage.size.width / 2) - (mainSecondNormalImage.size.width / 2) + bgImage.size.width,
                                                      (bgImage.size.height / 2) - (mainSecondNormalImage.size.height / 2),
                                                      mainSecondNormalImage.size.width,
                                                      mainSecondNormalImage.size.height)];
    [mainSecondButton addTarget:self action:@selector(mainSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainSecondButton setImage:mainSecondNormalImage forState:UIControlStateNormal];
    [mainSecondButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomSecondMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainSecondButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomSecondMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainSecondButton];
    [self addSubview:mainSecondButton];
    
    UIImage *mainThirdNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomThirdMenuOffImage",@"")];
    MAnimationsButton *mainThirdButton = [[MAnimationsButton alloc]initWithFrame:
                                          CGRectMake((bgImage.size.width / 2) - (mainThirdNormalImage.size.width / 2) + (bgImage.size.width * 2),
                                                     (bgImage.size.height / 2) - (mainThirdNormalImage.size.height / 2),
                                                     mainThirdNormalImage.size.width,
                                                     mainThirdNormalImage.size.height)];
    [mainThirdButton addTarget:self action:@selector(mainThirdButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainThirdButton setImage:mainThirdNormalImage forState:UIControlStateNormal];
    [mainThirdButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomThirdMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainThirdButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomThirdMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainThirdButton];
    [self addSubview:mainThirdButton];
    
    UIImage *mainFourthNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomFiveMenuOffImage",@"")];
    MAnimationsButton *mainFourthButton = [[MAnimationsButton alloc]initWithFrame:
                                           CGRectMake((bgImage.size.width / 2) - (mainFourthNormalImage.size.width / 2) + (bgImage.size.width * 3),
                                                      (bgImage.size.height / 2) - (mainFourthNormalImage.size.height / 2),
                                                      mainFourthNormalImage.size.width,
                                                      mainFourthNormalImage.size.height)];
    [mainFourthButton addTarget:self action:@selector(mainFourthButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainFourthButton setImage:mainFourthNormalImage forState:UIControlStateNormal];
    [mainFourthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFiveMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainFourthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFiveMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainFourthButton];
    [self addSubview:mainFourthButton];
    
    
    UIImage *mainFifthNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomFourthMenuOffImage",@"")];
    MAnimationsButton *mainFifthButton = [[MAnimationsButton alloc]initWithFrame:
                                           CGRectMake((bgImage.size.width / 2) - (mainFifthNormalImage.size.width / 2) + (bgImage.size.width * 4),
                                                      (bgImage.size.height / 2) - (mainFifthNormalImage.size.height / 2),
                                                      mainFifthNormalImage.size.width,
                                                      mainFifthNormalImage.size.height)];
    [mainFifthButton addTarget:self action:@selector(mainFifthButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainFifthButton setImage:mainFifthNormalImage forState:UIControlStateNormal];
    [mainFifthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFourthMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainFifthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomFourthMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainFifthButton];
    [self addSubview:mainFifthButton];
    
    UIImage *mainSixthNormalImage = [UIImage imageNamed:NSLocalizedString(@"bottomSixMenuOffImage",@"")];
    MAnimationsButton *mainSixthButton = [[MAnimationsButton alloc]initWithFrame:
                                          CGRectMake((bgImage.size.width / 2) - (mainSixthNormalImage.size.width / 2) + (bgImage.size.width * 5),
                                                     (bgImage.size.height / 2) - (mainSixthNormalImage.size.height / 2),
                                                     mainSixthNormalImage.size.width,
                                                     mainSixthNormalImage.size.height)];
    [mainSixthButton addTarget:self action:@selector(mainSixthButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainSixthButton setImage:mainSixthNormalImage forState:UIControlStateNormal];
    [mainSixthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomSixMenuImage",@"")] forState:UIControlStateHighlighted];
    [mainSixthButton setImage:[UIImage imageNamed:NSLocalizedString(@"bottomSixMenuImage",@"")] forState:UIControlStateSelected];
    [_buttonArray addObject:mainSixthButton];
    [self addSubview:mainSixthButton];
    
    self.contentSize = CGSizeMake(bgImage.size.width * [_buttonArray count], mainFirstButton.frame.size.height); 
}

- (void)rotateButtons:(UIDeviceOrientation)willOrientation {
    
    for (MAnimationsButton *button in _buttonArray) {
        [button doRotate:willOrientation];
    }
}

- (void)AllDeselectButtons {

    for (UIImageView *imageView in _buttonBgArray) {
        imageView.image = [UIImage imageNamed:@"effect_m1_body_off.png"];
    }
    
    for (MAnimationsButton *button in _buttonArray) {
        button.selected = NO;
    }
}

- (void)selectButton:(NSInteger)order {
    
    if (selectedOrder == order) {
        
        UIButton *button = [_buttonArray objectAtIndex:order];
        UIImageView *bgImageView = [_buttonBgArray objectAtIndex:order];
        
        if (button.selected == YES) {
            bgImageView.image = [UIImage imageNamed:@"effect_m1_body_off.png"];
        } else {
            bgImageView.image = [UIImage imageNamed:@"effect_m1_body.png"];
        }
        button.selected = !button.selected;
        
    } else {
        
        selectedOrder = order;
        
        if (order >= 0) {
            NSInteger checkOrder = 0;
            for (UIImageView *bgImageView in _buttonBgArray) {
                if (order == checkOrder) {
                    bgImageView.image = [UIImage imageNamed:@"effect_m1_body.png"];
                }else {
                    bgImageView.image = [UIImage imageNamed:@"effect_m1_body_off.png"];
                }
                checkOrder++;
            }
            
            
            checkOrder = 0;
            for (UIButton *button in _buttonArray) {
                if (order == checkOrder) {
                    button.selected = YES;
                }else {
                    button.selected = NO;
                }
                checkOrder++;
            }
        }
    }
}

#pragma mark -
#pragma mark buttons

- (void)mainFirstButton:(id)sender {
    
    [self selectButton:0];
    if ([self customDelegate]) {
        
    }
    [[self customDelegate] BottomMenuFirstButton];
}

- (void)mainSecondButton:(id)sender {
    
   [self selectButton:1];
    
    // ([[self customDelegate] respondsToSelector:@selector(BottomMenuSecondButton)]) {
        [[self customDelegate] BottomMenuSecondButton];
   // }
}


- (void)mainThirdButton:(id)sender {
    
    [self selectButton:2];
    
   // if ([[self customDelegate] respondsToSelector:@selector(BottomMenuThirdButton)]) {
        [[self customDelegate] BottomMenuThirdButton];
//}
}


- (void)mainFourthButton:(id)sender {
    
    [self selectButton:3];
    
    //if ([[self customDelegate] respondsToSelector:@selector(BottomMenuFourthButton)]) {
        [[self customDelegate] BottomMenuFourthButton];
    //}
}


- (void)mainFifthButton:(id)sender {
    
    [self selectButton:4];
    
    //if ([[self customDelegate] respondsToSelector:@selector(BottomMenuFifthButton)]) {
        [[self customDelegate] BottomMenuFifthButton];
    //}
}


- (void)mainSixthButton:(id)sender {
    
    //if ([[self customDelegate] respondsToSelector:@selector(BottomMenuSixthButton)]) {
        [[self customDelegate] BottomMenuSixthButton];
    //}
}

    
@end
