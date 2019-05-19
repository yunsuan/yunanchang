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

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "IntentSurveyHeader.h"
#import "TitleBaseHeader.h"
#import "BoxSelectCollCell.h"
#import "GZQFlowLayout.h"

@interface IntentSurveyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_propertyId;
    
    NSArray *_countArr;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_viewArr;
    NSMutableArray *_labelArr;
    NSMutableArray *_moduleArr;
    NSMutableArray *_lastArr;
    
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

//@property (nonatomic, strong) UIView *needInfoView;
//
//@property (nonatomic, strong) GZQFlowLayout *flowLayout;
//
//@property (nonatomic, strong) UICollectionView *intentColl;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation IntentSurveyVC

- (instancetype)initWithData:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        _countArr = data;
    }
    return self;
}

//- (instancetype)initWithPropertyId:(NSString *)propertyId
//{
//    self = [super init];
//    if (self) {
//
//        _propertyId = propertyId;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _viewArr = [@[] mutableCopy];
    _moduleArr = [@[] mutableCopy];
    _labelArr = [@[] mutableCopy];
    _lastArr = [@[] mutableCopy];;
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
}

- (void)RequestMethod{
    
    NSString *propertyId;
    for (NSDictionary *dic in _countArr) {
        
        if (!propertyId.length) {
            
            propertyId = [NSString stringWithFormat:@"%@",dic[@"id"]];
        }else{
            
            propertyId = [NSString stringWithFormat:@"%@,%@",propertyId,dic[@"id"]];
        }
    }
    [BaseRequest GET:ProjectConfigPropertyConfigList_URL parameters:@{@"property_id":propertyId} success:^(id  _Nonnull resposeObject) {
        
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

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = [data[i][@"property_id"] integerValue];
        [_viewArr addObject:view];
        
        NSArray *arr = data[i][@"list"];
        NSMutableArray *tempArr = [@[] mutableCopy];
        NSMutableArray *tempMrr = [@[] mutableCopy];
        
        for (int j = 0; j < arr.count; j++) {
            
            NSDictionary *dic = arr[j];
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = CLTitleLabColor;
            label.font = [UIFont systemFontOfSize:13 *SIZE];
            label.text = dic[@"config_name"];
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
                    tf.tag = i * 100 + j;
                    [tempMrr addObject:tf];
                    break;
                }
                case 2:
                {
                    DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    btn.tag = i * 100 + j;
                    [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [tempMrr addObject:btn];
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
                    coll.tag = i * 100 + j;
                    coll.bounces = NO;
                    coll.delegate = self;
                    coll.dataSource = self;
                    [coll registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
                    [tempMrr addObject:coll];
                    
                    break;
                }
                case 4:
                {
                    DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    btn.tag = i * 100 + j;
                    [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [tempMrr addObject:btn];
                    break;
                }
                default:
                    break;
            }
        }
        
        [_labelArr addObject:tempArr];
        [_moduleArr addObject:tempMrr];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"modify"]) {
        
        NSMutableDictionary *tempDic = [@{} mutableCopy];
        [_lastArr removeAllObjects];
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSArray *arr = _dataArr[i][@"list"];
            for (int j = 0; j < arr.count; j++) {
                
                NSMutableDictionary *needDic = [[NSMutableDictionary alloc] init];
                NSDictionary *dic = arr[j];
                switch ([dic[@"type"] integerValue]) {
                        
                    case 1:
                    {
                        BorderTextField *tf = _moduleArr[i][j];
                        if (![self isEmpty:tf.textField.text]) {
                            
                            [needDic setObject:tf.textField.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请输入%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 2:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    case 4:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    default:
                        break;
                }
                if (needDic.count) {
                    
                    [_lastArr addObject:needDic];
                }
            }
        }
        
        if (_lastArr.count) {
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_lastArr options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            [tempDic setObject:jsonString forKey:@"need_list"];
            [tempDic setObject:self.property_id forKey:@"property_id"];
//            [temp]
        }
        
        if (!tempDic.count) {
            
            [self alertControllerWithNsstring:@"选择需求信息" And:@"请选择完善意向调查"];
            return;
        }
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSDictionary *dic = @{@"need_list":jsonString,@"need_id":self.need_id,@"property_id":self.property_id};
        [BaseRequest POST:WorkClientAutoNeedUpdate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self.intentSurveyVCBlock) {
                    
                    self.intentSurveyVCBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else if([self.status isEqualToString:@"add"]){
        
        NSMutableDictionary *tempDic = [@{} mutableCopy];
        [_lastArr removeAllObjects];
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSArray *arr = _dataArr[i][@"list"];
            for (int j = 0; j < arr.count; j++) {
                
                NSMutableDictionary *needDic = [[NSMutableDictionary alloc] init];
                NSDictionary *dic = arr[j];
                switch ([dic[@"type"] integerValue]) {
                        
                    case 1:
                    {
                        BorderTextField *tf = _moduleArr[i][j];
                        if (![self isEmpty:tf.textField.text]) {
                            
                            [needDic setObject:tf.textField.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请输入%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 2:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    case 4:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    default:
                        break;
                }
                if (needDic.count) {
                    
                    [_lastArr addObject:needDic];
                }
            }
        }
        
//        if (_lastArr.count) {
        
//            NSError *error;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_lastArr options:NSJSONWritingPrettyPrinted error:&error];
//            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//            [tempDic setObject:jsonString forKey:@"need_list"];
//            [tempDic setObject:self.property_id forKey:@"property_id"];
//        }
        
        if (!_lastArr.count) {
            
            [self alertControllerWithNsstring:@"选择需求信息" And:@"请选择完善意向调查"];
            return;
        }
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_lastArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSDictionary *dic = @{@"need_list":jsonString,@"group_id":self.group_id,@"property_id":self.property_id};
        
        [BaseRequest POST:WorkClientAutoNeedAdd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self.intentSurveyVCBlock) {
                    
                    self.intentSurveyVCBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [_lastArr removeAllObjects];
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSArray *arr = _dataArr[i][@"list"];
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int j = 0; j < arr.count; j++) {
                
                NSMutableDictionary *needDic = [[NSMutableDictionary alloc] init];
                NSDictionary *dic = arr[j];
                switch ([dic[@"type"] integerValue]) {
                        
                    case 1:
                    {
                        BorderTextField *tf = _moduleArr[i][j];
                        if (![self isEmpty:tf.textField.text]) {
                            
                            [needDic setObject:tf.textField.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请输入%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 2:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    case 4:
                    {
                        DropBtn *btn = _moduleArr[i][j];
                        if (btn.content.text) {
                            
                            [needDic setObject:btn.content.text forKey:@"value"];
                            [needDic setObject:dic[@"config_id"] forKey:@"config_id"];
                            [needDic setObject:dic[@"config_name"] forKey:@"config_name"];
                        }else{
                            
                            if ([dic[@"is_must"] integerValue] == 1) {
                                
                                [self alertControllerWithNsstring:@"完善信息" And:[NSString stringWithFormat:@"请选择%@",dic[@"config_name"]]];
                                return;
                            }
                        }
                        break;
                    }
                    default:
                        break;
                }
                if (needDic.count) {
                    
                    [tempArr addObject:needDic];
                }
            }
            [_lastArr addObject:tempArr];
        }
        
        NSMutableArray *arr = [@[] mutableCopy];
        if (_lastArr.count) {
            
            for (int i = 0; i < _lastArr.count; i++) {
                
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_lastArr[i] options:NSJSONWritingPrettyPrinted error:&error];
                NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSDictionary *dic = @{@"property_id":_dataArr[i][@"property_id"],@"need_list":jsonString};
                [arr addObject:dic];
            }

            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            [self.allDic setObject:jsonString forKey:@"need_list"];
        }
        
        FollowRecordVC *nextVC = [[FollowRecordVC alloc] init];
        nextVC.allDic = self.allDic;
        nextVC.status = @"add";
        nextVC.info_id = self.info_id;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


- (void)ActionTagNumBtn:(DropBtn *)btn{
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSArray *arr = _dataArr[i][@"list"];
        for (int j = 0; j < arr.count; j++) {
            
            if ((i * 100 + j) == btn.tag) {
                
                if ([arr[j][@"type"] integerValue] == 2) {
                    
                    NSMutableArray *tempArr = [@[] mutableCopy];
                    for (int k = 0; k < [arr[j][@"option"] count]; k++) {
                        
                        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:arr[j][@"option"][k]];
                        [tempDic setObject:tempDic[@"option_name"] forKey:@"param"];
                        [tempDic setObject:tempDic[@"option_id"] forKey:@"id"];
                        [tempDic removeObjectForKey:@"option_id"];
                        [tempDic removeObjectForKey:@"option_name"];
                        [tempArr addObject:tempDic];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:tempArr];
                    
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        btn.content.text = MC;
                        btn->str = [NSString stringWithFormat:@"%@",ID];
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:self->_moduleArr[i]];
                        [arr replaceObjectAtIndex:j withObject:btn];
                        [self->_moduleArr replaceObjectAtIndex:i withObject:arr];
                    };
                    [self.view addSubview:view];
                    break;
                }else{
                    
                    DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
                    view.dateblock = ^(NSDate *date) {
                        
                        btn.content.text = [self->_formatter stringFromDate:date];
                        btn->str = [self->_formatter stringFromDate:date];
                        [self->_moduleArr replaceObjectAtIndex:i withObject:btn];
                    };
                    [self.view addSubview:view];
                    break;
                }
            }
        }
    }
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[collectionView.tag][@"config"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 130 *SIZE, 20 *SIZE)];
    }
    cell.selectImg.image = [UIImage imageNamed:@"default"];
    //        [cell setIsSelect:[_selectAllArr[collectionView.tag][indexPath.item] integerValue]];
    
    cell.titleL.text = _dataArr[collectionView.tag][@"config"][indexPath.item][@"config_name"];
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"意向调查";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.status isEqualToString:@"add"]) {
        
        [_nextBtn setTitle:@"确认" forState:UIControlStateNormal];
    }else if ([self.status isEqualToString:@"modify"]){
        
        [_nextBtn setTitle:@"确认" forState:UIControlStateNormal];
    }else{
        
        [_nextBtn setTitle:@"下一步 跟进记录" forState:UIControlStateNormal];
    }
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

    for (int i = 0; i < _viewArr.count; i++) {
        
        [_scrollView addSubview:_viewArr[i]];
        if (i == 0) {
            
            UIView *view = _viewArr[0];
            if (_viewArr.count == 1) {
                
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_scrollView).offset(0);
                    make.top.equalTo(self->_scrollView).offset(0);
                    make.right.equalTo(self->_scrollView).offset(0);
                    make.width.equalTo(@(SCREEN_Width));
                    make.bottom.equalTo(self->_scrollView).offset(0);
                }];
            }else{
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_scrollView).offset(0);
                    make.top.equalTo(self->_scrollView).offset(0);
                    make.right.equalTo(self->_scrollView).offset(0);
                    make.width.equalTo(@(SCREEN_Width));
                }];
            }
            
            for (int j = 0; j < [_moduleArr[i] count]; j++) {
                
                [view addSubview:_labelArr[i][j]];
                [view addSubview:_moduleArr[i][j]];
                if (j == 0) {
                    
                    [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(10 *SIZE);
                        make.top.equalTo(view).offset(21 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(view).offset(80 *SIZE);
                        make.top.equalTo(view).offset(11 *SIZE);
                        make.width.equalTo(@(258 *SIZE));
                        make.height.equalTo(@(33 *SIZE));
                    }];
                }else{
                    
                    NSDictionary *dic = _dataArr[i][@"list"][j];
                    switch ([dic[@"type"] integerValue]) {
                            
                        case 1:
                        {
                            BorderTextField *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(view).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(view).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(view).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
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
                            DropBtn *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(view).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(view).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(view).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
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
                            
                            DropBtn *tf = _moduleArr[i][j - 1];
                            UICollectionView *coll = _moduleArr[i][j];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(view).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(view).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                                    make.bottom.equalTo(view).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(view).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                                }];
                            }
                            
                            break;
                        }
                        case 4:
                        {
                            DropBtn *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(view).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(view).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(view).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
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
        }else{
            
            UIView *view = _viewArr[i - 1];
            UIView *bomView = _viewArr[i];
            if (i == _viewArr.count - 1) {
                
                [_viewArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_scrollView).offset(0);
                    make.top.equalTo(view.mas_bottom).offset(8 *SIZE);
                    make.right.equalTo(self->_scrollView).offset(0);
                    make.width.equalTo(@(SCREEN_Width));
                    make.bottom.equalTo(self->_scrollView).offset(0);
                }];
            }else{
                
                [_viewArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_scrollView).offset(0);
                    make.top.equalTo(view.mas_bottom).offset(8 *SIZE);
                    make.right.equalTo(self->_scrollView).offset(0);
                    make.width.equalTo(@(SCREEN_Width));
                }];
            }
            for (int j = 0; j < [_moduleArr[i] count]; j++) {
                
                [bomView addSubview:_labelArr[i][j]];
                [bomView addSubview:_moduleArr[i][j]];
                if (j == 0) {
                    
                    [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(bomView).offset(10 *SIZE);
                        make.top.equalTo(bomView).offset(21 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(bomView).offset(80 *SIZE);
                        make.top.equalTo(bomView).offset(11 *SIZE);
                        make.width.equalTo(@(258 *SIZE));
                        make.height.equalTo(@(33 *SIZE));
                    }];
                }else{
                    
                    NSDictionary *dic = _dataArr[i][@"list"][j];
                    switch ([dic[@"type"] integerValue]) {
                            
                        case 1:
                        {
                            BorderTextField *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(bomView).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(bomView).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                }];
                            }
                            
                            break;
                        }
                        case 2:
                        {
                            DropBtn *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(bomView).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(bomView).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                }];
                            }
                            
                            break;
                        }
                        case 3:
                        {
                            
                            DropBtn *tf = _moduleArr[i][j - 1];
                            UICollectionView *coll = _moduleArr[i][j];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(bomView).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                                    make.bottom.equalTo(bomView).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                                }];
                            }
                            
                            break;
                        }
                        case 4:
                        {
                            DropBtn *tf = _moduleArr[i][j - 1];
                            [_labelArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(bomView).offset(10 *SIZE);
                                make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                                make.width.equalTo(@(70 *SIZE));
                                make.height.equalTo(@(13 *SIZE));
                            }];
                            
                            if (j == [_moduleArr[i] count] - 1) {
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
                                    make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                                    make.width.equalTo(@(258 *SIZE));
                                    make.height.equalTo(@(33 *SIZE));
                                    make.bottom.equalTo(bomView).offset(-21 *SIZE);
                                }];
                            }else{
                                
                                [_moduleArr[i][j] mas_makeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.left.equalTo(bomView).offset(80 *SIZE);
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
    }
}

@end
