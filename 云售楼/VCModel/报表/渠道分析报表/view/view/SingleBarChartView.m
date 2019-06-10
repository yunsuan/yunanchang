//
//  SingleBarChartView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SingleBarChartView.h"

@interface SingleBarChartView (){
    
    CGFloat   _totalWidth;
    CGFloat   _totalHeight;
    CAShapeLayer  *_lineLayer;//刻度layer;
}
@property(nonatomic)UIScrollView        *scrollView;
@property(nonatomic)UIView              *contentView;
@property(nonatomic)NSMutableArray      *barsStartPointsArr;
@property(nonatomic)NSMutableArray      *barsEndPointsArr;
@property(nonatomic)NSMutableArray      *barsLayersArr;
@property(nonatomic)UILabel             *unitLab;
@property(nonatomic,assign)BOOL         showEachYValus;//是否显示每个Y值

@end

@implementation SingleBarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
//    [self.contentView addSubview:self.bubbleLab];
    self.xValuesArr = [@[] mutableCopy];
    self.yValuesArr = [@[] mutableCopy];
    self.barsStartPointsArr  = [@[] mutableCopy];
    self.barsEndPointsArr = [@[] mutableCopy];
    self.barsLayersArr = [@[] mutableCopy];
    self.barWidth = 80 *SIZE;
    self.gapWidth = 20 *SIZE;
//    self.yScaleValue = 50;
    self.yAxisCount = 10;
    self.showEachYValus=YES;
    self.barCorlor = CLArr[0];
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    [self addTap];
}
-(void)setUnit:(NSString *)unit{
    
    _unit = unit;
    self.unitLab.hidden = YES;
    self.unitLab.text = [NSString stringWithFormat:@"单位:%@",unit];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.clipsToBounds=NO;
    }
    return _scrollView;
}
-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]init];
        //        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}
