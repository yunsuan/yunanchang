//
//  SaleRankOrderCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SaleRankOrderCell.h"

@interface SaleRankOrderCell ()<SingleBarChartViewDelegate>

@property (nonatomic, assign) NSInteger unit;
@property (nonatomic, assign) NSInteger level;

@end

@implementation SaleRankOrderCell

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

    
    _singleBarChartView.xValuesArr = [@[] mutableCopy];
    _singleBarChartView.yValuesArr = [@[] mutableCopy];
    _singleBarChartView.yScaleValue = 1;
    for (int i = 0; i < [dataDic[@"subSort"] count]; i++) {
        
        [_singleBarChartView.xValuesArr addObject:dataDic[@"subSort"][i][@"name"]];
        [_singleBarChartView.yValuesArr addObject:[NSString stringWithFormat:@"%@",dataDic[@"subSort"][i][@"count"]]];
        if (i == 0) {
            
            _unit = [dataDic[@"subSort"][i][@"count"] integerValue];
        }else{
            
            if (_unit > [dataDic[@"subSort"][i][@"count"] integerValue]) {
                
                _unit = [dataDic[@"subSort"][i][@"count"] integerValue];
            }
        }
        if (_unit < 1) {
            
            _unit = 1;
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
    }
    

    _singleBarChartView.unit = @"人";
}

- (void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index{
    
    NSLog(@"111111111111%ld",index);
    if (self.saleRankOrderCellBlock) {
        
        self.saleRankOrderCellBlock(index);
    }
}

- (void)initUI{
    
    _singleBarChartView = [[SingleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _singleBarChartView.backgroundColor = CLWhiteColor;
//    _singleBarChartView.yScaleValue = 60 *SIZE;

    [self.contentView addSubview:_singleBarChartView];
}


@end
