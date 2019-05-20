//
//  WorkerPickView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkerPickView.h"

#define PICKERHEIGHT 216
#define BGHEIGHT     256

//#define KEY_WINDOW_HEIGHT [UIApplication sharedApplication].keyWindow.frame.size.height

@interface WorkerPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

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
 记录选中的位置
 */
@property(nonatomic, assign) NSInteger selected;



@property (nonatomic , strong) NSString *GSMC;

@property (nonatomic , strong) NSString *ID;

@property (nonatomic, strong) NSString *RYBH;

@property (nonatomic, strong) NSString *RYDH;

@property (nonatomic, strong) NSString *RYTP;

@property (nonatomic, strong) NSString *RYXM;

@end

@implementation WorkerPickView

#pragma mark -- lazy
- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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
        [_sureBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
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
- (UIView *)bgView  //主视图
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

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)date
{
    if (self = [super initWithFrame:frame]) {
        [self initSuViews];
        self.dataSource=date;
        self.selected = 0;
        if (date.count == 0) {
            _dataSource = @[@{@"GSMC":@"",
                              @"ID":@"",
                              @"RYBH":@"",
                              @"RYDH":@"",
                              @"RYTP":@"",
                              @"RYXM":@""
                              }];
        }
        self.GSMC = _dataSource[0][@"GSMC"];
        self.ID = _dataSource[0][@"ID"];
        self.RYBH = _dataSource[0][@"RYBH"];
        self.RYDH = _dataSource[0][@"RYDH"];
        self.RYTP = _dataSource[0][@"RYTP"];
        self.RYXM = _dataSource[0][@"RYXM"];
    }
    return self;
}

#pragma mark -- 从plist里面读数据





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


//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_dataSource[row][@"GSMC"]) {
         return [NSString stringWithFormat:@"%@/%@/%@",_dataSource[row][@"GSMC"],_dataSource[row][@"RYXM"],_dataSource[row][@"RYDH"]];
    }
    else{
        return [NSString stringWithFormat:@"%@/%@",_dataSource[row][@"RYXM"],_dataSource[row][@"RYDH"]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.GSMC = _dataSource[row][@"GSMC"];
    self.ID = _dataSource[row][@"ID"];
    self.RYBH = _dataSource[row][@"RYBH"];
    self.RYDH = _dataSource[row][@"RYDH"];
    self.RYTP = _dataSource[row][@"RYTP"];
    self.RYXM = _dataSource[row][@"RYXM"];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14 *SIZE]];
        
    }
    
    // Fill the label text here
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}



#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    
    if (self.workerPickBlock) {
        
        self.workerPickBlock(self.GSMC, self.ID, self.RYBH, self.RYDH, self.RYXM, self.RYTP);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}

@end
