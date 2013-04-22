//
//  CustomSlider.h
//  Measures
//
//  Created by Michael Neuwert on 4/26/11.
//  Copyright 2011 Neuwert Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSlider : UISlider {
    UIImageView *valuePopupImageView; 
    UILabel *valueLabel;
}

@property (nonatomic, readonly) CGRect thumbRect;

- (void)setPopupValue:(float)value;

@end
