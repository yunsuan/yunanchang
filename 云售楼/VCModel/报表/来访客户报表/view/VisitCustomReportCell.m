//
//  VisitCustomReportCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomReportCell.h"

@implementation VisitCustomReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _colorView.backgroundColor = [UIColor orangeColor];
    _titleL.text = @"渠道分销";
    _numL.text = @"50";
    _percentL.text = [NSString stringWithFormat:@"占比：%@",@"50%"];
}

- (void)initUI{
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(12 *SIZE, 10 *SIZE, 20 *SIZE, 20 *SIZE)];
    [self.contentView addSubview:_colorView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(40 *SIZE, 10 *SIZE, 150 *SIZE, 20 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(220 *SIZE, 10 *SIZE, 40 *SIZE, 20 *SIZE)];
    _numL.textColor = CLTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_numL];
    
    _percentL = [[UILabel alloc] initWithFrame:CGRectMake(270 *SIZE, 10 *SIZE, 80 *SIZE, 20 *SIZE)];
    _percentL.textColor = CLTitleLabColor;
    _percentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_percentL];
}

@end
