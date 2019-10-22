//
//  myDataGridViewCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "myDataGridViewCell.h"

@interface myDataGridViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation myDataGridViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.contentView.backgroundColor = CLBlueBtnColor;
    self.titleLabel.frame = CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height);
    self.lineView.frame = CGRectMake(self.bounds.size.width - SIZE, 0, SIZE, self.bounds.size.height);
}
- (void)setItemModel:(ZQDataGridLeftTableViewCellModel *)itemModel{
    _itemModel = itemModel;
    self.titleLabel.text = itemModel.titleString;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
