//
//  TaskSellReportCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskSellReportCell.h"

@implementation TaskSellReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 1) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    switch ([dataDic[@"message_type"] integerValue]) {
        case 50:
        {
            _headL.text = [NSString stringWithFormat:@"%@",@"日报"];
            break;
        }
        case 51:
        {
            _headL.text = [NSString stringWithFormat:@"%@",@"周报"];
            break;
        }
        case 52:
        {
            _headL.text = [NSString stringWithFormat:@"%@",@"月报"];
            break;
        }
        default:
            break;
    }
//    _headL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    _titleL.text = [NSString stringWithFormat:@"%@",dataDic[@"title"]];
    _contentL.text =  [NSString stringWithFormat:@"%@",dataDic[@"extra_comment"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
//    _headImg = [[UIImageView alloc] init];
////    _headImg.image = IMAGE_WITH_NAME(@"laifang");
//    [_whiteView addSubview:_headImg];
    _headL = [[UILabel alloc] init];
    _headL.backgroundColor = CLOrangeColor;
    _headL.font = FONT(20 *SIZE);
    _headL.textAlignment = NSTextAlignmentCenter;
    _headL.layer.cornerRadius = 2 *SIZE;
    _headL.clipsToBounds = YES;
    _headL.textColor = CLWhiteColor;
    [_whiteView addSubview:_headL];
    
    _readImg = [[UIImageView alloc] init];
    _readImg.image = IMAGE_WITH_NAME(@"SMS");
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
//    _titleL.text = @"来访跟进";
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLTitleLabColor;
//    _contentL.text = @"来访跟进";
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [_whiteView addSubview:_contentL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(354 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_headL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
        make.width.height.mas_equalTo(51 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(63 *SIZE);
        make.top.equalTo(self->_whiteView).offset(30 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_readImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-7 *SIZE);
        make.top.equalTo(self->_whiteView).offset(31 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_headL.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-8 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-18 *SIZE);
    }];
}

@end
