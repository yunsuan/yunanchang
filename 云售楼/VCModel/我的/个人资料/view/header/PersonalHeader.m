//
//  PersonalHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PersonalHeader.h"

@implementation PersonalHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionImg{
    
    if (self.personalHeaderBlock) {
        
        self.personalHeaderBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.shadowColor = CLLineColor.CGColor;
    _whiteView.layer.shadowOffset = CGSizeMake(0, 7 *SIZE);
    _whiteView.layer.shadowOpacity = 1;
    [self.contentView addSubview:_whiteView];
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.layer.cornerRadius = 33.5 *SIZE;
    _headerImg.clipsToBounds = YES;
    _headerImg.userInteractionEnabled = YES;
    [self.contentView addSubview:_headerImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImg)];
    [_headerImg addGestureRecognizer:tap];

    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(100 *SIZE);
    }];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(146 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-23 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
}

@end
