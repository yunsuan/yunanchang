//
//  AddIntentStoreDoubleBtnCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreDoubleBtnCell.h"

@implementation AddIntentStoreDoubleBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addIntentStoreDoubleBtnCellAddBlock) {
        
        self.addIntentStoreDoubleBtnCellAddBlock();
    }
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    if (self.addIntentStoreDoubleBtnCellSelectBlock) {
        
        self.addIntentStoreDoubleBtnCellSelectBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:CLOrangeColor];
    [_addBtn setTitle:@"添加商家" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = FONT(13 *SIZE);
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    [self.contentView addSubview:_addBtn];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setBackgroundColor:CLOrangeColor];
    [_selectBtn setTitle:@"选择商家" forState:UIControlStateNormal];
    [_selectBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.titleLabel.font = FONT(13 *SIZE);
    _selectBtn.layer.cornerRadius = 15 *SIZE;
    _selectBtn.clipsToBounds = YES;
    [self.contentView addSubview:_selectBtn];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0 *SIZE, 69 *SIZE, SCREEN_Width, 1 *SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(40 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0 *SIZE);
    }];
}

@end
