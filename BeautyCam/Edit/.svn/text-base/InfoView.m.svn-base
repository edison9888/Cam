//
//  InfoView.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 5. 10..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *bottomMenuImage = [UIImage imageNamed:NSLocalizedString(@"guidebar",@"")];
        UIImageView *bottomMenuImageView = [[UIImageView alloc] initWithImage:bottomMenuImage];
        bottomMenuImageView.frame = CGRectMake(0,
                                               frame.size.height - (bottomMenuImage.size.height),
                                               bottomMenuImage.size.width, 
                                               bottomMenuImage.size.height);
        [self addSubview:bottomMenuImageView];
        
        UIView *bgAlphaView = [[UIView alloc] initWithFrame:frame];
        bgAlphaView.backgroundColor = [UIColor blackColor];
        bgAlphaView.alpha = .4f;
        [self addSubview:bgAlphaView];
        
        UIImage *infoImage = [UIImage imageNamed:NSLocalizedString(@"guide",@"")];
        UIImageView *infoImageView = [[UIImageView alloc] initWithImage:infoImage];
        infoImageView.frame = [UIScreen mainScreen].bounds;
        [self addSubview:infoImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
