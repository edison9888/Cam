//
//  ViewController.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"
#import "ADBanner.h"
#import "GADBannerView.h"
#import "CameraViewController.h"

@interface ViewController : UIViewController <HomeViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ADBannerDelegate,
CameraViewControllerDelegate> {
    
    HomeView *_homeView;
    // 광고
    ADBanner *_adBannerView;
    GADBannerView *_gadBannerView;
}

@end
