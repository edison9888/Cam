//
//  SocialTextViewController.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 5. 9..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocialTextViewControllerDelegate <NSObject>
@required
- (void)cancelText;
- (void)uploadToFacebook:(NSString*)text;
- (void)uploadToTwitter:(NSString*)text;
@end

@interface SocialTextViewController : UIViewController <UITextViewDelegate> {
    
    __unsafe_unretained id <SocialTextViewControllerDelegate> _delegate;
    UITextView *_textView;
    UILabel *_textLengthLabel;
    SOCIALTYPE _socialType;
}

@property (nonatomic, assign) id <SocialTextViewControllerDelegate> delegate;
@property (nonatomic, assign) SOCIALTYPE socialType;

- (NSInteger)displayTextLength:(NSString*)text;

@end
