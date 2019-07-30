//
//  AuditTaskDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AuditTaskDetailVC.h"

#import "RoomHeader.h"
#import "AuditTaskDetailCollCell.h"

#import "SinglePickView.h"
#import "DropBtn.h"

#import "GZQFlowLayout.h"

@interface AuditTaskDetailVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextViewDelegate>
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

@property (nonatomic, strong) UILabel *finalL;

@property (nonatomic, strong) UIButton *finalBtn;

@property (nonatomic, strong) UIButton *unFinalBtn;

@property (nonatomic, strong) UITextView *auditView;

@property (nonatomic, strong) UILabel *nextL;

@property (nonatomic, strong) DropBtn *nextBtn;

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) UIButton *disagreeBtn;

@end

@implementation AuditTaskDetailVC

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
            
            if ([resposeObject[@"data"][@"list"][0][@"check_type"] integerValue] == 1) {

                self->_nextL.hidden = NO;
                self->_nextBtn.hidden = NO;
                self->_unFinalBtn.hidden = NO;
                self->_finalBtn.hidden = NO;

                [self->_auditView mas_remakeConstraints:^(MASConstraintMaker *make) {

                    make.left.equalTo(self->_scroll).offset(10 *SIZE);
                    make.top.equalTo(self->_unFinalBtn.mas_bottom).offset(10 *SIZE);
                    make.width.mas_equalTo(340 *SIZE);
                    make.height.mas_equalTo(70 *SIZE);
                }];

                [self->_nextL mas_remakeConstraints:^(MASConstraintMaker *make) {

                    make.left.equalTo(self->_scroll).offset(10 *SIZE);
                    make.top.equalTo(self->_auditView.mas_bottom).offset(17 *SIZE);
                    make.width.mas_equalTo(60 *SIZE);
                }];

                [self->_nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {

                    make.left.equalTo(self->_scroll).offset(80 *SIZE);
                    make.top.equalTo(self->_auditView.mas_bottom).offset(13 *SIZE);
                    make.width.mas_equalTo(258 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                    make.bottom.equalTo(self->_scroll.mas_bottom).offset(-10 *SIZE);
                }];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
        
    }];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
//    for ( *tf in _scroll.subviews) {
//
//        if ([tf isKindOfClass:[BorderTextField class]]) {
//
//            [tf.textField endEditing:YES];
//        }
//    }
    
    [_auditView endEditing:YES];
    
    _finalBtn.selected = NO;
    _unFinalBtn.selected = NO;
    if (btn.tag == 1) {
        
        _finalBtn.selected = YES;
        _isFinal = @"2";
    }else{
        
        _unFinalBtn.selected = YES;
        _isFinal = @"1";
    }
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"log_id":self->_log_id}];
    
    if (![self isEmpty:_auditView.text]) {
        
        [dic setObject:_auditView.text forKey:@"comment"];
    }
    if ([self->_checkType integerValue] == 1) {
        
        [dic setObject:_isFinal forKey:@"step_type"];
        if ([_isFinal integerValue] == 1) {
            
            if (_nextBtn->str.length) {
                
                [dic setObject:[NSString stringWithFormat:@"%@",_nextBtn->str] forKey:@"agent_list"];
            }else{
                
                [self showContent:@"请选择下一步审核人"];
                return;
            }
        }
    }
    
    [BaseRequest POST:ProjectProgressPass_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self showContent:@"审核成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionDisagreeBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"log_id":self->_log_id}];
    
    if (![self isEmpty:_auditView.text]) {
        
        [dic setObject:_auditView.text forKey:@"comment"];
    }
    [dic setObject:@"1" forKey:@"type"];
    
    [BaseRequest POST:ProjectProgressPass_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self showContent:@"审核成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.auditTaskDetailVCBlock) {
                    
                    self.auditTaskDetailVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (self->_roleArr.count) {
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_roleArr];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            self->_nextBtn.content.text = MC;
            self->_nextBtn->str = [NSString stringWithFormat:@"%@",ID];
        };
        [self.view addSubview:view];
    }else{
        
        [BaseRequest GET:ProjectRolePersonList_URL parameters:@{@"project_id":self.project_id} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                    
                    [self->_roleArr addObject:@{@"param":resposeObject[@"data"][i][@"agent_name"],@"id":resposeObject[@"data"][i][@"agent_id"]}];
                }
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_roleArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_nextBtn.content.text = MC;
                    self->_nextBtn->str = [NSString stringWithFormat:@"%@",ID];
                };
                [self.view addSubview:view];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
        }];
    }
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
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE)];
    _scroll.backgroundColor = CLWhiteColor;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    for (int i = 0; i < 6; i++) {
        
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
            case 4:
            {
                _finalL = label;
                _finalL.text = @"是否终审";
                [_scroll addSubview:_finalL];
                break;
            }
            case 5:
            {
                _nextL = label;
                _nextL.hidden = YES;
                _nextL.text = @"选择下一步审核人";
                _nextL.adjustsFontSizeToFitWidth = YES;
                [_scroll addSubview:_nextL];
                break;
            }
            default:
                break;
        }
    }
//    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
//    header.titleL.text = @"组员信息";
//    [_scrollView addSubview:header];
//    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
//    _header.titleL.text = @"审核";
//    [_scroll addSubview:_header];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(SCREEN_Width, 150 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AuditTaskDetailCollCell class] forCellWithReuseIdentifier:@"AuditTaskDetailCollCell"];
    [_coll registerClass:[RoomHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader"];
    [_scroll addSubview:_coll];
    
    _auditView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 70 *SIZE)];
    _auditView.delegate = self;
    _auditView.backgroundColor = CLBackColor;
    [_scroll addSubview:_auditView];
    
    _nextBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.hidden = YES;
    [_scroll addSubview:_nextBtn];
    
    NSArray *btnArr = @[@"否",@"是"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        btn.hidden = YES;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"default") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected") forState:UIControlStateSelected];
        
        switch (i) {
            case 1:
            {
                _finalBtn = btn;
                [_scroll addSubview:_finalBtn];
                
                break;
            }
            case 0:
            {
                _unFinalBtn = btn;
                [_scroll addSubview:_unFinalBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    _disagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _disagreeBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _disagreeBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_disagreeBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_disagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [_disagreeBtn setBackgroundColor:CL102Color];
    [self.view addSubview:_disagreeBtn];
    
    _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreeBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_agreeBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_agreeBtn];
    
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
    
//    [_header mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scroll).offset(0 *SIZE);
//        make.top.equalTo(self->_applicantTimeL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
////        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
//    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scroll).offset(0);
        make.top.equalTo(self->_applicantTimeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_finalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(9 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_finalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(80 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_unFinalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(150 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_auditView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(70 *SIZE);
        make.bottom.equalTo(self->_scroll.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_nextL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_auditView.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(80 *SIZE);
        make.top.equalTo(self->_auditView.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

@end
