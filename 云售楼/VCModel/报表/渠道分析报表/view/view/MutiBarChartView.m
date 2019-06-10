//
//  MutiBarChartView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MutiBarChartView.h"

@interface MutiBarChartView (){
    
    CGFloat         _totalWidth;
    CGFloat         _totalHeight;
    CAShapeLayer  *_lineLayer;//刻度layer;
}
@property(nonatomic)UIScrollView    *scrollView;
@property(nonatomic)UIView          *contentView;
@property(nonatomic)UILabel         *unitLab;
@property(nonatomic)NSMutableArray  *totalPointArr;
@property(nonatomic)NSMutableArray      *barsStartPointsArr;
@property(nonatomic)NSMutableArray      *barsEndPointsArr;
@property(nonatomic)NSMutableArray      *barsLayersArr;

@end

@implementation MutiBarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.barColorArr = [@[] mutableCopy];
    self.totalPointArr = [@[] mutableCopy];
    
    self.barsStartPointsArr  = [@[] mutableCopy];
    self.barsEndPointsArr = [@[] mutableCopy];
    self.barsLayersArr = [@[] mutableCopy];
    
    self.barWidth = 40 *SIZE;
    self.gapWidth = 30 *SIZE;
    self.yAxiasCount = 10;
    self.yAxiasValus = 20;
    self.showEachYValus=YES;
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    
    [self addTap];
}
- (void)addTap{
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)ges{
    
    //    CGPoint  point = [ges locationInView:self.contentView];
    //    for (int i = 0 ; i<self.totalPointArr.count; i++) {
    //        NSArray  *tempArr = self.totalPointArr[i];
    //        for (int j=0; j<tempArr.count; j++) {
    //            CGPoint  startPoint = [tempArr[j][0] CGPointValue];
    //            CGPoint  endPoint = [tempArr[j][1] CGPointValue];
    //            if (point.x>=startPoint.x-self.barWidth/2&&point.x<=startPoint.x+self.barWidth/2&&point.y>=endPoint.y&&point.y<=startPoint.y) {
    //                if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectMutipleBarChartIndex:)]) {
    //                    [self.delegate SSWChartView:self didSelectMutipleBarChartIndex:@[@(i),@(j)]];
    //                }
    //            }
    //        }
    //    }
}


- (void)setUnit:(NSString *)unit{
    
    _unit = unit;
    self.unitLab.text = [NSString stringWithFormat:@"单位:%@",unit];
}
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]init];
        //        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}
- (UILabel *)unitLab{
    
    if (!_unitLab) {
        
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = [UIFont systemFontOfSize:10];
        //        _unitLab.textAlignment = NSTextAlignmentCenter;
    }
    return _unitLab;
}
-(void)layoutSubviews{
    
    self.scrollView.frame = self.bounds;
    if (self.yValuesArr.count) {
        
        _totalWidth = ([self.yValuesArr[0] count] * self.barWidth) * self.xValuesArr.count + ( self.xValuesArr.count + 1) * self.gapWidth;
    }else{
        
        _totalWidth = (self.xValuesArr.count + 1) * self.gapWidth;
    }
    
    _totalHeight = self.bounds.size.height - 20 *SIZE - 30*SIZE;
    self.scrollView.contentSize = CGSizeMake(30 *SIZE + _totalWidth, 0);
    self.contentView.frame = CGRectMake(30 *SIZE, 20 *SIZE, _totalWidth, _totalHeight);
    self.unitLab.frame = CGRectMake(5 *SIZE, 0, 80 *SIZE, 20 *SIZE);
    [self clear];
    [self drawAxias];
    [self addYAxaisLabs];
    [self addXAxiasLabs];
    [self addBars];
    [self addLegends];
    [self showBarChartYValus];
    
}

