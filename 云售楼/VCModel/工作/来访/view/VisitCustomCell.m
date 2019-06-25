//
//  VisitCustomCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomCell.h"

@implementation VisitCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    _titleL.text = [NSString stringWithFormat:@"项目名称：%@",dataDic[@""]];
    _timeL.text = [NSString stringWithFormat:@"接待时间：%@",dataDic[@"update_time"]];
}

- (void)ActionFollowBtn:(UIButton *)btn{
    
    if (self.visitCustomCellBlock) {
        
        self.visitCustomCellBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 21.5 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.image = IMAGE_WITH_NAME(@"rotational");
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.text = @"A位接待 待跟进客户";
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];

    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CL95Color;
//    _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    
    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _followBtn.frame = CGRectMake(290 *SIZE, 25 *SIZE, 60 *SIZE, 23 *SIZE);
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_followBtn addTarget:self action:@selector(ActionFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_followBtn setTitle:@"去跟进" forState:UIControlStateNormal];
    [_followBtn setBackgroundColor:CLBlueBtnColor];
    _followBtn.layer.cornerRadius = 2 *SIZE;
    _followBtn.clipsToBounds = YES;
    [self.contentView addSubview:_followBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(43 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
//        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-33 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(25 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    
}

@end
