//
//  VisitCustomHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomHeader.h"

#import "SSWPieChartView.h"


@interface VisitCustomHeader ()

@property (nonatomic, strong) SSWPieChartView *pieChartView;

@end

@implementation VisitCustomHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _header.titleL.text = @"客户来源";
    
    [_pieChartView removeFromSuperview];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    if (dataDic.count) {
        
//        //标题数组与颜色数组个数应一致，如果标题数组过多，颜色数组自己可随机生成。
//        _pieChartView.colorsArr= @[[UIColor orangeColor],
//                                   [UIColor redColor],
//                                   [UIColor blueColor],
//                                   [UIColor grayColor],
//                                   [UIColor greenColor],
//                                   [UIColor blackColor],
//                                   [UIColor grayColor],
//                                   [UIColor darkGrayColor],
//                                   [UIColor grayColor],
//                                   [UIColor yellowColor]];//颜色数组
//        _pieChartView.titlesArr = @[@"小麦",
//                                    @"玉米",
//                                    @"大豆",
//                                    @"早籼稻",
//                                    @"旱籼稻",
//                                    @"小麦",
//                                    @"玉米",
//                                    @"大豆",
//                                    @"早籼稻",
//                                    @"旱籼稻"];//标题数组
//        _pieChartView.percentageArr = @[@"0.05",@"0.2",@"0.07",@"0.1",@"0.15",@"0.1",@"0.08",@"0.12",@"0.13"];
        NSInteger all = [dataDic[@"auto_visit"] integerValue] + [dataDic[@"company"] integerValue] + [dataDic[@"person"] integerValue];
        if (all) {
            
            _pieChartView.colorsArr= CLArr;
//            _pieChartView.titlesArr = @[@"自然来访",@"渠道分销",@"全民营销"];//标题数组
            
            
            
            NSString *visit = [dataDic[@"auto_visit"] integerValue] == 0? @"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"auto_visit"] floatValue]/ all];
            NSString *company = [dataDic[@"company"] integerValue] == 0? @"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"company"] floatValue]/ all];
            NSString *person = [dataDic[@"person"] integerValue] == 0? @"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"person"] floatValue]/ all];
            
            NSMutableArray *nameArr = [@[] mutableCopy];
            NSMutableArray *tempArr = [@[] mutableCopy];
            if ([visit integerValue]) {
                
                [nameArr addObject:@"自然来访"];
                [tempArr addObject:visit];
            }
            if ([company integerValue]) {
                
                [nameArr addObject:@"渠道分销"];
                [tempArr addObject:company];
            }
            if ([person integerValue]) {
                
                [nameArr addObject:@"全民营销"];
                [tempArr addObject:person];
            }
            _pieChartView.titlesArr = nameArr;
            _pieChartView.percentageArr = tempArr; //@[visit,company,person];
        }
    }
    
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _header.titleL.text = @"意向物业";
    
    [_pieChartView removeFromSuperview];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    if (dataArr.count) {
        
        NSInteger index = 0;
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < dataArr.count; i++) {
        
            
            index = index + [dataArr[i][@"count"] integerValue];
        }
        if (index) {
            
            _pieChartView.colorsArr = CLArr;
            
            
            NSMutableArray *percentArr = [@[] mutableCopy];
            for (int i = 0; i < dataArr.count; i++) {
                
                float x = [dataArr[i][@"count"] floatValue] / index;
                if (x > 0) {
                    
                    [tempArr addObject:dataArr[i][@"config_name"]];
                    [percentArr addObject:[NSString stringWithFormat:@"%.2f",x]];
                }
            }
            _pieChartView.titlesArr = tempArr;
            _pieChartView.percentageArr = percentArr;
        }
    }
}

- (void)setApproachArr:(NSArray *)approachArr{
    
    [_pieChartView removeFromSuperview];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    if (approachArr.count) {
        
        NSInteger index = 0;
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < approachArr.count; i++) {
            
            [tempArr addObject:approachArr[i][@"listen_way"]];
            index = index + [approachArr[i][@"count"] integerValue];
        }
        if (index) {
            
            _pieChartView.colorsArr = CLArr;
            
            
            _pieChartView.titlesArr = tempArr;
            NSMutableArray *percentArr = [@[] mutableCopy];
            for (int i = 0; i < approachArr.count; i++) {
                
                float x = [approachArr[i][@"count"] floatValue] / index;
                if (x > 0) {
                    
                    [percentArr addObject:[NSString stringWithFormat:@"%.2f",x]];
                }
            }
            _pieChartView.percentageArr = percentArr;
        }
    }
}

- (void)setPropertyArr:(NSArray *)propertyArr{
    
    [_pieChartView removeFromSuperview];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    if (propertyArr.count) {
        
        NSInteger index = 0;
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < propertyArr.count; i++) {
            
            [tempArr addObject:propertyArr[i][@"option_name"]];
            index = index + [propertyArr[i][@"count"] integerValue];
        }
        if (index) {
            
            _pieChartView.colorsArr = CLArr;
            
            
            _pieChartView.titlesArr = tempArr;
            NSMutableArray *percentArr = [@[] mutableCopy];
            for (int i = 0; i < propertyArr.count; i++) {
                
                float x = [propertyArr[i][@"count"] floatValue] / index;
                if (x > 0) {
                    
                    [percentArr addObject:[NSString stringWithFormat:@"%.2f",x]];
                }
            }
            _pieChartView.percentageArr = percentArr;
        }
    }
}

- (void)initUI{
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_header];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
}


@end
