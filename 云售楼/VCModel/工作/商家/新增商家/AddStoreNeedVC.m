//
//  AddStoreNeedVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddStoreNeedVC.h"

//#import "StoreVC.h"
#import "AddStoreFollowRecordVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

#import "BoxSelectCollCell.h"
#import "GZQFlowLayout.h"

@interface AddStoreNeedVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableDictionary *_dataDic;
    
    NSArray *_countArr;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_viewArr;
//    NSMutableArray *_headArr;
    NSMutableArray *_labelArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_moduleArr;
    NSMutableArray *_lastArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddStoreNeedVC

- (instancetype)initWithData:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        _countArr = data;
    }
    return self;
}

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _viewArr = [@[] mutableCopy];
//    _headArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
    _moduleArr = [@[] mutableCopy];
    _labelArr = [@[] mutableCopy];
    _lastArr = [@[] mutableCopy];;
//
//    _formatter = [[NSDateFormatter alloc] init];
//    [_formatter setDateFormat:@"YYYY-MM-dd"];
}

- (void)RequestMethod{
    
    NSString *project_id = _dataDic[@"project_id"];
    if (project_id) {
        
        [BaseRequest GET:ProjectBusinessGetNeedList_URL parameters:@{@"project_id":project_id} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                for (NSDictionary *dic in resposeObject[@"data"]) {
                    
                    [self->_dataArr addObject:dic];
                }
                [self SetData:self->_dataArr];
                [self initUI];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
                [self initUI];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
            [self initUI];
        }];
    }
}

