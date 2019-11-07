//
//  ModifyAndAddRentalView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyAndAddRentalView.h"

@interface ModifyAndAddRentalView ()<UITextFieldDelegate>
{

}
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation ModifyAndAddRentalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}


- (void)ActionComfirmBtn:(UIButton *)btn{
    
//    if (!_periodBtn.content.text.length) {
//        
//        [MBProgressHUD showError:@"请选择递增周期"];
//        return;
//    }
//    if (!_periodTF.textField.text.length) {
//        
//        [MBProgressHUD showError:@"请输入递增率"];
//        return;
//    }
    if (self.modifyAndAddRentalViewComfirmBtnBlock) {
        
        self.modifyAndAddRentalViewComfirmBtnBlock();
    }
    [self removeFromSuperview];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (self.modifyAndAddRentalViewBlock) {
        
        self.modifyAndAddRentalViewBlock();
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _periodTF.textField) {
        
        BOOL isHaveDian;
        
        //判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            NSLog(@"single = %c",single);
            
            //不能输入.0~9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.')){
                NSLog(@"您输入的格式不正确");
                return NO;
            }
            
            //只能有一个小数点
            if (isHaveDian && single == '.') {
                NSLog(@"只能输入一个小数点");
                return NO;
            }
            
            //如果第一位是.则前面加上0
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            //如果第一位是0则后面必须输入.
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }
            }
            
            //小数点后最多能输入两位
//            if (isHaveDian) {
//                NSRange ran = [textField.text rangeOfString:@"."];
//                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
//                if (range.location > ran.location) {
//                    if ([textField.text pathExtension].length > 1) {
//                        NSLog(@"小数点后最多有两位小数");
//                        return NO;
//                    }
//                }
//            }
        }
        
        return YES;
    }else{
        
        return YES;
    }
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(40 *SIZE, 200 *SIZE, 280 *SIZE, 200 *SIZE)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5 *SIZE;
    alertView.clipsToBounds = YES;
    [self addSubview:alertView];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 30 *SIZE + i * 60 *SIZE, 70 *SIZE, 14 *SIZE)];
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = CLTitleLabColor;
        label.font = FONT(13 *SIZE);
        if (i == 0) {
            
            label.text = @"租金递增周期：";
        }else{
            
            label.text = @"租金递增率：";
        }
        [alertView addSubview:label];
    }
    
    _periodBtn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 20 *SIZE, 180 *SIZE, 33 *SIZE)];
    [_periodBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:_periodBtn];
    
    //添加输入框
    _periodTF = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 80 *SIZE, 180 *SIZE, 33 *SIZE)];
    _periodTF.textField.delegate = self;
    [alertView addSubview:_periodTF];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, 160 *SIZE, 140 *SIZE, 40 *SIZE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(140 *SIZE, 160 *SIZE, 140 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [alertView addSubview:_confirmBtn];
    
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 159 *SIZE, 280 *SIZE, SIZE)];
    horizontal.backgroundColor = CLBackColor;
    [alertView addSubview:horizontal];
    
    UIView *vertical = [[UIView alloc] initWithFrame:CGRectMake(140 *SIZE, 160 *SIZE, SIZE, 40 *SIZE)];
    vertical.backgroundColor = CLBackColor;
    [alertView addSubview:vertical];
}

@end
