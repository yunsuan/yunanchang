//
//  ChanelAnalysisChartCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChanelAnalysisChartCell.h"

#import "SSWMutipleBarChartView.h"

@interface ChanelAnalysisChartCell ()

@property (nonatomic, strong) SSWMutipleBarChartView *mutipleBarChartView;

@end

@implementation ChanelAnalysisChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_mutipleBarChartView removeFromSuperview];
    
    _mutipleBarChartView = [[SSWMutipleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutipleBarChartView.backgroundColor = CLWhiteColor;
    _mutipleBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]] mutableCopy];
    [self.contentView addSubview:_mutipleBarChartView];
    
    [_mutipleBarChartView.yValuesArr removeAllObjects];
    [_mutipleBarChartView.legendTitlesArr removeAllObjects];
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"yearCount"][@"count"][@"list"] count]; i++) {
        
        [tempArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"month"]];
    }
    _mutipleBarChartView.xValuesArr = tempArr;
    
    
    NSMutableArray *allArr = [@[] mutableCopy];
//    NSMutableArray *visitArr = [@[] mutableCopy];
//    NSMutableArray *dealArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"yearCount"][@"count"][@"list"] count]; i++) {

        NSMutableArray *singleArr = [@[] mutableCopy];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"recommend"]];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"visit"]];
        [singleArr addObject:dataDic[@"yearCount"][@"count"][@"list"][i][@"count"][@"deal"]];
        [allArr addObject:singleArr];
    }
    
    _mutipleBarChartView.yValuesArr = allArr;//[@[allArr] mutableCopy];
//    _mutipleBarChartView.yValuesArr = [allArr mutableCopy];
//    _mutipleBarChartView.yValuesArr = [@[recommendArr,
//                                         visitArr,
//                                         dealArr] mutableCopy];
    
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
    _mutipleBarChartView.legendTitlesArr = recommendNameArr;
    
    _mutipleBarChartView.unit = @"人";
}

- (void)initUI{
    
    _mutipleBarChartView = [[SSWMutipleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutipleBarChartView.backgroundColor = CLWhiteColor;
    //    barChartView.yScaleValue=60;
    _mutipleBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor]] mutableCopy];
    [self.contentView addSubview:_mutipleBarChartView];
}

@end
