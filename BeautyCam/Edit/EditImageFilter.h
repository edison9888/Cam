//
//  EditImageFilter.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 4..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface EditImageFilter : NSObject {
    
}

- (UIImage*)saturationFilter:(UIImage*)originalImage value:(CGFloat)value;
- (UIImage*)contrastFilter:(UIImage*)originalImage value:(CGFloat)value;
- (UIImage*)brightnessFilter:(UIImage*)originalImage value:(CGFloat)value;
- (UIImage*)selectBlurFilter:(UIImage*)originalImage point:(CGPoint)value;
- (UIImage*)makeupFilter:(UIImage*)originalImage value:(CGFloat)value;
- (UIImage*)selectFilter:(NSInteger)tag originalImage:(UIImage*)originalImage;
- (UIImage*)backgroundImage:(NSInteger)tag originalImage:(UIImage*)originalImage originalImageOrientation:(UIImageOrientation)originalImageOrientation;
- (NSMutableArray*)makeFilterImages:(UIImage*)originalImage;
+ (UIImage *)NSmooth:(UIImage *)_img RECT:(CGRect)_rect;
@end
