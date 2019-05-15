//
//  CallTelegramCustomDetailFollowCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailFollowCell.h"

@implementation CallTelegramCustomDetailFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _timeL.text = [NSString stringWithFormat:@"跟进时间：%@",dataDic[@"create_time"]];//@"跟进时间：2019-04-10";
    _wayL.text = [NSString stringWithFormat:@"跟进方式：%@",dataDic[@"follow_way"]];//@"跟进方式：电话";
    _contentL.text = [NSString stringWithFormat:@"%@",dataDic[@"comment"]];//@"问了活动，妹妹读书用，过段时间再来看问了活动，妹妹读书用，过段时间再来看问了活动，妹妹读书用，过段时间再来看";
    _nextL.text = [NSString stringWithFormat:@"下次提醒时间：%@",dataDic[@"next_tip_time"]];//@"下次跟进时间：2019-04-12";
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12 *SIZE, 49 *SIZE, 100 *SIZE, 11 *SIZE)];
    label.textColor = CL170Color;
    label.font = [UIFont systemFontOfSize:12 *SIZE];
    label.text = @"跟进内容：";
    [_whiteView addSubview:label];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
//        label.numberOfLines = 0;
        switch (i) {
            case 0:
            {

                _timeL = label;
                _timeL.textColor = CLTitleLabColor;
                _timeL.font = FONT(15 *SIZE);
                _timeL.adjustsFontSizeToFitWidth = YES;
                [_whiteView addSubview:_timeL];
                break;
            }
            case 1:
            {

                _wayL = label;
                _wayL.textAlignment = NSTextAlignmentRight;
                _wayL.textColor = CL170Color;
                _wayL.font = FONT(12 *SIZE);
                [_whiteView addSubview:_wayL];
                break;
            }
            case 2:
            {

                _contentL = label;
                _contentL.font = FONT(12 *SIZE);
                _contentL.numberOfLines = 0;
                [_whiteView addSubview:_contentL];
                break;
            }
            case 3:
            {
                
                _nextL = label;
                _nextL.textColor = CL153Color;
                _nextL.font = FONT(12 *SIZE);
                [_whiteView addSubview:_nextL];
                break;
            }
            default:
                break;
        }
    }
    
    _speechImg = [[UIImageView alloc] init];
    _speechImg.image = IMAGE_WITH_NAME(@"play");
    [self.contentView addSubview:_speechImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(12 *SIZE);
        make.top.equalTo(self->_whiteView).offset(20 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-13 *SIZE);
        make.top.equalTo(self->_whiteView).offset(21 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(12 *SIZE);
        make.top.equalTo(self->_whiteView).offset(74 *SIZE);
        make.width.mas_equalTo(302 *SIZE);
    }];
    
    [_speechImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(11 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];

    [_nextL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(58 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-19 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-26 *SIZE);
    }];
}

@end
