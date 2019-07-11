//
//  SelectPerferCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SelectPerferCollCell.h"

@implementation SelectPerferCollCell

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
    _cumulativeL.text = [NSString stringWithFormat:@"累计折扣：%@",[dataDic[@"is_cumulative"] integerValue] == 1? @"是":@"否"];
    _wayL.text = [NSString stringWithFormat:@"折扣方式：%@",dataDic[@"pay_way"]];
    _perferL.text = [NSString stringWithFormat:@"优惠：%@",dataDic[@"num"]];
    _describeL.text = [NSString stringWithFormat:@"折扣描述：%@",dataDic[@"type"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i % 2 == 0) {
            
            label.textAlignment = NSTextAlignmentLeft;
        }else{
            
            label.textAlignment = NSTextAlignmentRight;
        }
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _cumulativeL = label;
                [self.contentView addSubview:_cumulativeL];
                break;
            }
            case 2:
            {
                _wayL = label;
                [self.contentView addSubview:_wayL];
                break;
            }
            case 3:
            {
                _perferL = label;
                [self.contentView addSubview:_perferL];
                break;
            }
            case 4:
            {
                _describeL = label;
//                _describeL.numberOfLines = 2;
//                _describeL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_describeL];
                break;
            }
            default:
                break;
        }
    }
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_cumulativeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_perferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_cumulativeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_describeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_wayL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}

@end
