//
//  LinesSelectCell.h
//  LRSChartView
//
//  Created by 谷治墙 on 2018/10/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinesSelectCell : UITableViewCell
@property(nonatomic ,assign)CGFloat leftWidth;

@property(nonatomic ,assign)CGFloat rightWith;

-(void)showTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont andDescTile:(NSString *)descTitle andDescTileColor:(UIColor *)descTileColor andDescTitleFont:(UIFont *)DescTitleFont;

@end
