//
//  TaskSignAuditCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskSignAuditCell.h"

#import "TaskSignAuditCollCell.h"

@interface TaskSignAuditCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@end

@implementation TaskSignAuditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.taskSignAuditCellBtnBlock) {
        
        self.taskSignAuditCellBtnBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 0) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _nameL.text = [NSString stringWithFormat:@"渠道人员姓名：%@",dataDic[@"broker_name"]];
    _phoneL.text = [NSString stringWithFormat:@"手机号：%@",dataDic[@"broker_tel"]];
    _timeL.text = [NSString stringWithFormat:@"报备时间：%@",dataDic[@"create_time"]];
    _companyL.text = [NSString stringWithFormat:@"分销公司：%@",dataDic[@"company_name"]];
    _customNameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"name"]];
    _customPhoneL.text = [NSString stringWithFormat:@"客户电话：%@",dataDic[@"tel"]];
    _areaL.text = [NSString stringWithFormat:@"客户区域：%@%@",dataDic[@"province"],dataDic[@"city"]];
    _isRecognitionL.text = [NSString stringWithFormat:@"是否认筹：%@",dataDic[@"broker_name"]];
    _customVisitNumL.text = [NSString stringWithFormat:@"客户到访人数：%@",dataDic[@"visit_num"]];
    _visitTimeL.text = [NSString stringWithFormat:@"客户到访时间：%@",dataDic[@"visit_time"]];
    _dataArr = [NSMutableArray arrayWithArray:dataDic[@"signAgent"]];
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskSignAuditCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TaskSignAuditCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TaskSignAuditCollCell alloc] initWithFrame:CGRectMake(0, 0, 67 *SIZE, 67 *SIZE)];
    }
    
    cell.nameL.text = _dataArr[indexPath.item][@"name"];
    if (indexPath.item == 0) {
        
        cell.headLine.hidden = YES;
    }else{
        
        cell.headLine.hidden = NO;
    }
    
    if (indexPath.item == _dataArr.count - 1) {
        
        cell.tailLine.hidden = YES;
    }else{
        
        cell.tailLine.hidden = NO;
    }
    
    if ([_dataArr[indexPath.item][@"comment"] length]) {
        
        cell.tagImg.hidden = NO;
    }else{
        
        cell.tagImg.hidden = YES;
    }
    
    if ([_dataArr[indexPath.item][@"state"] integerValue] == 1) {
        
        cell.circleImg.image = IMAGE_WITH_NAME(@"blue");
    }else{
        
        cell.circleImg.image = IMAGE_WITH_NAME(@"grey");
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.item][@"comment"] length]) {
        
        if (self.taskSignAuditCellCollBlock) {
            
            self.taskSignAuditCellCollBlock(_dataArr[indexPath.row][@"comment"]);
        }
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.image = IMAGE_WITH_NAME(@"signing_2");
    [_whiteView addSubview:_headImg];
    
    _readImg = [[UIImageView alloc] init];
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.text = @"签字确认";
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 10; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                break;
            }
            case 1:
            {
                label.textAlignment = NSTextAlignmentRight;
                _phoneL = label;
                [_whiteView addSubview:_phoneL];
                break;
            }
            case 2:
            {
                _timeL = label;
                [_whiteView addSubview:_timeL];
                break;
            }
            case 3:
            {
                label.textAlignment = NSTextAlignmentRight;
                _companyL = label;
                [_whiteView addSubview:_companyL];
                break;
            }
            case 4:
            {
                _customNameL = label;
                [_whiteView addSubview:_customNameL];
                break;
            }
            case 5:
            {
                label.textAlignment = NSTextAlignmentRight;
                _customPhoneL = label;
                [_whiteView addSubview:_customPhoneL];
                break;
            }
            case 6:
            {
                _areaL = label;
                [_whiteView addSubview:_areaL];
                break;
            }
            case 7:
            {
                label.textAlignment = NSTextAlignmentRight;
                _isRecognitionL = label;
                [_whiteView addSubview:_isRecognitionL];
                break;
            }
            case 8:
            {
                _customVisitNumL = label;
                [_whiteView addSubview:_customVisitNumL];
                break;
            }
            case 9:
            {
                _visitTimeL = label;
                [_whiteView addSubview:_visitTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [_whiteView addSubview:_line];
    
    _signL = [[UILabel alloc] init];
    _signL.textColor = CL86Color;
    _signL.font = [UIFont systemFontOfSize:11 *SIZE];
    _signL.text = @"签字确认";
    [_whiteView addSubview:_signL];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(67 *SIZE, 67 *SIZE);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
//    _flowLayout.
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 270 *SIZE, 67 *SIZE) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = CLWhiteColor;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[TaskSignAuditCollCell class] forCellWithReuseIdentifier:@"TaskSignAuditCollCell"];
    [self.contentView addSubview:_collectionView];
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.layer.borderWidth = SIZE;
    _confirmBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [_whiteView addSubview:_confirmBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(354 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
        make.width.height.mas_equalTo(51 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(63 *SIZE);
        make.top.equalTo(self->_whiteView).offset(30 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(7 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-8 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(7 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_customNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_customPhoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-8 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_customNameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_isRecognitionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView).offset(-8 *SIZE);
        make.top.equalTo(self->_customNameL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_customVisitNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    [_visitTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_customVisitNumL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(165 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_visitTimeL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_signL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_signL.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-8 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(37 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
