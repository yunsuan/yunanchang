//
//  CallTelegramCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCell.h"

@implementation CallTelegramCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    _headImg.image = IMAGE_WITH_NAME(@"head");
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _headImg.image = IMAGE_WITH_NAME(@"nan");
    }else{
        
        _headImg.image = IMAGE_WITH_NAME(@"nv");
    }
    _nameL.text = [NSString stringWithFormat:@"%@/%@",dataDic[@"name"],dataDic[@"level"]];//@"张三/A";
    _effectTagL.text = dataDic[@"current_state"];//@"有效";
    _groupL.text = [NSString stringWithFormat:@"组别：%@人",dataDic[@"client_num"]];//@"组别：云算购房组";
    _dayL.text = [NSString stringWithFormat:@"%@",dataDic[@"time_limit"]];//@"3天";
    _phoneL.text = dataDic[@"tel"];//@"13438339177";
    _timeL.text = [NSString stringWithFormat:@"%@",dataDic[@"create_time"]];//@"2018.12.30";
    _contactL.text = dataDic[@"agent_name"]; //@"温嘉琪";
    
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(self.contentView).offset(84 *SIZE);
//        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
        make.width.mas_greaterThanOrEqualTo(50 *SIZE);
    }];
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 21.5 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CL86Color;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _groupL = [[UILabel alloc] init];
    _groupL.textColor = CL95Color;
    _groupL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_groupL];
    
    _effectTagL = [[UILabel alloc] init];
    _effectTagL.textColor = CLBlueTagColor;
    _effectTagL.font = [UIFont systemFontOfSize:12 *SIZE];
    _effectTagL.backgroundColor = CLBlueBackColor;
    _effectTagL.adjustsFontSizeToFitWidth = YES;
//    _effectTagL.layer.borderWidth = SIZE;
//    _effectTagL.layer.borderColor = CLBlueTagColor.CGColor;
    _effectTagL.layer.cornerRadius = 3 *SIZE;
    _effectTagL.clipsToBounds = YES;
    _effectTagL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_effectTagL];
    
    _dayL = [[UILabel alloc] init];
    _dayL.textColor = CL86Color;
    _dayL.font = [UIFont systemFontOfSize:11 *SIZE];
    _dayL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dayL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CL95Color;
    _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = CL95Color;
    _contactL.textAlignment = NSTextAlignmentRight;
    _contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_contactL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(43 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_groupL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_effectTagL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(205 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_dayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(24 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self->_dayL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_contactL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
}

@end
