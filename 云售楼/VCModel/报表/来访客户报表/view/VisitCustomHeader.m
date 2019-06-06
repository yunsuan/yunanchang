//
//  VisitCustomHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomHeader.h"

#import "BaseHeader.h"
#import "SSWPieChartView.h"


@interface VisitCustomHeader ()

@property (nonatomic, strong) BaseHeader *header;

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
    
    _pieChartView.colorsArr= @[[UIColor orangeColor],
                               [UIColor redColor],
                               [UIColor blueColor],
                               [UIColor grayColor],
                               [UIColor greenColor],
                               [UIColor blackColor],
                               [UIColor grayColor],
                               [UIColor darkGrayColor],
                               [UIColor grayColor],
                               [UIColor yellowColor]];//颜色数组
    _pieChartView.titlesArr = @[@"自然来访",@"渠道分销",@"全民营销"];//标题数组
    
    NSString *visit = [dataDic[@"auto_visit"] floatValue]?@"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"auto_visit"] floatValue]/([dataDic[@"auto_visit"] floatValue] + [dataDic[@"company"] floatValue] + [dataDic[@"person"] floatValue])];
    NSString *company = [dataDic[@"company"] floatValue]?@"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"company"] floatValue]/([dataDic[@"auto_visit"] floatValue] + [dataDic[@"company"] floatValue] + [dataDic[@"person"] floatValue])];
    NSString *person = [dataDic[@"person"] floatValue]?@"0":[NSString stringWithFormat:@"%.2f",[dataDic[@"person"] floatValue]/([dataDic[@"auto_visit"] floatValue] + [dataDic[@"company"] floatValue] + [dataDic[@"person"] floatValue])];
    
    _pieChartView.percentageArr = @[visit,company,person];
//    _pieChartView.percentageArr = @[[NSString stringWithFormat:@"%@",[dataDic[@"auto_visit"]],[NSString stringWithFormat:@"%@",dataDic[@"company"]],[NSString stringWithFormat:@"%@",dataDic[@"person"]]];
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _header.titleL.text = @"意向单价";
    
    _pieChartView.colorsArr= @[[UIColor orangeColor],
                               [UIColor redColor],
                               [UIColor blueColor],
                               [UIColor grayColor],
                               [UIColor greenColor],
                               [UIColor blackColor],
                               [UIColor grayColor],
                               [UIColor darkGrayColor],
                               [UIColor grayColor],
                               [UIColor yellowColor]];//颜色数组
    
    NSInteger index = 0;
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < dataArr.count; i++) {
        
        [tempArr addObject:dataArr[i][@"config_name"]];
        index = index + [dataArr[i][@"count"] integerValue];
    }
    _pieChartView.titlesArr = tempArr;
    NSMutableArray *percentArr = [@[] mutableCopy];
    for (int i = 0; i < dataArr.count; i++) {
        
        float x = [dataArr[i][@"count"] floatValue] / index;
        [percentArr addObject:[NSString stringWithFormat:@"%.2f",x]];
    }
    _pieChartView.percentageArr = percentArr;
    
}

- (void)initUI{
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_header];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
}


@end
