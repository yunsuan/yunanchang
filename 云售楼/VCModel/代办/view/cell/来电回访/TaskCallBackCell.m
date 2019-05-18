//
//  TaskCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskCallBackCell.h"

@implementation TaskCallBackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.taskCallBackCellBlock) {
        
        self.taskCallBackCellBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 1) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _titleL.text = @"来电回访";
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"name"]];
    _projectL.text =  [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
    _customL.text = [NSString stringWithFormat:@"客户等级：%@",dataDic[@"level"]];
    _phoneL.text = [NSString stringWithFormat:@"客户电话：%@",dataDic[@"tel"]];
    _contentL.text = [NSString stringWithFormat:@"提醒目的：%@",dataDic[@"extra_comment"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.image = IMAGE_WITH_NAME(@"laidian");
    [_whiteView addSubview:_headImg];
    
    _readImg = [[UIImageView alloc] init];
    _readImg.image = IMAGE_WITH_NAME(@"SMS");
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 4; i++) {
        
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
                _customL = label;
                _customL.textAlignment = NSTextAlignmentRight;
                [_whiteView addSubview:_customL];
                break;
            }
            case 2:
            {
                _projectL = label;
                [_whiteView addSubview:_projectL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                _phoneL.textAlignment = NSTextAlignmentRight;
                [_whiteView addSubview:_phoneL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [_whiteView addSubview:_line];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CL86Color;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [_whiteView addSubview:_contentL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.layer.borderWidth = SIZE;
    _addBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    _addBtn.clipsToBounds = YES;
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"添加跟进" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [_whiteView addSubview:_addBtn];
    
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
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(6 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-6 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(7 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-6 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-18 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-8 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(73 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
