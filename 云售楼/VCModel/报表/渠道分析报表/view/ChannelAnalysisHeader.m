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
    
    _header.titleL.text = @"客户来源";
    
    _mutipleBarChartView.xValuesArr = [@[@"推荐客户",@"到访客户",@"成交客户"] mutableCopy];
    _mutipleBarChartView.yValuesArr = [@[@[@"100",@"200"],
                                         @[@"80",@"210"],
                                         @[@"200",@"300"]] mutableCopy];
    _mutipleBarChartView.unit = @"人";
    //    mutipleBarChartView.delegate = self;
    _mutipleBarChartView.legendTitlesArr = @[@"分销",@"全民"];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.channelAnalysisHeaderBlock) {
        
        self.channelAnalysisHeaderBlock();
    }
}

- (void)initUI{
    
    _header = [[TitleRightBtnHeader alloc] initWithFrame:CGRectMake(0, 240 *SIZE, SCREEN_Width, 40 *SIZE)];
    _header.addBtn.hidden = YES;
    [_header.moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_header];
    
    _mutipleBarChartView = [[SSWMutipleBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutipleBarChartView.backgroundColor = CLWhiteColor;
    //    barChartView.yScaleValue=60;
    _mutipleBarChartView.barColorArr = [@[[UIColor blueColor],[UIColor greenColor]] mutableCopy];
    [self.contentView addSubview:_mutipleBarChartView];
}


@end
