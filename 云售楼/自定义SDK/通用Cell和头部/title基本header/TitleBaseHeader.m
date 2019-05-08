//
//  TitleBaseHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "TitleBaseHeader.h"

@implementation TitleBaseHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width , SIZE)];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];

    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(30 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}


@end
