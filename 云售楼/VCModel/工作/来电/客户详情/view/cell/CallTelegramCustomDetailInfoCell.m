//
//  CallTelegramCustomDetailInfoCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailInfoCell.h"

@implementation CallTelegramCustomDetailInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailInfoCellEditBlock) {

        self.callTelegramCustomDetailInfoCellEditBlock();
    }
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailInfoCellDeleteBlock) {
        
        self.callTelegramCustomDetailInfoCellDeleteBlock();
    }
}


- (void)initUI{
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CL95Color;
    _contentL.font = [UIFont systemFontOfSize:14 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    _editBtn.hidden = YES;
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_2") forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.hidden = YES;
    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete_2") forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_editBtn.mas_left).offset(-20 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.height.mas_equalTo(20 *SIZE);
    }];
}

@end
