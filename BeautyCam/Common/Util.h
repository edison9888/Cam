//
//  Util.h
//  EveryDay
//
//  Created by LeeSiHyung on 11. 10. 28..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject {
    
}

// Get DeviceUniqueID
+ (NSString*)getUniqueID;
+ (UIImage*)imageFromResource:(NSString*)name;
+ (UIFont*)getFont:(BOOL)bBold fontSize:(CGFloat)fontSize;
+ (NSString*)titleForSize:(NSString*)folderTitle imageCnt:(NSInteger)imageCnt bDetailTitle:(BOOL)bDetailTitle;
+ (UIImage*)resize:(UIImage*)originalImage width:(int)width height:(int)height;
+ (UIImage*)scaleAndRotateImage:(UIImage *)image maxWidth:(NSInteger)maxWidth orientation:(UIImageOrientation)orientation;
+ (UIImage*)rotateImage:(UIImage*)image orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end

