//
//  StoreDetailFollowCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StoreDetailFollowCell.h"

@implementation StoreDetailFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _stageL.text = [NSString stringWithFormat:@"跟进阶段：%@",dataDic[@"follow_state_name"]];
    _timeL.text = [NSString stringWithFormat:@"%@",dataDic[@"follow_time"]];//@"跟进时间：2019-04-10";
    _contentL.text = [NSString stringWithFormat:@"%@",dataDic[@"content"]];
    _wayL.text = [NSString stringWithFormat:@"跟进方式：%@",dataDic[@"follow_way_name"]];//@"跟进方式：电话";
    _intentL.text = [NSString stringWithFormat:@"合作意向：%@",dataDic[@"cooperation_level_name"]];//@"下次跟进时间：2019-04-12";
    _nextTimeL.text = [NSString stringWithFormat:@"下次跟进时间：%@",dataDic[@"next_follow_time"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12 *SIZE, 65 *SIZE, 100 *SIZE, 11 *SIZE)];
    label.textColor = CL170Color;
    label.font = [UIFont systemFontOfSize:12 *SIZE];
    label.text = @"跟进内容：";
    [_whiteView addSubview:label];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
//        label.numberOfLines = 0;
        switch (i) {
            case 0:
            {

                _timeL = label;
                _timeL.textColor = CLTitleLabColor;
                _timeL.font = FONT(12 *SIZE);
                _timeL.adjustsFontSizeToFitWidth = YES;
                _timeL.textAlignment = NSTextAlignmentRight;
                [_whiteView addSubview:_timeL];
                break;
            }
            case 1:
            {

                _wayL = label;
//                _wayL.textAlignment = NSTextAlignmentRight;
                _wayL.textColor = CLTitleLabColor;
                _wayL.font = FONT(13 *SIZE);
                [_whiteView addSubview:_wayL];
                break;
            }
            case 2:
            {

                _contentL = label;
                _contentL.font = FONT(13 *SIZE);
                _contentL.numberOfLines = 0;
                _contentL.textColor = CLContentLabColor;
                [_whiteView addSubview:_contentL];
                break;
            }
            case 3:
            {
                
                _intentL = label;
                _intentL.textColor = CLTitleLabColor;
                _intentL.font = FONT(13 *SIZE);
                [_whiteView addSubview:_intentL];
                break;
            }
            case 4:
            {
                
                _stageL = label;
                _stageL.textColor = CLTitleLabColor;
                _stageL.font = FONT(13 *SIZE);
                _stageL.adjustsFontSizeToFitWidth = YES;
                [_whiteView addSubview:_stageL];
                break;
            }
            case 5:
            {

                _nextTimeL = label;
                _nextTimeL.textColor = CLTitleLabColor;
                _nextTimeL.font = FONT(12 *SIZE);
                _nextTimeL.adjustsFontSizeToFitWidth = YES;
                _nextTimeL.textAlignment = NSTextAlignmentRight;
                [_whiteView addSubview:_nextTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];
    
    [_stageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(12 *SIZE);
        make.top.equalTo(self->_whiteView).offset(15 *SIZE);
        make.width.mas_equalTo(302 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-13 *SIZE);
        make.top.equalTo(self->_whiteView).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(12 *SIZE);
        make.top.equalTo(self->_whiteView).offset(40 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(58 *SIZE);
        make.top.equalTo(self->_whiteView).offset(40 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-19 *SIZE);
//        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-26 *SIZE);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(12 *SIZE);
        make.top.equalTo(self->_whiteView).offset(84 *SIZE);
        make.width.mas_equalTo(302 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(58 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-19 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-26 *SIZE);
    }];
}
@end
