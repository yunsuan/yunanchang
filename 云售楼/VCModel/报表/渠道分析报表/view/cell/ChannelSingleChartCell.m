//
//  ChannelSingleChartCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelSingleChartCell.h"


@interface ChannelSingleChartCell ()<SingleBarChartViewDelegate>

@property (nonatomic, assign) NSInteger unit;
@property (nonatomic, assign) NSInteger level;

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
        if ([dataDic[@"recommend"] integerValue] > [dataDic[@"deal"] integerValue] && [dataDic[@"recommend"] integerValue] > [dataDic[@"visit"] integerValue]) {
            
            _unit = [dataDic[@"recommend"] integerValue];
        }else if ([dataDic[@"visit"] integerValue] > [dataDic[@"deal"] integerValue] && [dataDic[@"visit"] integerValue] > [dataDic[@"recommend"] integerValue]){
            
            _unit = [dataDic[@"visit"] integerValue];
        }else{
            
            _unit = [dataDic[@"deal"] integerValue];
        }
        
        _level = 1;
        do {
            
            if (_unit / 5 > 10 && _unit / 10 < 10) {
                
                _unit = _unit / 10;
                _level = _level * 10;
            }else{
                
                _unit = _unit / 5;
                _level = _level * 5;
            }
        } while (_unit > 10);
        
        _singleBarChartView.yScaleValue = _level;
    }else{
        
        _singleBarChartView.yValuesArr = [@[@"0",@"0",@"0"] mutableCopy];
        _singleBarChartView.yScaleValue = 1;
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
