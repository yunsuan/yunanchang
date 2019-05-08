//
//  IntentSurveyVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "IntentSurveyVC.h"

#import "FollowRecordVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

#import "IntentSurveyHeader.h"
#import "TitleBaseHeader.h"
#import "BoxSelectCollCell.h"
#import "GZQFlowLayout.h"

@interface IntentSurveyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_labelArr;
    NSMutableArray *_moduleArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *needInfoView;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *intentColl;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation IntentSurveyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    FollowRecordVC *nextVC = [[FollowRecordVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initUI{
    
    self.titleLabel.text = @"意向调查";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _needInfoView = [[UIView alloc] init];
    _needInfoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_needInfoView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步 跟进记录" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    _nextBtn.layer.cornerRadius = 5 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_needInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    _labelArr = [@[] mutableCopy];
    _moduleArr = [@[] mutableCopy];
    for (int i = 0; i < _dataArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _dataArr[i][@"column_name"];
        label.adjustsFontSizeToFitWidth = YES;
        [_labelArr addObject:label];
        
        NSDictionary *dic = _dataArr[i];
        switch ([dic[@"type"] integerValue]) {
            case 1:
            {
                BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                tf.tag = i;
                [_moduleArr addObject:tf];
                break;
            }
            case 2:
            {
                DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                btn.tag = i;
                [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_moduleArr addObject:btn];
                break;
            }
            case 3:
            {
                
                UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
                flowLayout = flowLayout;
                flowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
                flowLayout.minimumLineSpacing = 5 *SIZE;
                flowLayout.minimumInteritemSpacing = 0;
                
                UICollectionView *coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:flowLayout];
                coll.backgroundColor = [UIColor whiteColor];
                coll.tag = i;
                coll.bounces = NO;
                coll.delegate = self;
                coll.dataSource = self;
//                [coll registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
                [_moduleArr addObject:coll];
                
                break;
            }
            case 4:
            {
                DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                btn.tag = i;
                [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_moduleArr addObject:btn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < _moduleArr.count; i++) {
        
        [_needInfoView addSubview:_labelArr[i]];
        [_needInfoView addSubview:_moduleArr[i]];
        
        if (i == 0) {
            
            [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_needInfoView).offset(10 *SIZE);
                make.top.equalTo(self->_needInfoView).offset(21 *SIZE);
                make.width.equalTo(@(70 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                make.top.equalTo(self->_needInfoView).offset(11 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
            
            NSDictionary *dic = _dataArr[i];
            switch ([dic[@"type"] integerValue]) {
                    
                case 1:
                {
                    BorderTextField *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(self->_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 2:
                {
                    DropBtn *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(self->_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 3:
                {
                    
                    DropBtn *tf = _moduleArr[i - 1];
                    UICollectionView *coll = _moduleArr[i];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                            make.bottom.equalTo(self->_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                        }];
                    }
                    
                    break;
                }
                case 4:
                {
                    DropBtn *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(self->_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    break;
                }
            }
        }
    }
}

@end
