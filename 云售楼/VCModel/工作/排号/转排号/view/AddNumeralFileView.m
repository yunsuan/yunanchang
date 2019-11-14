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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self->_coll reloadData];
        [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self).offset(0 *SIZE);
            make.top.equalTo(self->_addBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
            make.bottom.equalTo(self.mas_bottom).offset(-10 *SIZE);
        }];
    });
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
        
        cell = [[AddNumeralFileCell alloc] initWithFrame:CGRectMake(0, 0, 110 *SIZE, 120 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
    cell.titleL.text = _imgArr[indexPath.item][@"name"];
    
    if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"avi"]) {
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"avi");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"mp4"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"mp4");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"mp3"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"mp3");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"txt"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"txt");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"jpg"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"jpg");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"png"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"png");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"ppt"] || [[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"pptx"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"ppt");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"exe"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"exe");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"doc"] || [[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"docx"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"doc");
    }else if ([[_imgArr[indexPath.item][@"url"] pathExtension] isEqualToString:@"xlsx"]){
        
        cell.bigImg.image = IMAGE_WITH_NAME(@"exc");
    }else{
            
        cell.bigImg.image = IMAGE_WITH_NAME(@"other");
    }
    
    cell.addNumeralFileCellDeleteBlock = ^(NSInteger idx) {
        
        if (self.addNumeralFileViewDeleteBlock) {
            
            self.addNumeralFileViewDeleteBlock(idx);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    if (self.addNumeralFileViewSelectBlock) {
        
        self.addNumeralFileViewSelectBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:CLOrangeColor];
    [_addBtn setTitle:@"选择文件上传" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = FONT(13 *SIZE);
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    [self addSubview:_addBtn];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(110 *SIZE, 120 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddNumeralFileCell class] forCellWithReuseIdentifier:@"AddNumeralFileCell"];
    [self addSubview:_coll];
            
            
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
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
