//
//  IntentSurveyHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "IntentSurveyHeader.h"

@implementation IntentSurveyHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13 *SIZE];

    [self addSubview:_titleL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(21 *SIZE);
        make.top.equalTo(self).offset(7 *SIZE);
        make.right.equalTo(self).offset(-18 *SIZE);
        make.bottom.equalTo(self).offset(-7 *SIZE);
    }];
}

@end
