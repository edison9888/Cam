#import "GPUImageDefaultFilter.h"

NSString *const kGPUImageDefaultFragmentShaderString =  SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
 }
);

@implementation GPUImageDefaultFilter

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageDefaultFragmentShaderString]))
    {
        return nil;
    }
    
    return self;
}

@end
