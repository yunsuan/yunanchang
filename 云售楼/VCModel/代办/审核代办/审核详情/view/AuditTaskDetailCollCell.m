//
//  AuditTaskDetailCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AuditTaskDetailCollCell.h"

@implementation AuditTaskDetailCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _numL.text = [NSString stringWithFormat:@"序号：%ld",(long)self.tag];
    _auditL.text = [NSString stringWithFormat:@"审核人：%@",dataDic[@"check"]];
    _timeL.text = [NSString stringWithFormat:@"审核时间：%@",dataDic[@"update_time"]];
    _contentL.text = [NSString stringWithFormat:@"审核内容：%@",dataDic[@"comment"]];
    if ([dataDic[@"state"] integerValue] == 0) {
        
        _resultL.text = @"审核结果：不通过";
    }else if ([dataDic[@"state"] integerValue] == 1){
        
        _resultL.text = @"审核结果：审核中";
    }else{
        
        _resultL.text = @"审核结果：待审核";
    }
    
}

- (void)initUI{
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 1:
            {
                _auditL = label;
                [self.contentView addSubview:_auditL];
                break;
            }
            case 2:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 3:
            {
                _contentL = label;
                [self.contentView addSubview:_contentL];
                break;
            }
            case 4:
            {
                _resultL = label;
                [self.contentView addSubview:_resultL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_numL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_auditL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
