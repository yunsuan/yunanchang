//
//  AuditDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AuditDetailVC.h"

#import "RoomHeader.h"
#import "AuditTaskDetailCollCell.h"

#import "SinglePickView.h"
#import "DropBtn.h"

#import "GZQFlowLayout.h"

@interface AuditDetailVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextViewDelegate>
{
    
    NSString *_isFinal;
    NSString *_checkType;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_roleArr;
    
    NSString *_log_id;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UILabel *processTypeL;

@property (nonatomic, strong) UILabel *processNameL;

@property (nonatomic, strong) UILabel *applicantL;

@property (nonatomic, strong) UILabel *applicantTimeL;

//@property (nonatomic, strong) BaseHeader *header;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation AuditDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    //    _isFinal = @"1";
    _dataArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetProgressList_URL parameters:@{@"type":self.status,@"id":self.requestId} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_log_id = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"list"][0][@"log_id"]];
            self->_processTypeL.text = [NSString stringWithFormat:@"流程类型：%@",[resposeObject[@"data"][@"list"][0][@"check_type"] integerValue] == 1 ? @"自由流程":@"固定流程"];
            self->_processNameL.text = [NSString stringWithFormat:@"流程名称：%@",resposeObject[@"data"][@"progress_name"]];
            self->_applicantL.text = [NSString stringWithFormat:@"申请人：%@",resposeObject[@"data"][@"agent_name"]];
            self->_applicantTimeL.text = [NSString stringWithFormat:@"申请时间：%@",resposeObject[@"data"][@"create_time"]];
            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"list"]];
            self->_checkType = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"list"][0][@"check_type"]];
            [self->_coll reloadData];
            
            [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_scroll).offset(0);
                make.top.equalTo(self->_applicantTimeL.mas_bottom).offset(10 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
            }];

        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
        
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    RoomHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[RoomHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    
    header.titleL.text =  @"审核";
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuditTaskDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuditTaskDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuditTaskDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 150 *SIZE)];
    }
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"审核";
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.backgroundColor = CLWhiteColor;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _processTypeL = label;
                [_scroll addSubview:_processTypeL];
                break;
            }
            case 1:
            {
                _processNameL = label;
                [_scroll addSubview:_processNameL];
                break;
            }
            case 2:
            {
                _applicantL = label;
                [_scroll addSubview:_applicantL];
                break;
            }
            case 3:
            {
                _applicantTimeL = label;
                [_scroll addSubview:_applicantTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(SCREEN_Width, 150 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AuditTaskDetailCollCell class] forCellWithReuseIdentifier:@"AuditTaskDetailCollCell"];
    [_coll registerClass:[RoomHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader"];
    [_scroll addSubview:_coll];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_processTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_scroll).offset(10 *SIZE);
        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
    }];
    
    [_processNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_processTypeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
    }];
    
    [_applicantL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_processNameL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
    }];
    
    [_applicantTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_applicantL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(0);
        make.top.equalTo(self->_applicantTimeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_scroll.mas_bottom).offset(-10 *SIZE);
    }];

}

@end
