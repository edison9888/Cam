//
//  MezzoAppViewController.h
//  EveryDay
//
//  Created by LeeSiHyung on 11. 12. 5..
//  Copyright (c) 2011 MezzoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface MezzoAppViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    
    UIWebView *_webView;
    LoadingView *_loadingView;
}

@end
