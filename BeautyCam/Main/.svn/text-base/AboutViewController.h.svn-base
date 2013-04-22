//
//  AboutViewController.h
//  NOpenCVProject
//
//  Created by Moon Sik on 12. 1. 12..
//  Copyright (c) 2012 inamass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ADBanner.h"
#import "GADBannerView.h"

@interface AboutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, ADBannerDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_aboutArray;
    
    // 광고
    ADBanner *_adBannerView;
    GADBannerView *_gadBannerView;
}

- (void)sendMail;

@end
