//
//  ThirdPickView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ThirdPickView.h"

#define PICKERHEIGHT 216
#define BGHEIGHT     256

@interface ThirdPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSString *_unitName;
    NSString *_unitId;
}
/**
 pickerView
 */
@property(nonatomic, strong) UIPickerView * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;


/**
 一级数据
 */
@property(nonatomic, strong) NSArray * firstArr;



/**
 二级数据
 */
@property(nonatomic, strong) NSArray * secondArr;


/**
 三级数据
 */
@property(nonatomic, strong) NSArray * thirdArr;

/**
 所有数据
 */
@property(nonatomic, strong) NSArray * dataSource;

/**
 记录一级选中的位置
 */
@property(nonatomic, assign) NSInteger selected;

/**
 选中的一级
 */
@property(nonatomic, copy) NSString * firstStr;

/**
 选中的二级
 */
@property(nonatomic, copy) NSString * secondStr;

/**
 选中的三级
 */
@property(nonatomic, copy) NSString * thirdStr;


@property(nonatomic , copy)NSString *firstId;

@property(nonatomic , copy)NSString *secondId;

@property(nonatomic , copy)NSString *thirdId;

@end

@implementation ThirdPickView

#pragma mark -- lazy

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}




- (NSArray *)firstArr
{
    if (!_firstArr) {
        _firstArr = [NSArray array];
    }
    return _firstArr;
}


- (NSArray *)secondArr
{
    if (!_secondArr) {
        _secondArr = [NSArray array];
    }
    return _secondArr;
}


- (NSArray *)thirdArr
{
    if (!_thirdArr) {
        _thirdArr = [NSArray array];
    }
    return _thirdArr;
}
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data unitName:(nonnull NSString *)unitName unitId:(nonnull NSString *)unitId
{
    if (self = [super initWithFrame:frame]) {
        self.selected = 0;
        _unitId = unitId;
        _unitName = unitName;
        [self loadDatas:data];
        [self initSuViews];
    }
    return self;
}


#pragma mark -- 从plist里面读数据
- (void)loadDatas:(NSArray *)data
{
//    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
//
//    NSError *err;
//    _dataSource = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
    _dataSource = data;
    [self getFirstArr];
    if (!self.firstArr.count) {
        
        self.firstStr = @"";
        self.firstId = @"0";
    }else{
        
        self.firstStr = self.firstArr[0][_unitName];
        self.firstId = self.firstArr[0][_unitId];
    }
    
    if (!self.secondArr.count) {
        
        self.secondStr = @"";
        self.secondId = @"0";
    }else{
        
        [self getSecondArrByFirstArr:0];
        self.secondStr = self.secondArr[0][_unitName];
        self.secondId = self.secondArr[0][_unitId];
    }
    
    if (!self.thirdArr.count) {
        
        self.thirdStr = @"";
        self.thirdId = @"0";
    }else{
    
        [self getThirdArrBySecondArr:0];
        self.thirdStr = self.thirdArr[0][_unitName];
        self.thirdId = self.thirdArr[0][_unitId];
    }
}

-(void)getFirstArr
{
    _firstArr = _dataSource;
}

-(void)getSecondArrByFirstArr:(NSInteger)num
{
    if (_firstArr.count) {
        
        _secondArr = _firstArr[num][@"children"];
    }
}


-(void)getThirdArrBySecondArr:(NSInteger )num
{
    _thirdArr = _secondArr[num][@"children"];
}





#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self->_bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self->_bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.firstArr.count;
    }else if (component == 1){
        
        if (self.secondArr.count) {
            
            return self.secondArr.count;
        }else{
            
            return 0;
        }
    }else if (component == 2){
        
        if (self.thirdArr.count) {
            
            return self.thirdArr.count;
        }else{
            
            return 0;
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        
        label.text = self.firstArr[row][_unitName];
    }else if (component == 1){
        
        label.text = self.secondArr[row][_unitName];
    }else if (component == 2){
        
        label.text = self.thirdArr[row][_unitName];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        self.selected = row;
//        self.firstStr = self.firstArr[row][_unitName];
//        self.firstId = self.firstArr[row][_unitId];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        if (!self.firstArr.count) {
            
            self.firstStr = @"";
            self.firstId = @"0";
        }else{
            self.firstStr = self.firstArr[row][_unitName];
            self.firstId = self.firstArr[row][_unitId];
        }

        if (!self.secondArr.count) {
            
            self.secondStr = @"";
            self.secondId = @"0";
        }else{
            
            [self getSecondArrByFirstArr:row];
            self.secondStr = self.secondArr[0][_unitName];
            self.secondId = self.secondArr[0][_unitId];
        }
        
        if (!self.thirdArr.count) {
            
            self.thirdStr = @"";
            self.thirdId = @"0";
        }else{
            
            [self getThirdArrBySecondArr:0];
            self.thirdStr = self.thirdArr[0][_unitName];
            self.thirdId = self.thirdArr[0][_unitId];
        }

        
    }else if (component == 1){//选择市
        
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
//        self.secondStr = self.secondArr[row][_unitName];
//        self.secondId = self.secondArr[row][_unitId];
        if (!self.secondArr.count) {
            
            self.secondStr = @"";
            self.secondId = @"0";
        }else{
            self.secondStr = self.secondArr[row][_unitName];
            self.secondId = self.secondArr[row][_unitId];
        }
        
        if (!self.thirdArr.count) {
            
            self.thirdStr = @"";
            self.thirdId = @"0";
        }else{
            
            [self getThirdArrBySecondArr:row];
            self.thirdStr = self.thirdArr[0][_unitName];
            self.thirdId = self.thirdArr[0][_unitId];
        }
        
    }else if (component == 2){//选择区
        
        if (!self.thirdArr.count) {
            
            self.thirdStr = @"";
            self.thirdId = @"0";
        }else{
            self.thirdStr = self.thirdArr[row][_unitName];
            self.thirdId = self.thirdArr[row][_unitId];
        }
//        self.thirdStr = self.thirdArr[row][_unitName];
//        self.thirdId = self.thirdArr[row][_unitId];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    if (self.thirdPickViewBlock) {
        
        self.thirdPickViewBlock(self.firstStr, self.secondStr, self.thirdStr, self.firstId, self.secondId, self.thirdId);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}

@end
