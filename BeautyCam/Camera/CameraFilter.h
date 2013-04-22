//
//  CameraFilter.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 4..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@protocol CameraFilterDelegate
- (void)setCameraFilter:(GPUImageOutput<GPUImageInput>*)filter;
@end

@interface CameraFilter : NSObject {
    
    __unsafe_unretained id <CameraFilterDelegate> _delegate; 
    GPUImageOutput<GPUImageInput> *_filter;
    
    NSInteger _filterTag;
}

@property (nonatomic, assign) id <CameraFilterDelegate> delgate;

- (NSMutableArray*)makeFilterImages:(UIImage*)originalImage;
// filter
- (void)selectFilter:(NSInteger)tag defaultFilter:(GPUImageDefaultFilter*)defaultFilter;
- (GPUImageShowcaseFilterType)changeTagToFilterType:(NSInteger)tag;
- (UIImage*)getFilterImage:(NSInteger)tag;
// background
- (UIImage*)backgroundImage:(NSInteger)tag originalImage:(UIImage*)originalImage;
@end
