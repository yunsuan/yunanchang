//
//  ChannelMutiChartCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelMutiChartCell.h"

#import "MutiBarChartView.h"

@interface ChannelMutiChartCell ()

@property (nonatomic, strong) MutiBarChartView *mutiBarChartView;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, assign) NSInteger level;

@end

@implementation ChannelMutiChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_mutiBarChartView removeFromSuperview];

    _mutiBarChartView = [[MutiBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutiBarChartView.backgroundColor = CLWhiteColor;
    _mutiBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]] mutableCopy];
    [self.contentView addSubview:_mutiBarChartView];

    [_mutiBarChartView.yValuesArr removeAllObjects];
    [_mutiBarChartView.legendTitlesArr removeAllObjects];

    NSMutableArray *tempArr = [@[] mutableCopy];
//    for (int i = 0; i < [dataDic[@"yearCount"][@"count"][@"list"] count]; i++) {
//
//        [tempArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"month"]];
//    }
//    _mutiBarChartView.xValuesArr = tempArr;
    if (dataDic.count) {
        
        _mutiBarChartView.xValuesArr = [@[@"推荐客户",@"到访客户",@"成交客户"] mutableCopy];
    }else{
        
        _mutiBarChartView.xValuesArr = tempArr;
    }
    


    NSMutableArray *recommendArr = [@[] mutableCopy];
    NSMutableArray *visitArr = [@[] mutableCopy];
    NSMutableArray *dealArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"source"] count]; i++) {
        
//        NSMutableArray *singleArr = [@[] mutableCopy];
        [recommendArr addObject:dataDic[@"source"][i][@"count"][@"recommend"]];
        [visitArr addObject:dataDic[@"source"][i][@"count"][@"visit"]];
        [dealArr addObject:dataDic[@"source"][i][@"count"][@"deal"]];
//        [allArr addObject:singleArr];
        if (i == 0) {
            
            if ([dataDic[@"source"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"source"][i][@"count"][@"visit"] integerValue] && [dataDic[@"source"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"source"][i][@"count"][@"deal"] integerValue]) {
                
                _unit = [dataDic[@"source"][i][@"count"][@"recommend"] integerValue];
            }else if([dataDic[@"source"][i][@"count"][@"visit"] integerValue] > [dataDic[@"source"][i][@"count"][@"recommend"] integerValue] && [dataDic[@"source"][i][@"count"][@"visit"] integerValue] > [dataDic[@"source"][i][@"count"][@"deal"] integerValue]){
                
                _unit = [dataDic[@"source"][i][@"count"][@"visit"] integerValue];
            }else{
                
                _unit = [dataDic[@"source"][i][@"count"][@"deal"] integerValue];
            }
        }else{
            
            if ([dataDic[@"source"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"source"][i][@"count"][@"visit"] integerValue] && [dataDic[@"source"][i][@"count"][@"recommend"] integerValue] > [dataDic[@"source"][i][@"count"][@"deal"] integerValue]) {
                
                if (_unit < [dataDic[@"source"][i][@"count"][@"recommend"] integerValue]) {
                    
                    _unit = [dataDic[@"source"][i][@"count"][@"recommend"] integerValue];
                }
            }else if([dataDic[@"source"][i][@"count"][@"visit"] integerValue] > [dataDic[@"source"][i][@"count"][@"recommend"] integerValue] && [dataDic[@"source"][i][@"count"][@"visit"] integerValue] > [dataDic[@"source"][i][@"count"][@"deal"] integerValue]){
                
                if (_unit < [dataDic[@"source"][i][@"count"][@"visit"] integerValue]) {
                    
                    _unit = [dataDic[@"source"][i][@"count"][@"visit"] integerValue];
                }
            }else{
                
                if (_unit < [dataDic[@"source"][i][@"count"][@"deal"] integerValue]) {
                    
                    _unit = [dataDic[@"source"][i][@"count"][@"deal"] integerValue];
                }
            }
        }
    }
    
    _mutiBarChartView.yValuesArr = [@[recommendArr,visitArr,dealArr] mutableCopy];
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
        
        _mutiBarChartView.yAxiasValus = _level;
    }else{
        
        _mutiBarChartView.yAxiasValus = 1;
    }
    
    NSMutableArray *recommendNameArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"source"] count]; i++) {
        
        //        if (i == 0) {
        //
        //            [recommendNameArr addObject:@"推荐客户"];
        //        }else if (i == 1){
        //
        //            [recommendNameArr addObject:@"到访客户"];
        //        }else{
        //
        //            [recommendNameArr addObject:@"成交客户"];
        //        }
        [recommendNameArr addObject:dataDic[@"source"][i][@"name"]];
    }
    _mutiBarChartView.legendTitlesArr = recommendNameArr;

//    _mutipleBarChartView.unit = @"人";
}

- (void)initUI{
    
    _mutiBarChartView = [[MutiBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutiBarChartView.backgroundColor = CLWhiteColor;
    //    barChartView.yScaleValue=60;
    _mutiBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor]] mutableCopy];
    [self.contentView addSubview:_mutiBarChartView];
}

@end
