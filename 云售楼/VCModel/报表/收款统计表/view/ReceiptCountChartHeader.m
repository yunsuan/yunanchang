//
//  ReceiptCountChartHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ReceiptCountChartHeader.h"

#import "SSWPieChartView.h"

#import "EmptyPieView.h"

@interface ReceiptCountChartHeader ()

@property (nonatomic, strong) SSWPieChartView *pieChartView;

@property (nonatomic, strong) EmptyPieView *emptyPieView;

@property (nonatomic, strong) UILabel *allL;

@end

@implementation ReceiptCountChartHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_pieChartView removeFromSuperview];
    [_emptyPieView removeFromSuperview];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    if (dataDic.count) {

        double cashA = [dataDic[@"earnestMoney"][@"cash"] doubleValue] + [dataDic[@"frontMoney"][@"cash"] doubleValue] + [dataDic[@"roomMoney"][@"cash"] doubleValue] + [dataDic[@"roomMoneyMortgage"][@"cash"] doubleValue] + [dataDic[@"generationCharge"][@"cash"] doubleValue];
        double posA = [dataDic[@"earnestMoney"][@"pos"] doubleValue] + [dataDic[@"frontMoney"][@"pos"] doubleValue] + [dataDic[@"roomMoney"][@"pos"] doubleValue] + [dataDic[@"roomMoneyMortgage"][@"pos"] doubleValue] + [dataDic[@"generationCharge"][@"pos"] doubleValue];
        double carryA = [dataDic[@"earnestMoney"][@"carryOver"] doubleValue] + [dataDic[@"frontMoney"][@"carryOver"] doubleValue] + [dataDic[@"roomMoney"][@"carryOver"] doubleValue] + [dataDic[@"roomMoneyMortgage"][@"carryOver"] doubleValue] + [dataDic[@"generationCharge"][@"carryOver"] doubleValue];
        double otherA = [dataDic[@"earnestMoney"][@"other"] doubleValue] + [dataDic[@"frontMoney"][@"other"] doubleValue] + [dataDic[@"roomMoney"][@"other"] doubleValue] + [dataDic[@"roomMoneyMortgage"][@"other"] doubleValue] + [dataDic[@"generationCharge"][@"other"] doubleValue];
        double changeA = [dataDic[@"earnestMoney"][@"change"] doubleValue] + [dataDic[@"frontMoney"][@"change"] doubleValue] + [dataDic[@"roomMoney"][@"change"] doubleValue] + [dataDic[@"roomMoneyMortgage"][@"change"] doubleValue] + [dataDic[@"generationCharge"][@"change"] doubleValue];
        
        
        double all = cashA + posA + carryA + otherA + changeA;
        if (all) {
            
            _pieChartView.colorsArr = CLArr;
            
            NSString *cashB = cashA == 0 ? @"0":[NSString stringWithFormat:@"%.4f",cashA / all];
            NSString *posB = posA == 0 ? @"0":[NSString stringWithFormat:@"%.4f",posA / all];
            NSString *carryOverB = carryA == 0 ? @"0":[NSString stringWithFormat:@"%.4f",carryA / all];
            NSString *otherB = otherA == 0 ? @"0":[NSString stringWithFormat:@"%.4f",otherA / all];
            NSString *changeB = changeA == 0 ? @"0":[NSString stringWithFormat:@"%.4f",changeA / all];
            
            NSMutableArray *nameArr = [@[] mutableCopy];
            NSMutableArray *tempArr = [@[] mutableCopy];
            if ([cashB floatValue]) {
                
                [nameArr addObject:@"现金"];
                [tempArr addObject:cashB];
            }
            if ([posB floatValue]) {
                
                [nameArr addObject:@"POS"];
                [tempArr addObject:posB];
            }
            if ([carryOverB floatValue]) {
                
                [nameArr addObject:@"银行"];
                [tempArr addObject:carryOverB];
            }
            if ([otherB floatValue]) {
                
                [nameArr addObject:@"其他"];
                [tempArr addObject:otherB];
            }
            if ([changeB floatValue]) {
                
                [nameArr addObject:@"换票"];
                [tempArr addObject:changeB];
            }
            
            _pieChartView.titlesArr = nameArr;
            _pieChartView.percentageArr = tempArr; //@[visit,company,person];
            _allL.text = [NSString stringWithFormat:@"%.2f",all];
        }else{
            
            [self.contentView addSubview:_emptyPieView];
            _allL.text = @"0.00";
        }
    }else{
        
        _allL.text = @"0.00";
        [self.contentView addSubview:_emptyPieView];
    }
    
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12 *SIZE, 240 *SIZE, 150 *SIZE, 20 *SIZE)];
    titleL.textColor = CLTitleLabColor;
    titleL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    titleL.text = @"累计收款：";
    [self.contentView addSubview:titleL];
    
    _allL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 240 *SIZE, 100 *SIZE, 20 *SIZE)];
//    _allL.textAlignment = NSTextAlignmentRight;
    _allL.textColor = CLTitleLabColor;
    _allL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_allL];
    
    _pieChartView = [[SSWPieChartView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 240 *SIZE)];
    [self.contentView addSubview:_pieChartView];
    
    _emptyPieView = [[EmptyPieView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 240 *SIZE)];
}

@end
