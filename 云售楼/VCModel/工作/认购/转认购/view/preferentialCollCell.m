//
//  preferentialCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "preferentialCollCell.h"

@implementation preferentialCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"折扣名称：%@",dataDic[@"name"]];
    _wayL.text = [NSString stringWithFormat:@"折扣方式：%@",dataDic[@"type"]];
    _perferL.text = [NSString stringWithFormat:@"优惠：%@",dataDic[@"num"]];
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.preferentialCollCellDeleteBlock) {
        
        self.preferentialCollCellDeleteBlock(self.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    self.layer.cornerRadius = 5 *SIZE;
    self.layer.borderWidth = SIZE;
    self.layer.borderColor = CLLineColor.CGColor;
    self.clipsToBounds = YES;
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _wayL = label;
                [self.contentView addSubview:_wayL];
                break;
            }
            case 2:
            {
                _perferL = label;
                [self.contentView addSubview:_perferL];
                break;
            }
            default:
                break;
        }
    }
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete_2") forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_perferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_wayL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
}

@end
