//
//  WorkRecommendValidCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendValidCell.h"

@implementation WorkRecommendValidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.workRecommendValidCellBlock) {
        
        self.workRecommendValidCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"到访时间：%@",dataDic[@"visit_time"]];
    _statusL.text = dataDic[@"current_state"];
    _statusL.textColor = CLBlueBtnColor;
}

- (void)setUseDic:(NSMutableDictionary *)useDic{
    
    _nameL.text = useDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",useDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",useDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"确认时间：%@",useDic[@"confirmed_time"]];
    _statusL.text = useDic[@"current_state"];
    _statusL.textColor = CLBlueBtnColor;
}

- (void)setInValidDic:(NSMutableDictionary *)inValidDic{
    
    _nameL.text = inValidDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",inValidDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",inValidDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",inValidDic[@"state_change_time"]];
    _statusL.text = inValidDic[@"current_state"];
    
    _statusL.textColor = CL170Color;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CL86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = CL86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CL170Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 106 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(335 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(19 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(300 *SIZE);
        make.top.equalTo(self.contentView).offset(45 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
