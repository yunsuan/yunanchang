//
//  EmptyPieView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "EmptyPieView.h"

@implementation EmptyPieView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _circleView = [[UIView alloc] init];
//    _circleView.backgroundColor = CLArr[0];
//    _circleView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    _circleView.frame = CGRectMake(100 *SIZE, 40 *SIZE, 160 *SIZE, 160 *SIZE);
    _circleView.layer.cornerRadius = 80 *SIZE;
    _circleView.layer.borderWidth = SIZE;
    _circleView.layer.borderColor = COLOR(73, 92, 105, 0.5).CGColor;
    _circleView.clipsToBounds = YES;
    [self addSubview:_circleView];
}

@end
