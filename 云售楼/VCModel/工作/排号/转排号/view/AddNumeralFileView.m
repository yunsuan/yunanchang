//
//  AddNumeralFileView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralFileView.h"

#import "AddNumeralFileCell.h"

@interface AddNumeralFileView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}

@end

@implementation AddNumeralFileView

- (instancetype)init
{
    self = [super init];
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
    
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.mas_bottom).offset(-10 *SIZE);
    }];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addNumeralFileViewAddBlock) {
        
        self.addNumeralFileViewAddBlock();
    }
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
    
    [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgArr[indexPath.item][@"url"]]] placeholderImage:IMAGE_WITH_NAME(@"") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            cell.bigImg.image = IMAGE_WITH_NAME(@"");
        }
    }];
    
    cell.addNumeralFileCellDeleteBlock = ^(NSInteger idx) {
        
        if (self.addNumeralFileViewDeleteBlock) {
            
            self.addNumeralFileViewDeleteBlock(idx);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:CLBackColor];
    [_addBtn setTitle:@"选择文件上传" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:15 *SIZE];
    _layout.itemSize = CGSizeMake(100 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddNumeralFileCell class] forCellWithReuseIdentifier:@"AddNumeralFileCell"];
    [self addSubview:_coll];
            
            
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.mas_bottom).offset(-10 *SIZE);
    }];
    
}

@end
