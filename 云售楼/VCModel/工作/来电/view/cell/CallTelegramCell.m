//
//  CallTelegramCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCell.h"

@interface CallTelegramCell ()
{
    
    NSDateFormatter *_formatter;
}
@end

@implementation CallTelegramCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _formatter = [[NSDateFormatter alloc] init];
        
//        _formatter set
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
    if ([dataDic[@"level"] length]) {
        
        _nameL.text = [NSString stringWithFormat:@"%@(%@)",dataDic[@"name"],dataDic[@"level"]];
    }else{
        
        _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    }
    //@"张三/A";
    _effectTagL.text = dataDic[@"current_state"];//@"有效";
    _groupL.text = [NSString stringWithFormat:@"组别人数：%@人",dataDic[@"client_num"]];//@"组别：云算购房组";
    _dayL.text = [NSString stringWithFormat:@"%@",dataDic[@"create_time"]];//@"3天";
    if (_dayL.text.length > 10) {
        
        _dayL.text = [_dayL.text substringToIndex:10];
    }else{
        
        _dayL.text = [_dayL.text substringToIndex:_dayL.text.length];
    }
    
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:dataDic[@"tel"] attributes:attribtDic];
    
    //赋值
    _phoneL.attributedText = attribtStr;//@"13438339177";
    
    _timeL.text = @"";
    NSDate *date = [NSDate date];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    if (dataDic[@"time_limit"] && [dataDic[@"time_limit"] isKindOfClass:[NSString class]] && [dataDic[@"time_limit"] length]) {
        
        NSDate *timeLimit = [_formatter dateFromString:dataDic[@"time_limit"]];
        NSCalendar *calendar = [NSCalendar currentCalendar];

        NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
        NSDateComponents *delta = [calendar components:unit fromDate:date toDate:timeLimit options:0];
//        NSInteger a = ([timeLimit timeIntervalSince1970] - [date timeIntervalSince1970]) / (1000 * 3600 * 24);
        if (delta.day > 0) {
            
            _timeL.textColor = CLBlueBtnColor;
            _timeL.text = [NSString stringWithFormat:@"距下次跟进：%ld天",delta.day];
        }else if (delta.day == 0){
            
            _timeL.text = @"今天该跟进此客户了";
            _timeL.textColor = CLOrangeColor;
        }else if (delta.day < 0){
            
            _timeL.text = [NSString stringWithFormat:@"跟进已超期：%ld天",0 - delta.day];
            _timeL.textColor = CLOrangeColor;
        }
    }else{
        
        _timeL.text = @" ";
    }
    _contactL.text = dataDic[@"agent_name"]; //@"温嘉琪";
    
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(self.contentView).offset(84 *SIZE);
//        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
        make.width.mas_lessThanOrEqualTo(140 *SIZE);
    }];
}

- (void)ActionPhone{
    
    if (self.callTelegramCellBlock) {
        
        self.callTelegramCellBlock();
    }
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
    _phoneL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhone)];
    [_phoneL addGestureRecognizer:tap];
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
        make.width.mas_lessThanOrEqualTo(140 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_groupL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_effectTagL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(210 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
//        make.top.equalTo(self->_nameL.mas_bottom).offset(9 *SIZE);
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
        make.width.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
}

@end