//当触发界面重新布局的时候先移除之前的绘制
-(void)clear{
    [self.barsStartPointsArr removeAllObjects];
    [self.barsEndPointsArr removeAllObjects];
    for (CAShapeLayer *layer in self.barsLayersArr) {
        [layer removeFromSuperlayer];
    }
    [self.barsLayersArr removeAllObjects];
    [_lineLayer removeFromSuperlayer];
    _lineLayer=nil;
    for (UIView *view in self.contentView.subviews) {
        if([view isEqual:self.unitLab])continue;
        [view removeFromSuperview];
        
    }
}
//画坐标轴
-(void)drawAxias{
    
    UIBezierPath   *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画Y轴的箭头
    [path moveToPoint:CGPointMake(-5 *SIZE, 5 *SIZE)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(5 *SIZE, 5 *SIZE)];
    //画X轴的箭头
    [path moveToPoint:CGPointMake(_totalWidth - 5 *SIZE, _totalHeight - 5 *SIZE)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth - 5 *SIZE, _totalHeight + 5 *SIZE)];
    //画y轴的刻度
    for (int i = (int)self.yAxiasCount; i > 0; i--) {
        
        [path moveToPoint:CGPointMake(0, i * (_totalHeight/self.yAxiasCount))];
        [path addLineToPoint:CGPointMake(5 *SIZE, i * (_totalHeight/self.yAxiasCount))];
    }
    //画x轴的刻度
    for (int i = 0; i < self.xValuesArr.count; i++) {
        
        [path moveToPoint:CGPointMake(self.gapWidth + ([self.yValuesArr[0] count] * self.barWidth + self.gapWidth) * i, _totalHeight)];
        [path addLineToPoint:CGPointMake(self.gapWidth + ([self.yValuesArr[0] count] * self.barWidth + self.gapWidth) * i, _totalHeight - 5 *SIZE)];
    }
    CAShapeLayer *axiasLayer = [CAShapeLayer layer];
    axiasLayer.strokeColor = [UIColor grayColor].CGColor;
    axiasLayer.fillColor = [UIColor clearColor].CGColor;
    axiasLayer.lineWidth = SIZE;
    axiasLayer.path = path.CGPath;
    [self.contentView.layer addSublayer:axiasLayer];
}
//添加y轴的坐标值显示
-(void)addYAxaisLabs{
    
    for (int i = 0 ; i < self.yAxiasCount; i++) {
        
        UILabel  *lab = [[UILabel alloc]init];
        lab.text = [NSString stringWithFormat:@"%ld",self.yAxiasValus * (self.yAxiasCount - i)];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:10 *SIZE];
        lab.frame = CGRectMake(-5 *SIZE, i * (_totalHeight/self.yAxiasCount) - 10 *SIZE, -25 *SIZE, 20 *SIZE);
        [self.contentView addSubview:lab];
    }
}
//添加x轴的坐标值显示
-(void)addXAxiasLabs{
    
    for (int i = 0; i < self.xValuesArr.count; i++) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:10 *SIZE];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.xValuesArr[i];
        lab.frame = CGRectMake(i * ([self.yValuesArr[i] count] * self.barWidth + self.gapWidth) + self.gapWidth, _totalHeight, [self.yValuesArr[i] count] * self.barWidth, 30 *SIZE);
        lab.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:lab];
    }
}
//添加柱形条
-(void)addBars{
    //判断条形图是否设置颜色数组
    [self.barColorArr removeAllObjects];
    if (self.barColorArr.count <= 0 && self.yValuesArr.count > 0) {
        
        for (int i = 0 ; i < [self.yValuesArr[0] count]; i++) {
            [self.barColorArr addObject:CLArr[i]];
        }
    }
    
    for (int i = 0; i < self.xValuesArr.count; i++) {
        CGPoint  startPoint;
        CGPoint  endPoint;
        NSMutableArray  *endPointArr = [@[] mutableCopy];
        NSMutableArray  *pointArr = [@[] mutableCopy];
        for (int j = 0 ; j < [self.yValuesArr[i] count]; j++) {
            
            startPoint = CGPointMake(self.gapWidth + i * ([self.yValuesArr[i] count] * self.barWidth + self.gapWidth) + self.barWidth/2 + j * self.barWidth, _totalHeight);
            endPoint = CGPointMake(self.gapWidth + i * ([self.yValuesArr[i] count] * self.barWidth + self.gapWidth) + self.barWidth/2 + j * self.barWidth, _totalHeight - [self.yValuesArr[i][j] floatValue] * _totalHeight/(self.yAxiasCount * self.yAxiasValus));
            [pointArr addObject:@[[NSValue valueWithCGPoint:startPoint],[NSValue valueWithCGPoint:endPoint]]];
            [endPointArr addObject:[NSValue valueWithCGPoint:endPoint]];
            
            //绘制条形图
            UIBezierPath  *layerPath = [UIBezierPath bezierPath];
            [layerPath moveToPoint:startPoint];
            [layerPath addLineToPoint:endPoint];
            
            CAShapeLayer  *layer = [CAShapeLayer layer];
            layer.lineWidth = self.barWidth;
            layer.strokeColor = [self.barColorArr[j] CGColor];
            layer.path = layerPath.CGPath;
            //            [layer addAnimation:[self animationWithDuration:(i+1)*0.3] forKey:nil];
            [self.contentView.layer addSublayer:layer];
        }
        [self.totalPointArr addObject:pointArr];
        [self.barsEndPointsArr addObject:endPointArr];
    }
    
}

//显示每个柱形图的值
-(void)showBarChartYValus{
    
    if(!self.showEachYValus)return;
    
    for (int i = 0; i < self.xValuesArr.count; i++) {
        
        for (int j = 0; j < [self.yValuesArr[i] count]; j++) {
            
            CGPoint  point = [self.barsEndPointsArr[i][j] CGPointValue];
            UILabel  *lab = [[UILabel alloc]init];
            lab.textColor = [UIColor lightGrayColor];//self.barCorlor;
            lab.font = [UIFont systemFontOfSize:10 *SIZE];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = [NSString stringWithFormat:@"%@",self.yValuesArr[i][j]];
            lab.bounds = CGRectMake(0, 0, self.barWidth + self.gapWidth * 4 / 5, 20 *SIZE);
            lab.center = CGPointMake(point.x, point.y-10);
            [self.contentView addSubview:lab];
        }
    }
}

//添加图例
-(void)addLegends{
    for (int i = 0; i < self.legendTitlesArr.count; i++) {
        
        UIView  *lengendView = [[UIView alloc]init];
        //        lengendView.backgroundColor = [UIColor blackColor];
        lengendView.frame = CGRectMake(i * 60 *SIZE,0, 60 *SIZE, -20 *SIZE);
        [self.contentView addSubview:lengendView];
        UILabel  *legendLab = [[UILabel alloc]init];
        legendLab.text = self.legendTitlesArr[i];
        legendLab.frame = CGRectMake(15 *SIZE,0,lengendView.bounds.size.width - 15 *SIZE, lengendView.bounds.size.height);
        legendLab.font = [UIFont systemFontOfSize:10 *SIZE];
        [lengendView addSubview:legendLab];
        
        UILabel  *lengendLayer = [[UILabel alloc]init];;
        if (self.barColorArr.count) {
            
            lengendLayer.backgroundColor = self.barColorArr[i] ;
        }
        
        lengendLayer.frame = CGRectMake(0, lengendView.bounds.size.height/2- 5 *SIZE, 10 *SIZE, 10 *SIZE);
        [lengendView addSubview:lengendLayer];
    }
}
@end
