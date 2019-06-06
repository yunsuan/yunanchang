//
//  ChannelRecommendCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelRecommendCell.h"

@implementation ChannelRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"name"]];
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _genderImg.image = IMAGE_WITH_NAME(@"man");
    }else if ([dataDic[@"sex"] integerValue] == 2){
        
        _genderImg.image = IMAGE_WITH_NAME(@"girl");
    }else{
        
        _genderImg.image = IMAGE_WITH_NAME(@"");
    }
    
    _phoneL.text = [NSString stringWithFormat:@"客户电话：%@",dataDic[@"tel"]];
    _recommendL.text = [NSString stringWithFormat:@"推荐人：%@",dataDic[@"broker_name"]];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"rule_type"]];
    _companyL.text = [NSString stringWithFormat:@"公司名称：%@",dataDic[@"company_name"]];
    _timeL.text = [NSString stringWithFormat:@"推荐时间：%@",dataDic[@"create_time"]];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.numberOfLines = 0;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];

    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CL86Color;
    _phoneL.numberOfLines = 0;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    _recommendL = [[UILabel alloc] init];
    _recommendL.textColor = CL86Color;
    _recommendL.numberOfLines = 0;
    _recommendL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_recommendL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CL86Color;
    _typeL.numberOfLines = 0;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CL86Color;
    _companyL.numberOfLines = 0;
    _companyL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_companyL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLBlueBtnColor;
    _timeL.numberOfLines = 0;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
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
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_recommendL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
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
