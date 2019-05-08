//
//  IntentSurveyCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "IntentSurveyCollCell.h"

@implementation IntentSurveyCollCell

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
    _titleL.textColor = CLContentLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:14 *SIZE];
    //    _titleL.numberOfLines = 0;
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_titleL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-18 *SIZE);
    }];
}

@end
