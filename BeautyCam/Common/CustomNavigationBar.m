//
//  CustomNavigationBar.m
//  EveryDay
//
//  Created by LeeSiHyung on 11. 10. 23..
//  Copyright (c) 2011 MezzoMedia. All rights reserved.
//

#import "CustomNavigationBar.h"

static BOOL _bFirst;

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    
    
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *image = nil;
    //image = [UIImage imageNamed: @"bar.png"];
    //[image drawInRect:rect];
    
    NSLog(@"title : %@", self.topItem.title);
    
    if (self.topItem.title) {
        
        if ([self.topItem.title isEqualToString:@"사진 앨범"] || [self.topItem.title isEqualToString:@"Photo Albums"] ||
            [self.topItem.title isEqualToString:@"트위터"] || [self.topItem.title isEqualToString:@"Twitter"] ||
            [self.topItem.title isEqualToString:@"페이스북"] || [self.topItem.title isEqualToString:@"Facebook"] ||
            [self.topItem.title isEqualToString:@""]) {
           
            if (osVersion < 4.9) {
                image = [UIImage imageNamed: @"topbar.png"];
            } else {
                image = [UIImage imageNamed: @"bar.png"];
            }
        } else {
            image = [UIImage imageNamed: @"bar.png"];
        }
        
    } else {
        
        if (_bFirst == NO) {
            image = [UIImage imageNamed: @"bar.png"];
            _bFirst = YES;
        } else {

            if (osVersion < 4.9) {
                image = [UIImage imageNamed: @"topbar.png"];
            } else {
                image = [UIImage imageNamed: @"bar.png"];
            }   
        }
    }

    [image drawInRect:rect];
    
}
@end

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
- (void)drawRect:(CGRect)rect {
   
}
*/

- (void)dealloc {
	
    //[super dealloc];
}

@end
