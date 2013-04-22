  //
//  EditImageFilter.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 4..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditImageFilter.h"
#import "opencv2/opencv.hpp"

#define FILTER_COUNT 13

@implementation EditImageFilter

#pragma mark -
#pragma mark public

- (UIImage*)saturationFilter:(UIImage*)originalImage value:(CGFloat)value {
    
    
    //GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageSaturationFilter *stillImageFilter = [[GPUImageSaturationFilter alloc] init];
    
    [stillImageFilter setSaturation:value];
    //[stillImageSource addTarget:stillImageFilter];
    //[stillImageSource processImage];
    
    UIImage *filterImage = [stillImageFilter imageByFilteringImage:originalImage];//[stillImageFilter imageFromCurrentlyProcessedOutput];
    //[stillImageSource removeTarget:stillImageFilter];
    
    //[stillImageFilter release];
    //[stillImageSource release];
    
    return filterImage;
}

- (UIImage*)brightnessFilter:(UIImage*)originalImage value:(CGFloat)value {
    
    //GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageBrightnessFilter *stillImageFilter = [[GPUImageBrightnessFilter alloc] init];
    [stillImageFilter setBrightness:value];
    //[stillImageSource addTarget:stillImageFilter];
    //[stillImageSource processImage];
    
    UIImage *filterImage = [stillImageFilter imageByFilteringImage:originalImage];
    //[stillImageSource removeTarget:stillImageFilter];
    
    //[stillImageSource release];
    //[stillImageFilter release];
    
    return filterImage;
}

- (UIImage*)contrastFilter:(UIImage*)originalImage value:(CGFloat)value {
    
    //GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageContrastFilter *stillImageFilter = [[GPUImageContrastFilter alloc] init];
    [stillImageFilter setContrast:value];
    //[stillImageSource addTarget:stillImageFilter];
    //[stillImageSource processImage];
    
    UIImage *filterImage = [stillImageFilter imageByFilteringImage:originalImage];
    //[stillImageSource release];
    //[stillImageFilter release];
    
    return filterImage;
}

- (UIImage*)selectBlurFilter:(UIImage*)originalImage point:(CGPoint)value{
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageGaussianSelectiveBlurFilter *stillImageFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
    [stillImageFilter setExcludeCirclePoint:value];
    NSLog(@"point value : %@", NSStringFromCGPoint(value));
    //[stillImageFilter setExcludeCircleRadius:300/320];
    [stillImageSource addTarget:stillImageFilter];
    [stillImageSource processImage];
    
    UIImage *filterImage = [stillImageFilter imageFromCurrentlyProcessedOutput];
    //[stillImageSource release];
    //[stillImageFilter release];
    
    return filterImage;
}

- (UIImage*)makeupFilter:(UIImage*)originalImage value:(CGFloat)value {
    
    
    UIImage *filterImage = nil;
    
    GPUImagePicture *stillImageSource  = [[GPUImagePicture alloc] initWithImage:originalImage];

    GPUImageGaussianBlurFilter *gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    [gaussianBlurFilter setBlurSize:value];
    [stillImageSource addTarget:gaussianBlurFilter];
    [stillImageSource processImage];
    
    filterImage = [gaussianBlurFilter imageFromCurrentlyProcessedOutput];

    GPUImagePicture *filterImageSource = [[GPUImagePicture alloc] initWithImage:filterImage];
    GPUImageScreenBlendFilter *screenBlendFilter = [[GPUImageScreenBlendFilter alloc] init];
    [stillImageSource addTarget:screenBlendFilter];
    [filterImageSource addTarget:screenBlendFilter];
    [filterImageSource processImage];
    
    filterImage = [screenBlendFilter imageFromCurrentlyProcessedOutput];
    
    return filterImage;
}

- (NSMutableArray*)makeFilterImages:(UIImage*)originalImage {
    
    NSMutableArray *filterImages = [[NSMutableArray alloc] init];    
    for (NSInteger count = 0; count < FILTER_COUNT; count++) {
        
        NSString *filterImageName = [[NSString alloc] initWithFormat:@"default_image_%d", count + 1];
        UIImage *filterImage = [UIImage imageNamed:filterImageName]; 

        
        [filterImages addObject:filterImage];
    }
    
    /*
    UIImage *defaultImage = nil;
    if (originalImage == nil) {
        defaultImage = [UIImage imageNamed:@"default_image.png"]; 
    } else {
        defaultImage = originalImage;
    }
    
    NSMutableArray *filterImages = [[[NSMutableArray alloc] init] autorelease];
    
    GPUImagePicture *gpuImagePicture = [[GPUImagePicture alloc] initWithImage:defaultImage];
    UIImage *filterImage = nil;
    
    NSInteger filterCnt = 0;
    while (filterCnt < FILTER_COUNT) {
        
        if (filterCnt == 0) {
            
            filterImage = originalImage;
            
        } else if (filterCnt == 1) {
            
            GPUImageYellowFilter *filter = [[GPUImageYellowFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 2) {
            
            GPUImageBlueFilter *filter = [[GPUImageBlueFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 3) {
            
            GPUImageRedFilter *filter = [[GPUImageRedFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 4) {
            
            GPUImageGrayscaleFilter *filter = [[GPUImageGrayscaleFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 5) {
            
            GPUImageColorInvertFilter *filter = [[GPUImageColorInvertFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 6) {
            
            GPUImageSobelEdgeDetectionFilter *filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 7) {
            
            GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 8) {
            
            GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 9) {
            
            GPUImagePolarPixellateFilter *filter = [[GPUImagePolarPixellateFilter alloc] init];
            [filter setPixelSize:CGSizeMake(0.03, 0.03)];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 10) {
            
            GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
            [filter setFractionalWidthOfAPixel:0.02f];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 11) {
            
            GPUImageStretchDistortionFilter *filter = [[GPUImageStretchDistortionFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 12) {
            
            GPUImageBoxBlurFilter *filter = [[GPUImageBoxBlurFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } 
        
        [filterImages addObject:filterImage];
        filterCnt++;
    }
    [gpuImagePicture release];
    */
    
    return filterImages;
}

