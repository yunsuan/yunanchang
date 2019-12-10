//
//  UpgradeTipsView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UpgradeTipsView.h"

@implementation UpgradeTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.upgradeTipsViewBlock) {
        
        self.upgradeTipsViewBlock();
    }
    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 10 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _img = [[UIImageView alloc] init];
    _img.image = [UIImage imageNamed:@"1"];
    [_whiteView addSubview:_img];
    
    _scroll = [[UIScrollView alloc] init];
    [_whiteView addSubview:_scroll];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.adjustsFontSizeToFitWidth = YES;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [_scroll addSubview:_contentL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 5 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_confirmBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"updateCancel"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(30 *SIZE);
        make.top.equalTo(self).offset(170 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(250 *SIZE);
    }];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(116.5 *SIZE);
        make.top.equalTo(_whiteView).offset(15 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(43 *SIZE);
    }];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(10 *SIZE);
        make.top.equalTo(_whiteView).offset(70 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
        make.height.mas_equalTo(130 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(10 *SIZE);
        make.top.equalTo(_scroll).offset(10 *SIZE);
        make.width.mas_equalTo(260 *SIZE);
        make.bottom.equalTo(_scroll.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(20 *SIZE);
        make.top.equalTo(_whiteView).offset(200 *SIZE);
        make.width.mas_equalTo(260 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(165 *SIZE);
        make.top.equalTo(self).offset(435 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
