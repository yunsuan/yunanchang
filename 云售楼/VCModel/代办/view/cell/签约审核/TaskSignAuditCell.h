//
//  TaskSignAuditCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskSignAuditCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *customNameL;

@property (nonatomic, strong) UILabel *customPhoneL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *isRecognitionL;

@property (nonatomic, strong) UILabel *customVisitNumL;

@property (nonatomic, strong) UILabel *visitTimeL;

//@property (nonatomic, strong) UILabel *isRecognitionL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *signL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableArray *dataDic;

@end

NS_ASSUME_NONNULL_END
