//
//  EnclosureCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "EnclosureCell.h"

#import "EnclosureCollCell.h"

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
//    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(0 *SIZE);
//        make.top.equalTo(self.contentView).offset(9 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
//    }];
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0 *SIZE);
            make.top.equalTo(self.contentView).offset(9 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
//            make.height.mas_equalTo(120 *SIZE);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
        }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EnclosureCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EnclosureCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[EnclosureCollCell alloc] initWithFrame:CGRectMake(0, 0, 110 *SIZE, 120 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
//    cell.deleteBtn.hidden = YES;
    
//    [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgArr[indexPath.item][@"url"]]] placeholderImage:IMAGE_WITH_NAME(@"") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        if (error) {
//
//            cell.bigImg.image = IMAGE_WITH_NAME(@"");
//        }
//    }];
    
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
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.enclosureCellBlock) {
        
        self.enclosureCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(110 *SIZE, 120 *SIZE);
//    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 9 *SIZE, SCREEN_Width, 120 *SIZE) collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[EnclosureCollCell class] forCellWithReuseIdentifier:@"EnclosureCollCell"];
    [self.contentView addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
//        make.height.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
