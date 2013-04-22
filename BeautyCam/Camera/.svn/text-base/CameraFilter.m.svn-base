//
//  CameraFilter.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 4..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraFilter.h"

#define FILTER_COUNT 13

@implementation CameraFilter

@synthesize delgate = _delegate;

#pragma mark -
#pragma mark public

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
    
    GPUImagePicture *gpuImagePicture = [[GPUImagePicture alloc] initWithImage:defaultImage];
    UIImage *filterImage = nil;
    
    NSInteger filterCnt = 0;
    while (filterCnt < FILTER_COUNT) {
        
        if (filterCnt == 0) {
            
            filterImage = defaultImage;
            
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
            
            GPUImageExposureFilter *filter = [[GPUImageExposureFilter alloc] init];
            [filter setExposure:0.1];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 6) {
            
            GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
            [filter setSharpness:2.5];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        }else if (filterCnt == 7) {
            
            GPUImageColorInvertFilter *filter = [[GPUImageColorInvertFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 8) {
            
            GPUImageSobelEdgeDetectionFilter *filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 9) {
            
            GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 10) {
            
            GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 11) {
            
            GPUImagePolarPixellateFilter *filter = [[GPUImagePolarPixellateFilter alloc] init];
            [filter setPixelSize:CGSizeMake(0.03, 0.03)];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 12) {
            
            GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
            [filter setFractionalWidthOfAPixel:0.02f];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 13) {
            
            GPUImageStretchDistortionFilter *filter = [[GPUImageStretchDistortionFilter alloc] init];
            [gpuImagePicture addTarget:filter];
            [gpuImagePicture processImage];
            
            filterImage = [filter imageFromCurrentlyProcessedOutput];
            [gpuImagePicture removeTarget:filter];
            [filter release];
        } else if (filterCnt == 14) {
            
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

- (void)selectFilter:(NSInteger)tag defaultFilter:(GPUImageDefaultFilter*)defaultFilter {
    
    if (_filterTag != tag) {
        _filterTag = tag;
    } else {
        return;
    }
    
    // 우선 다 끊음, 안 끊음 느려진다
    /*
    if (_filter) {
        [rotationFilter removeTarget:_filter];
    }
    */
    [defaultFilter removeAllTargets];
    
    // 연결할 필터
    //GPUImageOutput<GPUImageInput> *filter = nil;
    
    // 필터 종류
    GPUImageShowcaseFilterType filterType = [self changeTagToFilterType:tag];
    
    switch (filterType) {
        case GPUIMAGE_ORIGINAL:
        {
            _filter = nil;
        }
            break;
        case GPUIMAGE_YELLOW:
        {
            _filter = [[GPUImageYellowFilter alloc] init];
        }
            break;
        case GPUIMAGE_BLUE:
        {
            _filter = [[GPUImageBlueFilter alloc] init];
        }
            break;
        case GPUIMAGE_RED:
        {
            _filter = [[GPUImageRedFilter alloc] init];
        }
            break;
        case GPUIMAGE_GRAYSCALE:
        {
            _filter = [[GPUImageGrayscaleFilter alloc] init];
        }
            break;
        case GPUIMAGE_EXPOSURE:
        {
            _filter = [[GPUImageExposureFilter alloc] init];
            [(GPUImageExposureFilter *)_filter setExposure:1.0f];
        }
            break;
        case GPUIMAGE_SHAPEN:
        {
            _filter = [[GPUImageSharpenFilter alloc] init];
            [(GPUImageSharpenFilter *)_filter setSharpness:2.5f];
        }
            break;
        case GPUIMAGE_COLORINVERT:
        {
            _filter = [[GPUImageColorInvertFilter alloc] init];
        }
            break;
        case GPUIMAGE_SOBELEDGEDETECTION:
        {
            _filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        }
            break;
            
        case GPUIMAGE_SKETCH:
        {
            _filter = [[GPUImageSketchFilter alloc] init];
        }
            break;
            
        case GPUIMAGE_TOON:
        {
            _filter = [[GPUImageToonFilter alloc] init];
        }
            break;
        case GPUIMAGE_POLAR:
        {
            _filter = [[GPUImagePolarPixellateFilter alloc] init];
            [(GPUImagePolarPixellateFilter *)_filter setPixelSize:CGSizeMake(0.03, 0.03)];
        }
            break;
        case GPUIMAGE_PIXELLATE:
        {
            _filter = [[GPUImagePixellateFilter alloc] init];
            [(GPUImagePixellateFilter *)_filter setFractionalWidthOfAPixel:0.02f];
        }
            break;
        case GPUIMAGE_STRETCH:
        {
            _filter = [[GPUImageStretchDistortionFilter alloc] init];
        }
            break;
        case GPUIMAGE_BOXBLUR:
        {
            _filter = [[GPUImageBoxBlurFilter alloc] init];
        }
            break;
    }
    
    if ( _filter) {
        // 다시 연결
        [defaultFilter addTarget:_filter];
        
        //if ([[self delgate] respondsToSelector:@selector(setCameraFilter:)]) {
            [[self delgate] setCameraFilter:_filter];
        //}
    } else {
       // if ([[self delgate] respondsToSelector:@selector(setCameraFilter:)]) {
            [[self delgate] setCameraFilter:defaultFilter];
        //}
    }
    
    //[_filter release];
}

- (UIImage*)getFilterImage:(NSInteger)tag {
    
    return [_filter imageFromCurrentlyProcessedOutput];
}

- (GPUImageShowcaseFilterType)changeTagToFilterType:(NSInteger)tag {
    
    GPUImageShowcaseFilterType filterType;
    
    switch (tag) {
        case 1:
            filterType = GPUIMAGE_ORIGINAL;
            break;
        case 2:
            filterType = GPUIMAGE_YELLOW;
            break;
        case 3:
            filterType = GPUIMAGE_BLUE;
            break;
        case 4:
            filterType = GPUIMAGE_RED;
            break;
        case 5:
            filterType = GPUIMAGE_GRAYSCALE;
            break;
        case 6:
            filterType = GPUIMAGE_EXPOSURE;
            break;
        case 7:
            filterType = GPUIMAGE_SHAPEN;
            break;
        case 8:
            filterType = GPUIMAGE_COLORINVERT;
            break;
        case 9:
            filterType = GPUIMAGE_SOBELEDGEDETECTION;
            break;
        case 10:
            filterType = GPUIMAGE_SKETCH;
            break;
        case 11:
            filterType = GPUIMAGE_TOON;
            break;
        case 12:
            filterType = GPUIMAGE_POLAR;
            break;
        case 13:
            filterType = GPUIMAGE_PIXELLATE;
            break;
        case 14:
            filterType = GPUIMAGE_BOXBLUR;
            break;
        case 15:
            filterType = GPUIMAGE_STRETCH;
            break;
    }
    
    return filterType;
}

- (UIImage*)backgroundImage:(NSInteger)tag originalImage:(UIImage*)originalImage {
    
    NSString *imageFileName = nil;
    if (tag < 10) {
        imageFileName = [NSString stringWithFormat:@"back_effect_0%d.png", tag];
    } else {
        imageFileName = [NSString stringWithFormat:@"back_effect_%d.png", tag];
    }
    UIImage *backgroundImage = [UIImage imageNamed:imageFileName];
    backgroundImage = [Util resize:backgroundImage width:originalImage.size.width height:originalImage.size.height]; 
    
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width, originalImage.size.height));
    [originalImage drawAtPoint:CGPointMake(0, 0)];
    [backgroundImage drawAtPoint:CGPointMake(0, 0)];
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mergedImage;
}

@end
