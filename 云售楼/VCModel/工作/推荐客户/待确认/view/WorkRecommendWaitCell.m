//
//  WorkRecommendWaitCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendWaitCell.h"

@implementation WorkRecommendWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.workRecommendWaitCellBlock) {
        
        self.workRecommendWaitCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    //    _confirmL.text = [NSString stringWithFormat:@"到访确认人：%@",dataDic[@"butter_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:CL86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;
//    _phoneL.text = @"123123123";
    _phoneL.text = dataDic[@"tel"];
}

- (void)setFailDic:(NSMutableDictionary *)failDic{
    
    _nameL.text = failDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",failDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",failDic[@"project_name"]];
    //    _confirmL.text = [NSString stringWithFormat:@"到访确认人：%@",dataDic[@"butter_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",failDic[@"state_change_time"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:CL86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;
//    _phoneL.text = @"123123123";
    _phoneL.text = failDic[@"tel"];
}

- (void)setValidDic:(NSMutableDictionary *)validDic{
    
    _nameL.text = validDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",validDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",validDic[@"project_name"]];
    //    _confirmL.text = [NSString stringWithFormat:@"到访确认人：%@",dataDic[@"butter_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",validDic[@"timsLimit"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:CL86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;
//    _phoneL.text = @"123123123";
    _phoneL.text = validDic[@"tel"];
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
    _codeL.textAlignment = NSTextAlignmentRight;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CL86Color;
    _phoneL.numberOfLines = 0;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
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
    
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _confirmBtn.frame = CGRectMake(273 *SIZE, 61 *SIZE, 77 *SIZE, 30 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.layer.borderWidth = SIZE;
    _confirmBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    [_confirmBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];

    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];

    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