- (UIImage*)selectFilter:(NSInteger)tag originalImage:(UIImage*)originalImage {
    
    GPUImagePicture *gpuImagePicture = [[GPUImagePicture alloc] initWithImage:originalImage];
    UIImage *filterImage = nil;
    
    if (tag == 1) {
        
        filterImage = originalImage;
        
    } else if (tag == 2) {
        
        GPUImageYellowFilter *filter = [[GPUImageYellowFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 3) {
        
        GPUImageBlueFilter *filter = [[GPUImageBlueFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 4) {
        
        GPUImageRedFilter *filter = [[GPUImageRedFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 5) {
        
        GPUImageGrayscaleFilter *filter = [[GPUImageGrayscaleFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 6) {
        
        GPUImageExposureFilter *filter = [[GPUImageExposureFilter alloc] init];
        [filter setExposure:0.1];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 7) {
        
        GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
        [filter setSharpness:2.5];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    }else if (tag == 8) {
        
        GPUImageColorInvertFilter *filter = [[GPUImageColorInvertFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 9) {
        
        GPUImageSobelEdgeDetectionFilter *filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    } else if (tag == 10) {
        
        GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
    
    } else if (tag == 11) {
        
        GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
      
    } else if (tag == 12) {
        
        GPUImagePolarPixellateFilter *filter = [[GPUImagePolarPixellateFilter alloc] init];
        [filter setPixelSize:CGSizeMake(0.03, 0.03)];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
  
    } else if (tag == 13) {
        
        GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
        [filter setFractionalWidthOfAPixel:0.02f];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
 
    } else if (tag == 14) {
        
        GPUImageStretchDistortionFilter *filter = [[GPUImageStretchDistortionFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];
     
    } else if (tag == 15) {
        
        GPUImageBoxBlurFilter *filter = [[GPUImageBoxBlurFilter alloc] init];
        [gpuImagePicture addTarget:filter];
        [gpuImagePicture processImage];
        
        filterImage = [filter imageFromCurrentlyProcessedOutput];
        [gpuImagePicture removeTarget:filter];

    }  
    
    
    return filterImage;
}

- (UIImage*)backgroundImage:(NSInteger)tag originalImage:(UIImage*)originalImage originalImageOrientation:(UIImageOrientation)originalImageOrientation {
    
    NSString *imageFileName = nil;
    if (tag < 10) {
        imageFileName = [NSString stringWithFormat:@"back_effect_0%d.png", tag];
    } else {
        imageFileName = [NSString stringWithFormat:@"back_effect_%d.png", tag];
    }

    UIImage *backgroundImage = [UIImage imageNamed:imageFileName];
    if (originalImageOrientation == UIImageOrientationRight) {
        backgroundImage = [Util rotateImage:backgroundImage orientation:UIImageOrientationLeft];
    }
    backgroundImage = [Util resize:backgroundImage width:originalImage.size.width height:originalImage.size.height]; 
    
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width, originalImage.size.height));
    [originalImage drawAtPoint:CGPointMake(0, 0)];
    [backgroundImage drawAtPoint:CGPointMake(0, 0)];
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mergedImage;
}

// opencv
+ (IplImage*)CreateIplImageFromUIImage2:(UIImage*)image {
    
    if (image == nil) {
        return nil;
    }
	CGImageRef imageRef = image.CGImage;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	IplImage *iplimage = cvCreateImage(cvSize(image.size.width, image.size.height), IPL_DEPTH_8U, 4);
	CGContextRef contextRef = CGBitmapContextCreate(iplimage->imageData, iplimage->width, iplimage->height,
													iplimage->depth, iplimage->widthStep,
													colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
	CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
	CGContextRelease(contextRef);
	CGColorSpaceRelease(colorSpace);
	
	IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
	cvCvtColor(iplimage, ret, CV_RGBA2RGB);
	
	cvReleaseImage(&iplimage);
	
	return ret;
} 

+ (UIImage*)UIImageFromIplImage2:(IplImage*)image {
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
	CGImageRef imageRef = CGImageCreate(image->width, image->height,
										image->depth, image->depth * image->nChannels, image->widthStep,
										colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,
										provider, NULL, false, kCGRenderingIntentDefault);
	UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
	
    CGImageRelease(imageRef);
	CGDataProviderRelease(provider);
	CGColorSpaceRelease(colorSpace);
	
    return returnImage;
}

+ (UIImage *)NSmooth:(UIImage *)_img RECT:(CGRect)_rect {
    
    IplImage *src_img = [EditImageFilter CreateIplImageFromUIImage2:_img];
    cvSetImageROI(src_img, cvRect(_rect.origin.x, _rect.origin.y, _rect.size.width, _rect.size.height));
    
    IplImage *dst_img = cvCreateImage(cvGetSize(src_img),src_img->depth,src_img->nChannels);
    cvSmooth( src_img, dst_img, CV_BILATERAL, 10, 10 ,25.0, 5.0 );
    //cvSmooth (src_img, dst_img, CV_GAUSSIAN, 2, 2, 3, 3);
    cvCopy (dst_img, src_img);
    cvResetImageROI (src_img);
    UIImage*  returnImag = [EditImageFilter UIImageFromIplImage2:src_img];
    cvReleaseImage (&dst_img);
    cvReleaseImage (&src_img);
    
    return returnImag;
}

@end
