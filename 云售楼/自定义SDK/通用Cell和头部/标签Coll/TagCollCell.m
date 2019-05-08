//
//  TagCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "TagCollCell.h"

@implementation TagCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setStyleByType:(NSString *)type lab:(NSString *)str{
    
    _contentL.text = str;
    if ([type isEqualToString:@"1"]) {
        
        self.layer.borderWidth = SIZE;
        self.backgroundColor = CLWhiteColor;
        _contentL.textColor = CLContentLabColor;
        self.layer.borderColor = COLOR(181, 181, 181, 1).CGColor;
    }else{
        
        self.layer.borderWidth = 0;
        if ([str isEqualToString:@"住宅"]) {
            self.backgroundColor = COLOR(213, 243, 255, 1);
            _contentL.textColor = COLOR(67, 171, 255, 1);
        }
        else if([str isEqualToString:@"写字楼"])
        {
            self.backgroundColor = COLOR(235, 243, 237, 1);
            _contentL.textColor = COLOR(137, 199, 182, 1);
        }
        else if([str isEqualToString:@"商铺"])
        {
            self.backgroundColor = COLOR(209, 243, 245, 1);
            _contentL.textColor = COLOR(43, 187, 197, 1);
        }
        else if([str isEqualToString:@"别墅"])
        {
            self.backgroundColor = COLOR(255, 237, 211, 1);
            _contentL.textColor = COLOR(255, 190, 90, 1);
        }
        else
        {
            self.backgroundColor = COLOR(229, 241, 255, 1);
            _contentL.textColor = COLOR(139, 188, 255, 1);
        }
    }
}

- (void)initUI{
    
    self.layer.cornerRadius = 2 *SIZE;
    self.clipsToBounds = YES;
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.textAlignment = NSTextAlignmentCenter;
    _contentL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
//        make.width.mas_lessThanOrEqualTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
//
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height = size.height;
//    cellFrame.size.width = size.width;
//    layoutAttributes.frame = cellFrame;
//    return layoutAttributes;
//}

@end
