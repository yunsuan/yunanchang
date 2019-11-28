//
//  OtherDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "OtherDetailCell.h"

@implementation OtherDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _timeL.text = [NSString stringWithFormat:@"计价起止时间：%@至%@",dataDic[@"stage_start_time"],dataDic[@"stage_end_time"]];
    _rentL.text = [NSString stringWithFormat:@"免租期起止时间：%@至%@",dataDic[@"free_start_time"],dataDic[@"free_end_time"]];
    _total.text = [NSString stringWithFormat:@"总租金：%@元",dataDic[@"total_rent"]];
    _resultL.text = [NSString stringWithFormat:@"实付金额：%.2f元",[self DecimalNumber:[dataDic[@"total_rent"] doubleValue] num2:[dataDic[@"free_rent"] doubleValue]]];
    _markL.text = [NSString stringWithFormat:@"备注：%@",dataDic[@"comment"]];
    _payTimeL.text = [NSString stringWithFormat:@"交款时间：%@",dataDic[@"pay_time"]];
    _remindL.text = [NSString stringWithFormat:@"提醒时间：%@",dataDic[@"remind_time"]];
    _freeL.text = [NSString stringWithFormat:@"免租金额：%@元",dataDic[@"free_rent"]];
}

- (double)DecimalNumber:(double)num1 num2:(double)num2{
    
  NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",num1]];
    
  NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",num2]];
    
//  NSDecimalNumber *n3 = [n1 decimalNumberBySubtracting:n2];
    
  NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
  NSDecimalNumber *num = [n1 decimalNumberBySubtracting:n2 withBehavior:handler];
  NSLog(@"num===%@",num);
  return num.doubleValue;
}

- (void)initUI{
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = FONT(13 *SIZE);
        if (i == 0) {
            
            _timeL = label;
            [self.contentView addSubview:_timeL];
        }else if (i == 1){
            
            _rentL = label;
            [self.contentView addSubview:_rentL];
        }else if (i == 2){
            
            _total = label;
            [self.contentView addSubview:_total];
        }else if (i == 3){
            
            _resultL = label;
            [self.contentView addSubview:_resultL];
        }else if (i == 4){
            
            _markL = label;
            [self.contentView addSubview:_markL];
        }else if (i == 5){
            
            _payTimeL = label;
            [self.contentView addSubview:_payTimeL];
        }else if (i == 6){
            
            _freeL = label;
            [self.contentView addSubview:_freeL];
        }else{
            
            _remindL = label;
            [self.contentView addSubview:_remindL];
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_rentL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];

    [_total mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_rentL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];

    [_freeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self->_rentL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_total.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(330 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self->_resultL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_remindL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_resultL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    //        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_remindL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_markL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
    }];
}
@end
