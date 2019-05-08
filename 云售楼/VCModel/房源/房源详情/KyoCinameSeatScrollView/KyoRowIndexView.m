//
//  KyoRowIndexView.m
//  云算
//
//  Created by xiaoq on 2017/3/31.
//  Copyright © 2017年 xiaoqcd. All rights reserved.
//



#import "KyoRowIndexView.h"
#import <CoreText/CoreText.h>

#define kKyoRowIndexViewFontName    @"Helvetica"
#define kKyoRowIndexViewFontSize    10
#define kKyoRowIndexViewColor     [UIColor blackColor]

@implementation KyoRowIndexView

#pragma mark --------------------
#pragma mark - CycLife

- (void)drawRect:(CGRect)rect {
    [self setupView];
    
    if (self.row > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0.0f , self.bounds.size.height);
        CGContextScaleCTM(context, 1, -1);
        
        //字体
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)kKyoRowIndexViewFontName, kKyoRowIndexViewFontSize, NULL);
        //剧中对齐
        CTTextAlignment alignment = kCTCenterTextAlignment;
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize=sizeof(alignment);
        alignmentStyle.value=&alignment;
        //样式设置
        CTParagraphStyleSetting settings[] = {alignmentStyle};
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 2);
        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName];
        
        for (NSInteger i = 0; i < self.row; i++) {
            
            CGContextRef cty = UIGraphicsGetCurrentContext();
            //设置颜色，仅填充4条边
            
            CGContextAddRect(cty, CGRectMake(0, +self.bounds.size.height+12 - self.bounds.size.height / self.row * (i + 1) - (self.bounds.size.height / self.row - kKyoRowIndexViewFontSize) / 4,  self.bounds.size.width, self.bounds.size.height / self.row-10));
            CGContextSetFillColorWithColor(cty, [UIColor whiteColor].CGColor);
            CGContextFillPath(cty);

            CGContextRef ctx = UIGraphicsGetCurrentContext();
            //设置颜色，仅填充4条边
            CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
            CGContextAddRect(ctx, CGRectMake(0, self.bounds.size.height+12 - self.bounds.size.height / self.row * (i + 1) - (self.bounds.size.height / self.row - kKyoRowIndexViewFontSize) / 4,  self.bounds.size.width, self.bounds.size.height / self.row-10));
            //设置线宽为1
        
        
            CGContextSetLineWidth(ctx, 1.0);
            //设置长方形4个顶点
            CGContextClosePath(ctx);
            CGContextStrokePath(ctx);
            
//            NSString *string = self.rowIndexType == KyoCinameSeatRowIndexTypeNumber ? [NSString stringWithFormat:@"F%ld",self.row-i] : [NSString stringWithFormat:@"%C", (unichar)(i + 65)];
            
            if (self.arrayRowIndex[i]) {
                
            }
            
            NSString * string = self.arrayRowIndex[i];
//            if (self.arrayRowIndex && self.arrayRowIndex.count > i) {
//               NSString * string = self.arrayRowIndex[i];
//            }
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, [attributedString length])];
            [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)kKyoRowIndexViewColor.CGColor range:NSMakeRange(0, attributedString.length)];
            [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
            
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
            CGMutablePathRef path = CGPathCreateMutable();
//#warning  画楼层框
            CGPathAddRect(path, NULL, CGRectMake(0, self.bounds.size.height - self.bounds.size.height / self.row * (i + 1) - (self.bounds.size.height / self.row - kKyoRowIndexViewFontSize) / 4-5,  self.bounds.size.width, self.bounds.size.height / self.row));
            //画楼层框
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
            CTFrameDraw(frame, context);
            
        
            CFRelease(frame);
            CGPathRelease(path);
            CFRelease(framesetter);
        }
    }
}

#pragma mark --------------------
#pragma mark - Methods

- (void)setupView {
    self.clipsToBounds = YES;
//    self.layer.cornerRadius = self.width / 2;
//    self.layer.masksToBounds = YES;
}


@end
