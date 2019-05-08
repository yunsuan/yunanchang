//
//  WorkPhoneConfrimWaitCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkPhoneConfrimWaitCellBlock)(void);
typedef void(^CopyWorkPhoneConfrimWaitCellBlock)(void);

@interface WorkPhoneConfrimWaitCell : UITableViewCell

@property (nonatomic, copy) WorkPhoneConfrimWaitCellBlock workPhoneConfrimWaitCellBlock;

@property (nonatomic, copy) CopyWorkPhoneConfrimWaitCellBlock copyWorkPhoneConfrimWaitCellBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *resonL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *timeL;

//@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic , strong) UIButton *copybtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *useDic;

@property (nonatomic, strong) NSMutableDictionary *failDic;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
