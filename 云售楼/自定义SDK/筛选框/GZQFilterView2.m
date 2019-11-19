//
//  GZQFilterView2.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "GZQFilterView2.h"

@interface GZQFilterView2 ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIButton *resetBtn;

@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation GZQFilterView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

/*重置按钮*/
- (void)didClickResetBtn:(UIButton*)sender{
    
    _levelBtn.content.text = @"";
    _followBeginBtn.content.text = @"";
    _followEndBtn.content.text = @"";
    
    _levelBtn.placeL.text = @"请选择客户等级：";
    _followBeginBtn.placeL.text = @"请选择开始时间：";
    _followEndBtn.placeL.text = @"请选择结束时间：";
}

/*完成按钮*/
- (void)didClickFinishBtn:(UIButton*)sender{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    if (_levelBtn.content.text) {
        
        [dic setValue:_levelBtn->str forKey:@"receive_state"];
        [dic setValue:_levelBtn.content.text forKey:@"receive_name"];
    }

    if (_followBeginBtn.content.text) {
        
        [dic setValue:[NSString stringWithFormat:@"%@ 00:00:00",_followBeginBtn.content.text] forKey:@"start_time"];
    }
    if (_followEndBtn.content.text) {
        
        [dic setValue:[NSString stringWithFormat:@"%@ 23:59:59",_followEndBtn.content.text] forKey:@"end_time"];
    }
    if (self.GzqFilterView2ConfirmBlock) {
        
        self.GzqFilterView2ConfirmBlock(dic);
    }
    [self removeFromSuperview];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.GzqFilterView2TagBlock) {
        
        self.GzqFilterView2TagBlock(btn.tag);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
//    self.backgroundColor = CLClearColor;
//    self.alpha = 1.0;
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(20 *SIZE, 100 *SIZE, 320 *SIZE, 300 *SIZE)];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 5 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, 10 *SIZE, 280 *SIZE, 20 *SIZE)];
    labe.text = @"更多查询";
    labe.font = [UIFont systemFontOfSize:17 *SIZE];
    labe.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:labe];
    
    NSArray *titleArr = @[@"开始时间：",@"结束时间：",@"付款状态："];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE + i * 63 *SIZE, 300 *SIZE, 14 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = FONT(13 *SIZE);
        label.text = titleArr[i];
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(10 *SIZE, 63 *SIZE + i * 63 *SIZE, 300 *SIZE, 33 *SIZE)];
        btn.placeL.text = [NSString stringWithFormat:@"请选择%@",label.text];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 2) {
            
            _levelL = label;
            [_whiteView addSubview:_levelL];
            
            _levelBtn = btn;
            [_whiteView addSubview:_levelBtn];
        }else if (i == 0){
            
            _followBeginL = label;
            [_whiteView addSubview:_followBeginL];
            
            _followBeginBtn = btn;
            [_whiteView addSubview:_followBeginBtn];
        }else{
            
            _followEndL = label;
            [_whiteView addSubview:_followEndL];
            
            _followEndBtn = btn;
            [_whiteView addSubview:_followEndBtn];
        }
    }

    _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetBtn.frame = CGRectMake(0 *SIZE, 260 *SIZE, 160 *SIZE, 40 *SIZE);
    [_resetBtn setBackgroundColor:CLBackColor];
    [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    _resetBtn.titleLabel.textColor = CLTitleLabColor;
    [_resetBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [_resetBtn setTitle:@"清空" forState:UIControlStateNormal];
    [_resetBtn addTarget:self action:@selector(didClickResetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_resetBtn];
    
    _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtn.frame = CGRectMake(160 *SIZE, 260 *SIZE, 160 *SIZE, 40 *SIZE);
    [_finishBtn setBackgroundColor:CLBlueBtnColor];
    [_finishBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_finishBtn setTitle:@"查询" forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(didClickFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_finishBtn];
}

@end
