//
//  ChannelAnalysisHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelAnalysisHeader.h"

#import "TitleRightBtnHeader.h"
#import "SSWMutipleBarChartView.h"

@interface ChannelAnalysisHeader ()

@property (nonatomic, strong) TitleRightBtnHeader *header;

@property (nonatomic, strong) SSWMutipleBarChartView *mutipleBarChartView;

@end

@implementation ChannelAnalysisHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_mutipleBarChartView removeFromSuperview];
    
    _mutipleBarChartView = [[SSWMutipleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutipleBarChartView.backgroundColor = CLWhiteColor;
    _mutipleBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor],[UIColor redColor],[UIColor orangeColor]] mutableCopy];
    [self.contentView addSubview:_mutipleBarChartView];
    
    [_mutipleBarChartView.yValuesArr removeAllObjects];
    [_mutipleBarChartView.legendTitlesArr removeAllObjects];
    
    _mutipleBarChartView.xValuesArr = [@[@"推荐客户",@"到访客户",@"成交客户"] mutableCopy];
    NSMutableArray *recommendArr = [@[] mutableCopy];
    NSMutableArray *visitArr = [@[] mutableCopy];
    NSMutableArray *dealArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"source"] count]; i++) {

        [recommendArr addObject:dataDic[@"source"][i][@"count"][@"recommend"]];
        [visitArr addObject:dataDic[@"source"][i][@"count"][@"visit"]];
        [dealArr addObject:dataDic[@"source"][i][@"count"][@"deal"]];
    }

    _mutipleBarChartView.yValuesArr = [@[recommendArr,
                                         visitArr,
                                         dealArr] mutableCopy];
    
    NSMutableArray *recommendNameArr = [@[] mutableCopy];
    for (int i = 0; i < [dataDic[@"source"] count]; i++) {

        [recommendNameArr addObject:dataDic[@"source"][i][@"name"]];
    }
    _mutipleBarChartView.legendTitlesArr = recommendNameArr;
    _mutipleBarChartView.unit = @"人";
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.channelAnalysisHeaderBlock) {
        
        self.channelAnalysisHeaderBlock();
    }
}

- (void)initUI{
    
    _header = [[TitleRightBtnHeader alloc] initWithFrame:CGRectMake(0, 240 *SIZE, SCREEN_Width, 40 *SIZE)];
    _header.addBtn.hidden = YES;
    _header.titleL.text = @"分销公司排行榜";
    [_header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_header.moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_header];
    
    _mutipleBarChartView = [[SSWMutipleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutipleBarChartView.backgroundColor = CLWhiteColor;
    //    barChartView.yScaleValue=60;
    _mutipleBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor]] mutableCopy];
    [self.contentView addSubview:_mutipleBarChartView];
}


@end
