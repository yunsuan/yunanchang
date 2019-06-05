//
//  ChannelMutiLineCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelMutiLineCell.h"

#import "MutiLineChartView.h"

@interface ChannelMutiLineCell ()

@property (nonatomic, strong) MutiLineChartView *mutiLineChartView;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, assign) NSInteger level;

@end

@implementation ChannelMutiLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
//    mutipleLineChartView.xValuesArr = [@[@"2015",@"2016",@"2018",@"2019",
//                                         @"2020",@"2021",@"2022",@"2023",
//                                         @"2024",@"2025",@"2026",@"2027"] mutableCopy];
//    mutipleLineChartView.yValuesArr = [@[@[@"200",@"90",@"150"],
//                                         @[@"80",@"210",@"250"],
//                                         @[@"100",@"200",@"300"],
//                                         @[@"200",@"150",@"30"],
//                                         @[@"70",@"50",@"335"],
//                                         @[@"90",@"200",@"220"],
//                                         @[@"190",@"200",@"170"],
//                                         @[@"160",@"450",@"235"],
//                                         @[@"150",@"330",@"368"],
//                                         @[@"160",@"222",@"258"],
//                                         @[@"100",@"198",@"263"],
//                                         @[@"170",@"192",@"356"],] mutableCopy];
//    mutipleLineChartView.legendTitlesArr =[ @[@"小麦",@"玉米",@"大豆"] mutableCopy];
//    mutipleLineChartView.unit = @"吨";
//    mutipleLineChartView.delegate = self;
//    //    barChartView.yScaleValue=60;
//    mutipleLineChartView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 300);
    [_mutiLineChartView removeFromSuperview];
    
    _mutiLineChartView = [[MutiLineChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutiLineChartView.backgroundColor = CLWhiteColor;
    _mutiLineChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]] mutableCopy];
    [self.contentView addSubview:_mutiLineChartView];
    
    [_mutiLineChartView.yValuesArr removeAllObjects];
    [_mutiLineChartView.legendTitlesArr removeAllObjects];
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"yearCount"][@"count"][@"list"] count]; i++) {
        
        [tempArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"month"]];
    }
    _mutiLineChartView.xValuesArr = tempArr;
    
    
    NSMutableArray *allArr = [@[] mutableCopy];
    //    NSMutableArray *visitArr = [@[] mutableCopy];
    //    NSMutableArray *dealArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"yearCount"][@"count"][@"list"] count]; i++) {
        
        NSMutableArray *singleArr = [@[] mutableCopy];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"]];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"]];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"]];
        [allArr addObject:singleArr];
        if (i == 0) {
            
            if ([dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] && [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue]) {
                
                _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue];
            }else if([dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] && [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue]){
                
                _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue];
            }else{
                
                _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue];
            }
        }else{
            
            if ([dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] && [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue]) {
                
                if (_unit < [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue]) {
                    
                    _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue];
                }
            }else if([dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"] integerValue] && [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue] > [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue]){
                
                if (_unit < [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue]) {
                    
                    _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"] integerValue];
                }
            }else{
                
                if (_unit < [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue]) {
                    
                    _unit = [dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"] integerValue];
                }
            }
        }
    }
    
    if (allArr.count) {
        
        _mutiLineChartView.yValuesArr = allArr;
    }else{
        
        _mutiLineChartView.yValuesArr = [@[@[],@[],@[]] mutableCopy];
    }
    
    if (dataDic.count) {
        
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
        
        _mutiLineChartView.yAxiasValus = _level;
    }else{
        
        _mutiLineChartView.yAxiasValus = 1;
    }
    
    NSMutableArray *recommendNameArr = [@[] mutableCopy];
    for (int i = 0; i < 3; i++) {
        
        if (i == 0) {
            
            [recommendNameArr addObject:@"推荐客户"];
        }else if (i == 1){
            
            [recommendNameArr addObject:@"到访客户"];
        }else{
            
            [recommendNameArr addObject:@"成交客户"];
        }
        //        [recommendNameArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"month"]];
    }
    _mutiLineChartView.legendTitlesArr = recommendNameArr;
}

- (void)initUI{
    
    _mutiLineChartView = [[MutiLineChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutiLineChartView.backgroundColor = CLWhiteColor;
    [self.contentView addSubview:_mutiLineChartView];
}

@end
