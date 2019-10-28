//
//  EnclosureCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "EnclosureCell.h"

#import "AddNumeralFileCell.h"

@interface EnclosureCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}


@end

@implementation EnclosureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _imgArr = [NSMutableArray arrayWithArray:dataArr];
    [_coll reloadData];
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddNumeralFileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddNumeralFileCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AddNumeralFileCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 100 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
    cell.deleteBtn.hidden = YES;
    
    [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgArr[indexPath.item][@"url"]]] placeholderImage:IMAGE_WITH_NAME(@"") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            cell.bigImg.image = IMAGE_WITH_NAME(@"");
        }
    }];
    
    return cell;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:15 *SIZE];
    _layout.itemSize = CGSizeMake(100 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddNumeralFileCell class] forCellWithReuseIdentifier:@"AddNumeralFileCell"];
    [self addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
