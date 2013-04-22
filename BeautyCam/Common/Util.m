//
//  Util.m
//  EveryDay
//
//  Created by LeeSiHyung on 11. 10. 28..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "MacAddress.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Util

#define DETAIL_IMAGEVIEW_WIDTH  320.0f
#define DETAIL_IMAGEVIEW_HEIGHT 570.0f

#define EUCKR_ENCODING           (0x80000000 + 0x0422)
#define DETAIL_HANGULE_MAX       12
#define DETAIL_ENGLISH_MAX       20

#define EDIT_HANGULE_MAX         10
#define EDIT_ENGLISH_MAX         16

static inline double radians (double degrees) {return degrees * M_PI/180;}

+ (NSString*)getUniqueID {
    
    NSString *uniqueID = nil;
    
    char* macAddressString= (char*)malloc(18);
    NSString *macAddress= [[NSString alloc] initWithCString:getMacAddress(macAddressString,"en0")
                                                    encoding:NSMacOSRomanStringEncoding];
    //NSLog(@"macAddress : %@ ", macAddress);
    
    const char *cStr = [macAddress UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result);
    uniqueID = [NSString stringWithFormat:
                      @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    //NSLog(@"deviceUniqueID : %@", deviceUniqueID);
    
    return uniqueID;
}

+ (UIImage*)imageFromResource:(NSString*)name {
    
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
}

+ (UIImage *)resize:(UIImage *)originalImage width:(int)width height:(int)height {
    
    UIImage* sourceImage = originalImage; 
    CGFloat targetWidth = width;
    CGFloat targetHeight = height;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    const size_t bitPerPixel = 32;
    const size_t bytesPerRow = (bitPerPixel * width)/8;
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), bytesPerRow, colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), bytesPerRow, colorSpaceInfo, bitmapInfo);
    }       
    
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

+ (UIFont*)getFont:(BOOL)bBold fontSize:(CGFloat)fontSize {
    
    UIFont *font = nil;
    if (bBold) {
        font = [UIFont fontWithName:@"NanumGothicBold" size:fontSize];
    } else {
        font = [UIFont fontWithName:@"NanumGothic" size:fontSize];
    }
    return font;
}

+ (UIImage*)scaleAndRotateImage:(UIImage *)image maxWidth:(NSInteger)maxWidth orientation:(UIImageOrientation)orientation {
    
    int kMaxResolution = maxWidth;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = orientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    /*
     CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
     UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     */
    
    CGImageRef tmp = CGImageCreateWithImageInRect(imgRef, CGRectMake(0, 0, width, height));
    
    //pull the image from our cropped context
    UIImage *imageCopy = [UIImage imageWithCGImage:tmp];//UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(tmp);
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    
    return imageCopy;
}

static inline CGSize swapWidthAndHeight(CGSize size) {
    CGFloat  swap = size.width;
    
    size.width  = size.height;
    size.height = swap;
    
    return size;
}

+ (UIImage*)rotateImage:(UIImage*)image orientation:(UIImageOrientation)orientation {
    
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGImageRef         imag = image.CGImage;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    rect.size.width  = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orientation)
    {
        case UIImageOrientationUp:
            // would get you an exact copy of the original
           // assert(false);
            return nil;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

+ (NSString*)titleForSize:(NSString*)folderTitle imageCnt:(NSInteger)imageCnt bDetailTitle:(BOOL)bDetailTitle {
    
    NSString *returnTitle = nil;
    
    // 첫글자가 영어인지 체크
    NSString *firstStr = [folderTitle substringWithRange:NSMakeRange(0, 1)];
    NSUInteger firstCnt = [firstStr lengthOfBytesUsingEncoding:EUCKR_ENCODING];    
    
    // 갯수.. 갯수에 따라 타이틀이 유동적이어야 된다.
    NSString *countStr = [[NSString alloc] initWithFormat:@"(%d)", imageCnt];
    NSUInteger countCnt = [countStr lengthOfBytesUsingEncoding:EUCKR_ENCODING];   
    //[countStr release];
    
    //NSUInteger titleLength = [folderTitle lengthOfBytesUsingEncoding:EUCKR_ENCODING];
    NSUInteger maxLength = 0;
    if (firstCnt == 1) {
        // 한글이외
        if (bDetailTitle) {
            maxLength = DETAIL_ENGLISH_MAX;
        } else {
            maxLength = EDIT_ENGLISH_MAX;
        }
        
    } else {
        // 한글
        if (bDetailTitle) {
            maxLength = DETAIL_HANGULE_MAX;
        } else {
            maxLength = EDIT_HANGULE_MAX;
        }
    }
    if ([folderTitle length] > maxLength) {
        // bytes
        maxLength -= countCnt;
        returnTitle = [folderTitle substringToIndex:maxLength];
        returnTitle = [NSString stringWithFormat:@"%@...(%d)", returnTitle, imageCnt];
    } else {
        returnTitle = [NSString stringWithFormat:@"%@(%d)", folderTitle, imageCnt];
    }
    return returnTitle;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
