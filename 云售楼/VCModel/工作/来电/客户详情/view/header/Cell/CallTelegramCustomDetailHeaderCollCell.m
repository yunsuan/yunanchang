//
//  CallTelegramCustomDetailHeaderCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailHeaderCollCell.h"

@implementation CallTelegramCustomDetailHeaderCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setIsSelect:(NSInteger)isSelect{
    
    if (isSelect) {
        
        _titleView.backgroundColor = CLOrangeColor;
        _titleL.textColor = CLWhiteColor;
    }else{
        
        _titleView.backgroundColor = CLBackColor;
        _titleL.textColor = CL86Color;
    }
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailHeaderCollCellDeleteBlock) {
        
        self.callTelegramCustomDetailHeaderCollCellDeleteBlock(self.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    self.contentView.layer.cornerRadius = 3 *SIZE;
    self.contentView.clipsToBounds = YES;
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = CLBackColor;
    [self.contentView addSubview:_titleView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.adjustsFontSizeToFitWidth = YES;
    [_titleView addSubview:_titleL];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _deleteBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.hidden = YES;
    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete_3") forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_titleView).offset(0 *SIZE);
        make.top.equalTo(self->_titleView).offset(9 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
    }];
}


@end
