//
//  StoreCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
//    _headImg.image = IMAGE_WITH_NAME(@"paihao");
//    _titleL.text = [NSString stringWithFormat:@"%@/%@",dataDic[@"batch_name"],dataDic[@"row_name"]];
//    _customL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
//    _numL.text = [NSString stringWithFormat:@"组别人数：%@",dataDic[@"client_num"]];
//    _timeL.text = dataDic[@"create_time"];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                
                _titleL = label;
//                _titleL.numberOfLines = 0;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                
                _customL = label;
                [self.contentView addSubview:_customL];
                break;
            }
            case 2:
            {
                _timeL = label;
                _timeL.textAlignment = NSTextAlignmentRight;
                _timeL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 3:
            {
                
                _addressL = label;
                _addressL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 4:
            {
                
                _ascriptionL = label;
                _ascriptionL.textColor = CLWhiteColor;
                _ascriptionL.textAlignment = NSTextAlignmentCenter;
                _ascriptionL.backgroundColor = CLBlueBtnColor;
                _ascriptionL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_ascriptionL];
                break;
            }
            case 5:
            {
                
                _typeL = label;
                _typeL.textColor = CLWhiteColor;
                _typeL.textAlignment = NSTextAlignmentCenter;
                _typeL.backgroundColor = [UIColor darkGrayColor];
                _typeL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_typeL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.height.mas_equalTo(70 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(115 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
