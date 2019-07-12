//
//  AddNemeralHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNemeralHeader.h"

@implementation AddNemeralHeader

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.addNemeralHeaderMoreBlock) {
        
        self.addNemeralHeaderMoreBlock();
    }
}

- (void)ActionAllBtn:(UIButton *)btn{
    
    if (self.addNemeralHeaderAllBlock) {
        
        self.addNemeralHeaderAllBlock();
    }
}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self addSubview:_moreBtn];
    
    _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_allBtn addTarget:self action:@selector(ActionAllBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_allBtn setTitle:@"展开" forState:UIControlStateNormal];
//    [_allBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self addSubview:_allBtn];
    
//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
//    //    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_addBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
//    [self addSubview:_addBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 *SIZE);
        make.top.equalTo(self).offset(13 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(287 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(0 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(360 *SIZE));
        make.height.equalTo(@(39 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self->_allBtn.mas_bottom).offset(0 *SIZE);
        make.bottom.equalTo(self).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(SIZE));
    }];
}

@end
