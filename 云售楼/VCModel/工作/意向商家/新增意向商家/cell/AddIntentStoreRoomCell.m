//
//  AddIntentStoreRoomCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreRoomCell.h"

@implementation AddIntentStoreRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _roomL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 10 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _roomL.textColor = CLTitleLabColor;
    _roomL.font = FONT(13 *SIZE);
    _roomL.numberOfLines = 0;
    [self.contentView addSubview:_roomL];
    
    _areaL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 30 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _areaL.textColor = CLContentLabColor;
    _areaL.font = FONT(13 *SIZE);
    _areaL.numberOfLines = 0;
    [self.contentView addSubview:_areaL];
    
    _priceL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 50 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    _priceL.numberOfLines = 0;
    [self.contentView addSubview:_priceL];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0 *SIZE, 69 *SIZE, SCREEN_Width, 1 *SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 20 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_roomL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 20 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 20 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0 *SIZE);
    }];
}

@end