-(void)addTap{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self.contentView];
    for (int i = 0; i<self.barsStartPointsArr.count; i++) {
        CGPoint  startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint  endPoint = [self.barsEndPointsArr[i] CGPointValue];
        if (point.x >= startPoint.x-self.barWidth/2&&point.x<=startPoint.x+self.barWidth/2&&point.y>=endPoint.y&&point.y<=startPoint.y) {
            NSLog(@"点击了第%d个柱形图",i);
            //            self.bubbleLab.hidden=NO;
            //            self.bubbleLab.text = self.yValuesArr[i];
            //            self.bubbleLab.center = CGPointMake(endPoint.x, endPoint.y-10);
            //            CAShapeLayer  *selctedLayer = self.barsLayersArr[i];
            if (self.delegate && [self.delegate respondsToSelector:@selector(SingleBarChart:didSelectIndex:)]) {
                [self.delegate SingleBarChart:self didSelectIndex:i];
            }
        }
    }
}
-(UILabel *)unitLab{
    
    if (!_unitLab) {
        
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10 *SIZE];
    }
    return _unitLab;
}
-(void)layoutSubviews{
    
    self.scrollView.frame = self.bounds;
    self.unitLab.frame = CGRectMake(5 *SIZE, -10 *SIZE, 60 *SIZE, 20 *SIZE);
    _totalWidth = self.gapWidth + (self.barWidth + self.gapWidth) * self.xValuesArr.count;
    _totalHeight = self.scrollView.bounds.size.height - 30 *SIZE - 10 *SIZE;
    self.scrollView.contentSize = CGSizeMake(30 *SIZE + _totalWidth, 0);
    self.contentView.frame = CGRectMake(30 *SIZE,10 *SIZE, _totalWidth,_totalHeight);
    [self drawBarsChart];
}
-(void)drawBarsChart{
    
    [self clear];
    [self drawAxis];
    [self addYAxisLabs];
    [self addBars];
    [self addXAxisLabs];
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
-(void)drawAxis{
    
    UIBezierPath   *path = [UIBezierPath bezierPath];
    //先画整体的线
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画左上角的箭头
    [path moveToPoint:CGPointMake(-5 *SIZE, 5 *SIZE)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(5 *SIZE, 5 *SIZE)];
    //画右上角的箭头
    [path moveToPoint:CGPointMake(_totalWidth - 5 *SIZE, _totalHeight - 5 *SIZE)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth - 5 *SIZE, _totalHeight + 5 *SIZE)];
    //画y轴刻度
    for (int i = 1; i < self.yAxisCount; i++) {
        
        [path moveToPoint:CGPointMake(0, i * (_totalHeight / self.yAxisCount))];
        [path addLineToPoint:CGPointMake(5 *SIZE, i * (_totalHeight / self.yAxisCount))];
    }
    //画x轴的刻度
    for (int i = 0; i < self.xValuesArr.count; i++) {
        
        CGPoint  startPoint = CGPointMake(i * (self.barWidth + self.gapWidth) + self.gapWidth + self.barWidth / 2, _totalHeight);
        [self.barsStartPointsArr addObject:[NSValue valueWithCGPoint:startPoint]];
        [path moveToPoint:startPoint];
        [path addLineToPoint:CGPointMake(i * (self.barWidth + self.gapWidth) + self.gapWidth + self.barWidth/2, _totalHeight - 5 *SIZE)];
    }
    
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor grayColor].CGColor;
    lineLayer.lineWidth = SIZE;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
}
//给y轴添加刻度显示
-(void)addYAxisLabs{
    for (int i = self.yAxisCount ; i > 0; i--) {
        
        CGFloat   yAxis = self.yScaleValue * i;
        UILabel  *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(-5 *SIZE, (self.yAxisCount-i)*(_totalHeight/self.yAxisCount) - 10 *SIZE, -25 *SIZE, 20 *SIZE);
        lab.text = [NSString stringWithFormat:@"%.f",yAxis];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lab];
    }
}
//给x轴添加刻度显示
-(void)addXAxisLabs{
    for (int i = 0 ; i < self.xValuesArr.count; i++) {
        
        CGPoint   point = [self.barsStartPointsArr[i] CGPointValue];
        UILabel   *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth * 4 / 5, 20 *SIZE);
        lab.center = CGPointMake(point.x, point.y + lab.bounds.size.height/2);
        lab.text = [NSString stringWithFormat:@"%@",self.xValuesArr[i]];
        lab.font = [UIFont systemFontOfSize:10 *SIZE];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
    }
}
//添加柱形图
-(void)addBars{
    for (int i = 0 ; i < self.yValuesArr.count; i++) {
        
        CGFloat   Y = [(NSString *)self.yValuesArr[i] floatValue];
        CGFloat   barHeight = (Y/(self.yAxisCount*self.yScaleValue))*_totalHeight;
        CGPoint   startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint   endPoint = CGPointMake(startPoint.x, startPoint.y-barHeight);
        [self.barsEndPointsArr addObject:[NSValue valueWithCGPoint:endPoint]];
        CAShapeLayer *barLayer = [CAShapeLayer layer];
        barLayer.strokeColor =self.barCorlor.CGColor;
        barLayer.lineWidth = self.barWidth;
        [self.contentView.layer addSublayer:barLayer];
        
        
        UIBezierPath  *barPath = [UIBezierPath bezierPath];
        [barPath moveToPoint:startPoint];
        [barPath addLineToPoint:endPoint];
        [barPath closePath];
        barLayer.path=barPath.CGPath;
//        [barLayer addAnimation:[self animationWithDuration:0.3*(i+1)] forKey:nil];
        [self.barsLayersArr addObject:barLayer];
    }
}
//显示每个柱形图的值
-(void)showBarChartYValus{
    
    if(!self.showEachYValus)return;
    
    for (int i = 0; i < self.xValuesArr.count; i++) {
        
        CGPoint  point = [self.barsEndPointsArr[i] CGPointValue];
        UILabel  *lab = [[UILabel alloc]init];
        lab.textColor = self.barCorlor;
        lab.font = [UIFont systemFontOfSize:10 *SIZE];
        lab.text = self.yValuesArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth * 4 / 5, 20 *SIZE);
        lab.center = CGPointMake(point.x, point.y - 10 *SIZE);
        [self.contentView addSubview:lab];
    }
}

@end
