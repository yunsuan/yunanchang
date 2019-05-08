//
//  RecommendCustomCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RecommendCustomCell.h"

@implementation RecommendCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.recommendCustomCellBlock) {
        
        self.recommendCustomCellBlock(self.tag);
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.numberOfLines = 0;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CL86Color;
    _codeL.numberOfLines = 0;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = CL86Color;
    _projectL.numberOfLines = 0;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLBlueBtnColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLBackColor;
    [self.contentView addSubview:_lineView];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:COLOR(255, 165, 29, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
//    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
//
//        _confirmBtn.hidden = YES;
//    }else{
//
//        _confirmBtn.hidden = NO;
//    }
    
//    [self MasonryUI];
}

//- (void)MasonryUI{
//
//    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.right.equalTo(self.contentView).offset(-9 *SIZE);
//    }];
//
//    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
//        make.right.equalTo(self.contentView).offset(-150 *SIZE);
//    }];
//
//    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
//        make.right.equalTo(self.contentView).offset(-150 *SIZE);
//    }];
//
//    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
//        make.right.equalTo(self.contentView).offset(-150 *SIZE);
//    }];
//
//    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(273 *SIZE);
//        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
//        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
//
//    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(273 *SIZE);
//        make.top.equalTo(_nameL.mas_bottom).offset(34 *SIZE);
//        make.width.mas_equalTo(77 *SIZE);
//        make.height.mas_equalTo(30 *SIZE);
//    }];
//
//    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_timeL.mas_bottom).offset(10 *SIZE);
//        make.right.equalTo(self.contentView).offset(-9 *SIZE);
//    }];
//
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(0 *SIZE);
//        make.top.equalTo(_addressL.mas_bottom).offset(15 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//}

@end
