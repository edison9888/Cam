//
//  SettingViewController.h
//  NOpenCVProject
//
//  Created by Moon Sik on 12. 1. 12..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
//#import "Facebook.h"
#import "SA_OAuthTwitterController.h" 
#import "ADBanner.h"
#import "GADBannerView.h"

@interface SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CameraViewControllerDelegate, SA_OAuthTwitterControllerDelegate, UIAlertViewDelegate,
ADBannerDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_settingArray;
    
    UISwitch *_facebookSwitch;
    UISwitch *_twitterSwitch;
    
    // 광고
    ADBanner *_adBannerView;
    GADBannerView *_gadBannerView;
}

@end
