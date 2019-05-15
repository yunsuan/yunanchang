//
//  CallTelegramCustomDetailHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailHeader.h"

@interface CallTelegramCustomDetailHeader ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_collArr;
    NSMutableArray *_selectArr;
    NSInteger _num;
}
@end

@implementation CallTelegramCustomDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _collArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _headImg.image = IMAGE_WITH_NAME(@"def_head");
    _propertyL.text = [NSString stringWithFormat:@"意向物业：%@",dataDic[@""]];
    _customSourceL.text = [NSString stringWithFormat:@"客户来源：%@",dataDic[@""]];
    _sourceTypeL.text = [NSString stringWithFormat:@"来源类型：%@",dataDic[@""]];
    _approachL.text = [NSString stringWithFormat:@"认知途径：%@",dataDic[@""]];
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
//    self.dataArr = [NSMutableArray arrayWithArray:dataArr];
    
    _collArr = [NSMutableArray arrayWithArray:dataArr];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < dataArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    [_groupColl reloadData];
    if (dataArr.count) {
        
        [_groupColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    [_groupColl reloadData];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailHeaderTagBlock) {
        
        self.callTelegramCustomDetailHeaderTagBlock(btn.tag);
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    //    if (self.callTelegramCustomDetailHeaderTagBlock) {
    //
    //        self.callTelegramCustomDetailHeaderTagBlock(btn.tag);
    //    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailHeaderEditBlock) {

        self.callTelegramCustomDetailHeaderEditBlock(btn.tag);
    }
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
//    if (self.callTelegramCustomDetailHeaderTagBlock) {
//
//        self.callTelegramCustomDetailHeaderTagBlock(btn.tag);
//    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _collArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 67 *SIZE, 30 *SIZE)];
    }
    
    cell.titleL.text = _collArr[indexPath.item][@"name"];
    
    cell.isSelect = [_selectArr[indexPath.item] integerValue];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < _selectArr.count; i++) {
        
        [_selectArr replaceObjectAtIndex:i withObject:@0];
    }
    
    [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    [collectionView reloadData];
    if (self.callTelegramCustomDetailHeaderCollBlock) {
        
        self.callTelegramCustomDetailHeaderCollBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_blueView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    [_blueView addSubview:_headImg];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLWhiteColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _propertyL = label;
                [_blueView addSubview:_propertyL];
                break;
            }
            case 1:
            {
                _customSourceL = label;
                [_blueView addSubview:_customSourceL];
                break;
            }
            case 2:
            {
                _sourceTypeL = label;
                [_blueView addSubview:_sourceTypeL];
                break;
            }
            case 3:
            {
                _approachL = label;
                [_blueView addSubview:_approachL];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_3") forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete") forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:13 *SIZE];
    _flowLayout.itemSize = CGSizeMake(67 *SIZE, 30 *SIZE);
    _flowLayout.minimumLineSpacing = 8 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _groupColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _groupColl.backgroundColor = CLWhiteColor;
    _groupColl.delegate = self;
    _groupColl.dataSource = self;
    [_groupColl registerClass:[CallTelegramCustomDetailHeaderCollCell class] forCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell"];
    [self.contentView addSubview:_groupColl];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_4") forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"基本资料",@"意向调查",@"跟进记录"];
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setBackgroundColor:CL248Color];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CL178Color forState:UIControlStateNormal];
        
        if (i == 0) {
            
            _infoBtn = btn;
            [self.contentView addSubview:_infoBtn];
        }else if (i == 1){
            
            _intentBtn = btn;
            [self.contentView addSubview:_intentBtn];
        }else{
            
            _followBtn = btn;
            [self.contentView addSubview:_followBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_blueView).offset(10 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_editBtn.mas_left).offset(-20 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(18 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_blueView).offset(9 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-100 *SIZE);
    }];
    
    [_customSourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_propertyL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-100 *SIZE);
    }];
    
    [_sourceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_customSourceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-100 *SIZE);
    }];
    
    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_sourceTypeL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-100 *SIZE);
        make.bottom.equalTo(self->_blueView).offset(-19 *SIZE);
    }];

    [_groupColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-13 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(11 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_intentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
