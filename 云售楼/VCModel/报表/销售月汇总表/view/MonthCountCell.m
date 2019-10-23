//
//  MonthCountCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MonthCountCell.h"

@interface MonthCountCell ()
{
    
    NSDateFormatter *_monthFormatter;
}

@end

@implementation MonthCountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _monthFormatter = [[NSDateFormatter alloc] init];
        [_monthFormatter setDateFormat:@"MM"];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    if (dataArr.count) {
        
        //折线图数据
        _chartView.leftDataArr = @[dataArr];
    }else{
        
        _chartView.leftDataArr = @[@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    }
    [_chartView reShow];
}

- (void)initUI{
    
    _chartView = [[LHYChartView alloc]initWithFrame:CGRectMake(20 *SIZE, 20 *SIZE, SCREEN_Width  - 40 *SIZE, 220 *SIZE)];
        //是否默认选中第一个
    //    _chartView.isShowFirstPaoPao = YES;
    _chartView.isSelect = NO;
    
    _chartView.showPaoPaoForIndex = [MonthDic[[_monthFormatter stringFromDate:[NSDate date]]] integerValue];
    //是否有网格
    _chartView.isGrid = YES;
    //是否显示所有点
    _chartView.isShow = YES;
    //是否可以浮动
    _chartView.isFloating = NO;
    //显示多少行
    _chartView.row = 11;
    //显示多少列
    _chartView.xRow = 14;
    //设置X轴坐标字体大小
    _chartView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    _chartView.x_Color = [UIColor colorWithHexString:@"#999999"];
    //设置Y轴坐标字体大小
    _chartView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    _chartView.y_Color = [UIColor colorWithHexString:@"#999999"];
    //设置背景颜色
    _chartView.backgroundColor = [UIColor whiteColor];
    //边框标线颜色
//    _chartView.borderLineColor = [UIColor colorWithHexString:@"#999999"];
    //中间标线颜色
//    _chartView.middleLineColor = [UIColor colorWithHexString:@"#cbcbcb" andAlpha:0.5];        //边框三角颜色
    _chartView.borderTriangleColor = [UIColor colorWithHexString:@"#999999"];
    //设置泡泡背景颜色
    _chartView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.85];
    _chartView.markColor = [UIColor colorWithHexString:@"#333333"];
    //设置泡泡的标题颜色
    _chartView.paopaoTitleColor = [UIColor whiteColor];
    //设置折线样式
    _chartView.chartViewStyle = LHYChartViewMoreClickLine;
    //设置图层效果
    _chartView.chartLayerStyle = LHYChartGradient;
    //设置折现效果
    _chartView.lineLayerStyle = LHYLineLayerNone;
    
    _chartView.lineWidth = 3;
    
    _chartView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#111111" andAlpha:0.8];
    //渐变开始比例
    _chartView.proportion = 1;
    
    _chartView.isShowBezier = YES;
    //折线图是否从零点开始画
    _chartView.hiddenZreo = YES;
    //设置颜色
    _chartView.leftColorStrArr = @[@"#6dd89c",@"#00a1eb",@"#bc69e0",@"#385af0"];
    //是否显示Y轴零位
    _chartView.isShowZero = YES;
    //泡泡是否跟随屏幕滑动而滑动
    _chartView.paopaoFollowSliding = NO;
//       //折线图数据
//        _chartView.leftDataArr = @[@[@"-9999.4",@"30907",@"32010",@"33450",@"30069",@"31574",@"30692",@"33156",@"29808",@"31846",@"29772",@"29630"]];
    _chartView.leftDataArr = @[@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    //底部日期
    _chartView.dataArrOfX = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
//    //返回泡泡选中值
//    _chartView.returnPaoPaoDataBlock = ^(NSArray *array, NSString *title) {
//        NSLog(@"%@-----%@",array,title);
//    };
//    _chartView.paopaoDataColors = @[[UIColor colorWithHexString:@"#6dd89c"],[UIColor colorWithHexString:@"#00a1eb"],[UIColor colorWithHexString:@"#bc69e0"],[UIColor colorWithHexString:@"#385af0"]];
//    //泡泡数据
//    _chartView.paopaoDataArray = @[@[@"-10,000元m²",@"30,907元m²",@"32,010元m²",@"33,450元m²",@"30,069元m²",@"31,574元m²",@"30,692元m²",@"33,156元m²",@"29,808元m²",@"31,846元m²",@"29,772元m²",@"29,630元m²"],@[@"46,175元m²",@"44,915元m²",@"36,228元m²",@"50,473元m²",@"28,811元m²",@"11,876元m²",@"23,213元m²",@"26,847元m²",@"27,905元m²",@"9,562元m²",@"34,263元m²",@"25,459元m²"],@[@"20,549元m²",@"15,981元m²",@"23,375元m²",@"20,516元m²",@"19,208元m²",@"15,121元m²",@"13,776元m²",@"16,282元m²",@"30,748元m²",@"26,531元m²",@"31,298元m²",@"33,183元m²"],@[@"11,053元m²",@"25,811元m²"]];
    //开始画图
    [_chartView show];
    [self.contentView addSubview:_chartView];
}

@end
