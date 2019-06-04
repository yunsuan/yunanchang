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
    _pieChartView.titlesArr = @[@"小麦",
                                @"玉米",
                                @"大豆",
                                @"早籼稻",
                                @"旱籼稻",
                                @"小麦",
                                @"玉米",
                                @"大豆",
                                @"早籼稻",
                                @"旱籼稻"];//标题数组
    _pieChartView.percentageArr = @[@"0.05",@"0.2",@"0.07",@"0.1",@"0.15",@"0.1",@"0.08",@"0.12",@"0.13"];
}

- (void)initUI{
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_header];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 240 *SIZE)];
//    pieChartView.bounds = CGRectMake(0, 0, 400, 400);
//    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
//    pieChartView.center = self.view.center;
    //标题数组与颜色数组个数应一致，如果标题数组过多，颜色数组自己可随机生成。
    [self.contentView addSubview:_pieChartView];
}


@end
