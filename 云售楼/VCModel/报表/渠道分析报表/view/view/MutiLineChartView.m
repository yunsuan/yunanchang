//
//  MutiLineChartView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MutiLineChartView.h"

@interface MutiLineChartView (){
    CGFloat         _totalWidth;
    CGFloat         _totalHeight;
}
@property(nonatomic)UIScrollView    *scrollView;
@property(nonatomic)UIView          *contentView;
@property(nonatomic)UILabel         *unitLab;
@property(nonatomic)NSMutableArray  *totalCirclePathArr;

@end

@implementation MutiLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.barColorArr = [@[] mutableCopy];
    self.totalCirclePathArr = [@[] mutableCopy];
    self.barWidth = 20 *SIZE;
    self.gapWidth = 30 *SIZE;
    self.yAxiasCount = 10;
    self.yAxiasValus = 50;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    [self addTap];
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)ges{
//    CGPoint  point = [ges locationInView:self.contentView];
//    for (int i = 0; i<self.totalCirclePathArr.count; i++) {
//        for (int j = 0 ; j<[self.totalCirclePathArr[i] count]; j++) {
//            UIBezierPath  *path = self.totalCirclePathArr[i][j];
//            if ([path containsPoint:point]) {
//                if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectMutipleBarChartIndex:)]) {
//                    [self.delegate SSWChartView:self didSelectMutipleBarChartIndex:@[@(i),@(j)]];
//                }
//            }
//        }
//    }
}
-(void)setUnit:(NSString *)unit{
    _unit = unit;
    self.unitLab.text = [NSString stringWithFormat:@"单位:%@",unit];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        //        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}
-(UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = [UIFont systemFontOfSize:10];
        //        _unitLab.textAlignment = NSTextAlignmentCenter;
    }
    return _unitLab;
}
-(void)layoutSubviews{
    self.scrollView.frame = self.bounds;
    _totalWidth = self.barWidth * self.xValuesArr.count +( self.xValuesArr.count + 1 )*self.gapWidth;
    _totalHeight = self.bounds.size.height - 20 *SIZE - 30 *SIZE;
    self.scrollView.contentSize = CGSizeMake(30 *SIZE+_totalWidth, 0);
    self.contentView.frame = CGRectMake(30 *SIZE, 20 *SIZE, _totalWidth, _totalHeight);
    self.unitLab.frame = CGRectMake(5 *SIZE,0,60 *SIZE, 20 *SIZE);
    [self drawAxias];
    [self addYAxaisLabs];
    [self addXAxiasLabs];
    [self drawLines];
    [self addLegends];
    
}
//画坐标轴
-(void)drawAxias{
    UIBezierPath   *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画Y轴的箭头
    [path moveToPoint:CGPointMake(-5 *SIZE, 5 *SIZE)];
    [path addLineToPoint:CGPointMake(0 *SIZE, 0 *SIZE)];
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
        [path moveToPoint:CGPointMake(self.gapWidth + self.barWidth/2 + (self.barWidth + self.gapWidth) * i, _totalHeight)];
        [path addLineToPoint:CGPointMake(self.gapWidth+self.barWidth/2+(self.barWidth+self.gapWidth)*i, _totalHeight-5)];
    }
    CAShapeLayer   *axiasLayer = [CAShapeLayer layer];
    axiasLayer.strokeColor = [UIColor grayColor].CGColor;
    axiasLayer.fillColor = [UIColor clearColor].CGColor;
    axiasLayer.lineWidth = 1;
    axiasLayer.path = path.CGPath;
    [self.contentView.layer addSublayer:axiasLayer];
}
//添加y轴的坐标值显示
-(void)addYAxaisLabs{
    for (int i = 0 ; i < self.yAxiasCount; i++) {
        
        UILabel  *lab = [[UILabel alloc]init];
        lab.text = [NSString stringWithFormat:@"%ld",self.yAxiasValus*(self.yAxiasCount-i)];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:10];
        lab.frame = CGRectMake(-5, i*(_totalHeight/self.yAxiasCount) - 10 *SIZE, -25 *SIZE, 20 *SIZE);
        [self.contentView addSubview:lab];
    }
}
//添加x轴的坐标值显示
-(void)addXAxiasLabs{
    for (int i =0; i < self.xValuesArr.count; i++) {
        
        UILabel  *lab = [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.xValuesArr[i];
        lab.frame = CGRectMake(self.gapWidth + self.barWidth/2 + (self.barWidth + self.gapWidth) * i - (self.barWidth+self.gapWidth / 2 ) / 2, _totalHeight,self.barWidth + self.gapWidth / 2, 30 *SIZE);
        [self.contentView addSubview:lab];
    }
}
//计算折线的关键点,划线
-(void)drawLines{
    
    NSMutableArray  *pathArr =[@[] mutableCopy];
    NSMutableArray  *lineLayerArr = [@[] mutableCopy];
    for (int i = 0 ; i < [self.yValuesArr[0] count]; i++) {
        
        UIBezierPath  *linePath = [UIBezierPath bezierPath];
        [pathArr addObject:linePath];
        
        CAShapeLayer  *lineLayer = [CAShapeLayer layer];
        lineLayer.strokeColor = [self.barColorArr[i] CGColor];
        lineLayer.lineWidth = 1 *SIZE;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        [self.contentView.layer addSublayer:lineLayer];
        [lineLayerArr addObject:lineLayer];
    }
    for (int i = 0 ; i < self.xValuesArr.count; i++) {
        
        NSMutableArray  *circlePathArr = [@[] mutableCopy];
        for (int j = 0; j < [self.yValuesArr[i] count]; j++) {
            
            CGPoint  Point = CGPointMake(self.gapWidth + self.barWidth/2 + i * (self.barWidth +self.gapWidth), _totalHeight - [self.yValuesArr[i][j] floatValue] * _totalHeight / (self.yAxiasCount * self.yAxiasValus));
            //画点
            UIBezierPath  *circlePath = [UIBezierPath bezierPath];
            [circlePath addArcWithCenter:Point radius:2 *SIZE startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            CAShapeLayer  *circleLayer = [CAShapeLayer layer];
            circleLayer.fillColor = self.backgroundColor.CGColor;
            circleLayer.lineWidth = 1 *SIZE;
            circleLayer.strokeColor = [self.barColorArr[j] CGColor];
            circleLayer.path = circlePath.CGPath;
//            [circleLayer addAnimation:[self animationWithDuration:i*0.3] forKey:nil];
            [self.contentView.layer addSublayer:circleLayer];
            [circlePathArr addObject:circlePath];
            
            //画折线
            UIBezierPath  *linePath = pathArr[j];
            CAShapeLayer  *lineLayer = lineLayerArr[j];
//            [lineLayer addAnimation:[self animationWithDuration:(i+1)*0.3] forKey:nil];
            if (i == 0) {
                
                [linePath moveToPoint:Point];
            }
            else{
                
                [linePath addLineToPoint:Point];
            }
            lineLayer.path = linePath.CGPath;
        }
        [self.totalCirclePathArr addObject:circlePathArr];
    }
}
//添加图例
-(void)addLegends{
    for (int i = 0; i<self.legendTitlesArr.count; i++) {
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
        lengendLayer.backgroundColor =self.barColorArr[i] ;
        lengendLayer.frame = CGRectMake(0, lengendView.bounds.size.height/2 - 0.5 *SIZE, 10 *SIZE, 1 *SIZE);
        [lengendView addSubview:lengendLayer];
    }
}

@end