- (void)SetData:(NSArray *)data{
    
    if (!data.count) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
//        view.tag = [_countArr[a][@"id"] integerValue];
        [_viewArr addObject:view];
//        for (int j = 0; j < _countArr.count; j++) {
//
//            UIView *view = [[UIView alloc] init];
//            view.backgroundColor = [UIColor whiteColor];
//            view.tag = [_countArr[j][@"id"] integerValue];
//            [_viewArr addObject:view];
//
//            IntentSurveyHeader *header = [[IntentSurveyHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
//
//            if (_countArr[j][@"param"]) {
//
//                header.titleL.text = [NSString stringWithFormat:@"意向物业-%@",_countArr[j][@"param"]];
//            }else{
//
//                header.titleL.text = [NSString stringWithFormat:@"意向物业-%@",_countArr[j][@"property_name"]];
//            }
//            [_headArr addObject:header];
        _labelArr = [@[] mutableCopy];
        _moduleArr = [@[] mutableCopy];
        _selectArr = [@[] mutableCopy];
//            [_labelArr addObject:@[]];
//            [_moduleArr addObject:@[]];
//            [_selectArr addObject:@[]];
//        }
    }else{

        NSMutableArray *tempArr = [@[] mutableCopy];
        NSMutableArray *tempMrr = [@[] mutableCopy];
        NSMutableArray *tempSelect = [@[] mutableCopy];

        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
//        view.tag = [_countArr[a][@"id"] integerValue];
        [_viewArr addObject:view];
        for (int i = 0; i < data.count; i++) {

            NSDictionary *dic = data[i];

            UILabel *label = [[UILabel alloc] init];
            label.textColor = CLTitleLabColor;
            label.font = [UIFont systemFontOfSize:13 *SIZE];
            label.text = dic[@"defined_name"];
            label.adjustsFontSizeToFitWidth = YES;
            if ([dic[@"is_must"] integerValue] == 1) {

                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",label.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                label.attributedText = attr;
            }
            [tempArr addObject:label];

            switch ([dic[@"type"] integerValue]) {
                                            
                case 1:
                {
                                                
                    BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    tf.tag = i * 100 + i;
//                        for (int k = 0; k < [_countArr[0][@"list"] count]; k++) {
//
//                            if ([dic[@"defined_name"] isEqualToString:_countArr[0][@"list"][k][@"defined_name"]]) {
//
//                                tf.textField.text = _countArr[0][@"list"][k][@"value"];
//                            }
//                        }
                    [tempMrr addObject:tf];
                    tempSelect = [NSMutableArray arrayWithArray:@[]];
                                                
                    break;
                }
                case 2:
                {
                    DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    btn.tag = i * 100 + i;
                    [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
//                        for (int k = 0; k < [_countArr[0][@"list"] count]; k++) {
//
//                            if ([dic[@"config_name"] isEqualToString:_countArr[0][@"list"][k][@"config_name"]]) {
//
//                                btn.content.text = _countArr[0][@"list"][k][@"value"];
//                                btn->str = _countArr[0][@"list"][k][@"value_id"];
//                            }
//                        }
                    [tempMrr addObject:btn];
                    tempSelect = [NSMutableArray arrayWithArray:@[]];
                }
                case 3:
                {
                    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
                    flowLayout.itemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
                    flowLayout.minimumLineSpacing = 5 *SIZE;
                    flowLayout.minimumInteritemSpacing = 0;
                        
                    UICollectionView *coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:flowLayout];
                    coll.backgroundColor = [UIColor whiteColor];
                    coll.tag = i * 100 + i;
                    coll.bounces = NO;
                    coll.delegate = self;
                    coll.dataSource = self;
                    [coll registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
                    [tempMrr addObject:coll];
                    NSMutableArray *collSelect = [@[] mutableCopy];
                    for (int m = 0; m < [dic[@"option"] count]; m++) {
                            
                        [collSelect addObject:@0];
                    }
//                        for (int m = 0; m < [dic[@"option"] count]; m++) {
//
//                            for (int k = 0; k < [_countArr[0][@"list"] count]; k++) {
//
//                                if ([dic[@"config_name"] isEqualToString:_countArr[0][@"list"][k][@"config_name"]]) {
//
//                                    NSArray *arrC = [_countArr[0][@"list"][k][@"value_id"] componentsSeparatedByString:@","];
//
//                                    for (int n = 0; n < arrC.count; n++) {
//
//                                        if ([dic[@"option"][m][@"option_id"] integerValue] == [arrC[n] integerValue]) {
//
//                                            [collSelect replaceObjectAtIndex:m withObject:@1];
//                                        }
//                                    }
//                                }
//                            }
//                        }
                    tempSelect = [NSMutableArray arrayWithArray:collSelect];
//                        [tempSelect addObject:collSelect];
                    break;
                }
                case 4:
                {
                    DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    btn.tag = i * 100 + i;
                    [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
//                        for (int k = 0; k < [_countArr[0][@"list"] count];k++) {
//
//                            if ([dic[@"config_name"] isEqualToString:_countArr[0][@"list"][k][@"config_name"]]) {
//
//                                btn.content.text = _countArr[0][@"list"][k][@"value"];
//                                btn->str = _countArr[0][@"list"][k][@"value_id"];
//                            }
//                        }
                    [tempMrr addObject:btn];
                    tempSelect = [NSMutableArray arrayWithArray:@[]];
                    break;
                }
                default:
                    break;
            }
            _labelArr = [NSMutableArray arrayWithArray:tempArr];
            _moduleArr = [NSMutableArray arrayWithArray:tempMrr];
            [_selectArr addObject:tempSelect];
        }
    }
}

- (void)ActionTagNumBtn:(DropBtn *)btn{
    
}

- (void)ActionNextBtn:(UIButton *)btn{
    
//    if ([self.status isEqualToString:@"modify"]) {
//
//    }else{
//
//
//    }
    [_lastArr removeAllObjects];
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSDictionary *dic = _dataArr[i];
        
        NSMutableDictionary *needDic = [[NSMutableDictionary alloc] init];
        switch ([dic[@"type"] integerValue]) {
         
            case 1:
            {
                BorderTextField *tf = _moduleArr[i];
                if (![self isEmpty:tf.textField.text]) {
                    
                    [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
                    [needDic setObject:tf.textField.text forKey:@"value"];
                    [needDic setObject:@"0" forKey:@"option_list"];
                }else{
                    
                    if ([dic[@"is_must"] integerValue] == 1) {
                        
                        [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请输入%@",dic[@"defined_name"]]];
                        return;
                    }else{
                        
//                        [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
//                        [needDic setObject:@"" forKey:@"value"];
//                        [needDic setObject:@"0" forKey:@"option_list"];
                    }
                }
                break;
            }
            case 2:
            {
                DropBtn *btn = _moduleArr[i];
                if (btn.content.text) {
                    
                    [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
                    [needDic setObject:btn.content.text forKey:@"value"];
                    [needDic setObject:dic[@"option_id"] forKey:@"option_list"];
                }else{
                    
                    if ([dic[@"is_must"] integerValue] == 1) {
                        
                        [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"defined_name"]]];
                        return;
                    }else{
                        
//                        [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
//                        [needDic setObject:@"" forKey:@"value"];
//                        [needDic setObject:@"" forKey:@"option_list"];
                    }
                }
                break;
            }
            case 3:
            {
                NSArray *arr = _selectArr[i];
                if (arr.count) {
                    
                    NSString *strId;
                    NSString *str;
                    for (int m = 0; m < arr.count; m++) {
                        
                        if ([arr[m] integerValue] == 1) {
                            
                            if (!str.length) {
                                
                                str = [NSString stringWithFormat:@"%@",dic[@"option"][m][@"option_name"]];
                                strId = [NSString stringWithFormat:@"%@",dic[@"option"][m][@"option_id"]];
                            }else{
                                
                                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"option"][m][@"option_name"]];
                                strId = [NSString stringWithFormat:@"%@,%@",strId,dic[@"option"][m][@"option_id"]];
                            }
                        }
                    }
                    [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
                    if (str.length) {
                    
                        [needDic setObject:str forKey:@"value"];
                        [needDic setObject:strId forKey:@"option_list"];
                    }else{
                        
                        [needDic setObject:@"" forKey:@"value"];
                        [needDic setObject:@"" forKey:@"option_list"];
                    }
                }else{
                    
                    if ([dic[@"is_must"] integerValue] == 1) {
                        
                        [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                        return;
                    }else{
                        
//                        [needDic setObject:dic[@"property_id"] forKey:@"property_id"];
//                        [needDic setObject:@"" forKey:@"value"];
//                        [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
//                        [needDic setObject:@"" forKey:@"value_id"];
                        
                    }
                }
                break;
            }
            case 4:
            {
                DropBtn *btn = _moduleArr[i];
                if (btn.content.text) {
                    
                    [needDic setObject:dic[@"defined_id"] forKey:@"defined_id"];
                    [needDic setObject:btn.content.text forKey:@"value"];
                    [needDic setObject:btn.content.text forKey:@"option_list"];
                }else{
                    
                    if ([dic[@"is_must"] integerValue] == 1) {
                        
                        [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                        return;
                    }else{
                        
//                        [needDic setObject:dic[@"property_id"] forKey:@"property_id"];
//                        [needDic setObject:@"" forKey:@"value"];
//                        [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
//                        [needDic setObject:@"" forKey:@"value_id"];
                    }
                }
                break;
            }
            default:
                break;
        }
        [_lastArr addObject:needDic];
    }
    if (_lastArr.count) {
    
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_lastArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [_dataDic setObject:jsonString forKey:@"need_list"];
    }
    AddStoreFollowRecordVC *nextVC = [[AddStoreFollowRecordVC alloc] init];
    nextVC.allDic = _dataDic;
    nextVC.status = @"add";
    nextVC.addStoreFollowRecordVCBlock = ^{
        
        if (self.addStoreNeedVCBlock) {
            
            self.addStoreNeedVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
//    [BaseRequest POST:ProjectBusinessAdd_URL parameters:_dataDic success:^(id  _Nonnull resposeObject) {
//        
//        if ([resposeObject[@"code"] integerValue] == 200) {
//            
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//                
//                if ([vc isKindOfClass:[StoreVC class]]) {
//                    
//                    [self.navigationController popToViewController:vc animated:YES];
//                }
//            }
//        }else{
//            
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        
//        [self showContent:@"网络错误"];
//    }];
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger iNum = collectionView.tag / 100;
    NSInteger jNum = collectionView.tag % 100;
    return [_dataArr[jNum][@"option"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 20 *SIZE)];
    }
//    cell.selectImg.image = [UIImage imageNamed:@"default"];
    
    cell.tag = 1;
    
    NSInteger iNum = collectionView.tag / 100;
    NSInteger jNum = collectionView.tag % 100;
    [cell setIsSelect:[_selectArr[jNum][indexPath.item] integerValue]];
    cell.titleL.text = _dataArr[jNum][@"option"][indexPath.item][@"option_name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger iNum = collectionView.tag / 100;
    NSInteger jNum = collectionView.tag % 100;
    
    NSMutableArray *temp1 = [[NSMutableArray alloc] initWithArray:_selectArr[jNum]];
//    NSMutableArray *temp2 = [[NSMutableArray alloc] initWithArray:temp1[jNum]];
//    NSMutableArray *temp3 = [[NSMutableArray alloc] initWithArray:temp2[indexPath.item]];
    if ([temp1[indexPath.item] integerValue] == 1) {

        [temp1 replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{

        [temp1 replaceObjectAtIndex:indexPath.item withObject:@1];
    }
//    [temp1 replaceObjectAtIndex:jNum withObject:temp2];
    [_selectArr replaceObjectAtIndex:jNum withObject:temp1];
    [collectionView reloadData];
}

- (void)initUI{
    
    self.titleLabel.text = @"需求信息";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
//    if ([self.status isEqualToString:@"add"]) {
//
//        [_nextBtn setTitle:@"确认" forState:UIControlStateNormal];
//    }else if ([self.status isEqualToString:@"modify"]){
//
//        [_nextBtn setTitle:@"确认" forState:UIControlStateNormal];
//    }else{
//
//        [_nextBtn setTitle:@"下一步 跟进记录" forState:UIControlStateNormal];
//    }
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
        make.bottom.equalTo(self.view).offset(-47 *SIZE + TAB_BAR_MORE);
    }];
    
    UIView *view = _viewArr[0];
    [_scrollView addSubview:_viewArr[0]];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(self->_scrollView).offset(0);
    }];
    
    for (int j = 0; j < _moduleArr.count; j++) {
        
        [view addSubview:_labelArr[j]];
        [view addSubview:_moduleArr[j]];
        if (j == 0) {
            
            if ([_moduleArr count] == 1) {
                
                [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(view).offset(10 *SIZE);
                    make.top.equalTo(view).offset(21 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                    //                            make.bottom.equalTo(view).offset(-21 *SIZE);
                }];
                
                [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(view).offset(80 *SIZE);
                    make.top.equalTo(view).offset(11 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                    make.bottom.equalTo(view).offset(-21 *SIZE);
                }];
            }else{
                
                [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(view).offset(10 *SIZE);
                    make.top.equalTo(view).offset(21 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
                
                [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(view).offset(80 *SIZE);
                    make.top.equalTo(view).offset(11 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
            }
        }else{
            
            NSDictionary *dic = _dataArr[j];
            switch ([dic[@"type"] integerValue]) {
                    
                case 1:
                {
                    BorderTextField *tf = _moduleArr[j - 1];
                    [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (j == [_moduleArr count] - 1) {
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(view).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 2:
                {
                    DropBtn *tf = _moduleArr[j - 1];
                    [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (j == [_moduleArr count] - 1) {
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(view).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 3:
                {
                    
                    DropBtn *tf = _moduleArr[j - 1];
                    UICollectionView *coll = _moduleArr[j];
                    [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (j == [_moduleArr count] - 1) {
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                            make.bottom.equalTo(view).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            //                                    make.height.mas_equalTo(100 *SIZE);
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                        }];
                    }
                    
                    break;
                }
                case 4:
                {
                    DropBtn *tf = _moduleArr[j - 1];
                    [_labelArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (j == [_moduleArr count] - 1) {
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(view).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[j] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(view).offset(80 *SIZE);
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
