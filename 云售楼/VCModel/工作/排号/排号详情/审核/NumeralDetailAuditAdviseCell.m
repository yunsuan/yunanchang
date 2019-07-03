//
//  NumeralDetailAuditAdviseCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailAuditAdviseCell.h"

@implementation NumeralDetailAuditAdviseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        
    }else{
        
        
    }
}

- (void)initUI{
    
    _textView = [[UITextView alloc] init];
    [self.contentView addSubview:_textView];
    
    NSArray *arr = @[@"选择下一步审核人：",@"审核内容："];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.text = arr[i];
        label.adjustsFontSizeToFitWidth = YES;
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            _nextL = label;
            [self.contentView addSubview:_nextL];
            
            _nextBtn = btn;
            [self.contentView addSubview:_nextBtn];
        }else{
            
            _auditL = label;
            [self.contentView addSubview:_auditL];
            
            _auditBtn = btn;
            [self.contentView addSubview:_auditBtn];
        }
    }
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(351 *SIZE);
        make.height.mas_equalTo(80 *SIZE);
    }];
    
    [_nextL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_textView.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(140 *SIZE);
        make.top.equalTo(self->_textView.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_nextBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(140 *SIZE);
        make.top.equalTo(self->_nextBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
