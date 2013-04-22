#import "GPUImageBlueFilter.h"

@implementation GPUImageBlueFilter

- (id)init;
{
    if (!(self = [super init]))
    {
		return nil;
    }
    
    self.intensity = 1.0;
    self.colorMatrix = (GPUMatrix4x4){
        {1.f, 0.f, 0.f, 0.f},
        {0.f, 1.f, 0.f, 0.f},
        {0.5f, 0.f, 1.f, 0.f},
        {1.f, 1.f, 0.f, 1.f}
    };

    return self;
}

@end

