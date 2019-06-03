//
//  ARotationFollowCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ARotationFollowCell.h"

@implementation ARotationFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.aRotationFollowCellBlock) {
        
        self.aRotationFollowCellBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 1) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _nameL.text = [NSString stringWithFormat:@"项目名称：%@",dataDic[@"name"]];
    _timeL.text =  [NSString stringWithFormat:@"接待时间：%@",dataDic[@"project_name"]];
//    _recommendL.text = [NSString stringWithFormat:@"推荐人：%@",dataDic[@"broker"]];
//    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",dataDic[@"failure_time"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.image = IMAGE_WITH_NAME(@"laifang");
    [_whiteView addSubview:_headImg];
    
    _readImg = [[UIImageView alloc] init];
    _readImg.image = IMAGE_WITH_NAME(@"SMS");
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.text = @"A位跟进";
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _timeL = label;
                [_whiteView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.layer.borderWidth = SIZE;
    _confirmBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"添加跟进" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [_whiteView addSubview:_confirmBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(354 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
        make.width.height.mas_equalTo(51 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(63 *SIZE);
        make.top.equalTo(self->_whiteView).offset(30 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_readImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-7 *SIZE);
        make.top.equalTo(self->_whiteView).offset(31 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(7 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-18 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-8 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-18 *SIZE);
        make.width.mas_equalTo(73 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
