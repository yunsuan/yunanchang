//
//  AddOrderView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderViewAddBlock)(void);

@interface AddOrderView : UIView

@property (nonatomic, copy) AddOrderViewAddBlock addOrderViewAddBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) BorderTextField *depositTF;

@property (nonatomic, strong) UILabel *preferentialL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *spePreferentialL;

@property (nonatomic, strong) BorderTextField *spePreferentialTF;

@property (nonatomic, strong) UILabel *preferPriceL;

@property (nonatomic, strong) BorderTextField *preferPriceTF;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) BorderTextField *totalTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *priceTF;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropBtn *payWayBtn;

@property (nonatomic, strong) UILabel *paymentL;

@property (nonatomic, strong) BorderTextField *paymentTF;

@property (nonatomic, strong) UILabel *loanPriceL;

@property (nonatomic, strong) BorderTextField *loanPriceTF;

@property (nonatomic, strong) UILabel *loanBankL;

@property (nonatomic, strong) DropBtn *loanBankBtn;

@property (nonatomic, strong) UILabel *loanYearL;

@property (nonatomic, strong) BorderTextField *loanYearTF;

@property (nonatomic, strong) UILabel *businessLoanPriceL;

@property (nonatomic, strong) BorderTextField *businessLoanPriceTF;

@property (nonatomic, strong) UILabel *businessLoanBankL;

@property (nonatomic, strong) DropBtn *businessLoanBankBtn;

@property (nonatomic, strong) UILabel *businessLoanYearL;

@property (nonatomic, strong) BorderTextField *businessLoanYearTF;

@property (nonatomic, strong) UILabel *fundLoanL;

@property (nonatomic, strong) BorderTextField *fundLoanTF;

@property (nonatomic, strong) UILabel *fundLoanBankL;

@property (nonatomic, strong) DropBtn *fundLoanBankBtn;

@property (nonatomic, strong) UILabel *fundLoanYearL;

@property (nonatomic, strong) BorderTextField *fundLoanYearTF;

@property (nonatomic, strong) GZQFlowLayout *installmentLayout;

@property (nonatomic, strong) UICollectionView *installmentColl;

@end

NS_ASSUME_NONNULL_END
