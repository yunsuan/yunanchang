//
//  AddCompanyView.m
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddCompanyView.h"
#import "AddCompanyCell.h"


@interface AddCompanyView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//@property (nonatomic, strong) UICollectionView *tagColl;

@end

@implementation AddCompanyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addBtnBlock) {
        
        self.addBtnBlock();
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(90 *SIZE, 37*SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddCompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddCompanyCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    
    [cell setstylebytype:@"0" andsetlab:_dataArr[(NSUInteger) indexPath.item][@"company_name"]];
    cell.deleteBtnBlock = ^(NSUInteger index) {
        [_dataArr removeObjectAtIndex:index];
        [collectionView reloadData];
        [self reloadInputViews];
        
        if (self.deletBtnBlock) {
            self.deletBtnBlock();
        }
        
    };
    return cell;
}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 17 *SIZE, 100 *SIZE, 14 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"轮岗团队";
    [self addSubview:label];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(321 *SIZE, 10 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_4"] forState:UIControlStateNormal];
    [self addSubview:_addBtn];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumInteritemSpacing = 7 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 32 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 48 *SIZE, SCREEN_Width, 37 *SIZE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = [UIColor whiteColor];
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    _tagColl.showsHorizontalScrollIndicator = NO;
    _tagColl.showsVerticalScrollIndicator = NO;
    
    [_tagColl registerClass:[AddCompanyCell class] forCellWithReuseIdentifier:@"AddCompanyCell"];
    [self addSubview:_tagColl];
    
    
}
@end
