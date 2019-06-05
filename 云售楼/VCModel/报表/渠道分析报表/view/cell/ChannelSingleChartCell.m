//
//  ChannelSingleChartCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelSingleChartCell.h"


@interface ChannelSingleChartCell ()<SingleBarChartViewDelegate>



@end

@implementation ChannelSingleChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_singleBarChartView removeFromSuperview];
    
    _singleBarChartView = [[SingleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _singleBarChartView.backgroundColor = CLWhiteColor;
    _singleBarChartView.delegate = self;
    //    _singleBarChartView.yScaleValue = 60 *SIZE;
    [self.contentView addSubview:_singleBarChartView];

    _singleBarChartView.xValuesArr = [@[@"推荐客户",@"到访客户",@"成交客户"] mutableCopy];
    if (dataDic.count) {
        
        _singleBarChartView.yValuesArr = [@[[NSString stringWithFormat:@"%@",dataDic[@"recommend"]],[NSString stringWithFormat:@"%@",dataDic[@"visit"]],[NSString stringWithFormat:@"%@",dataDic[@"deal"]]] mutableCopy];
    }else{
        
        _singleBarChartView.yValuesArr = [@[@"0",@"0",@"0"] mutableCopy];
    }
    

    _singleBarChartView.unit = @"人";
}

- (void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index{
    
    NSLog(@"111111111111%ld",index);
    if (self.channelSingleChartCellBlock) {
        
        self.channelSingleChartCellBlock(index);
    }
}

- (void)initUI{
    
    _singleBarChartView = [[SingleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _singleBarChartView.backgroundColor = CLWhiteColor;
//    _singleBarChartView.yScaleValue = 60 *SIZE;
    [self.contentView addSubview:_singleBarChartView];
}

@end
