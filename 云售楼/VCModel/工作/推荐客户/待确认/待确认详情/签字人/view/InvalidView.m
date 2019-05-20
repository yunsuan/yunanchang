//
//  InvalidView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InvalidView.h"

@implementation InvalidView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        _type_id =@"0";
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{

    
    if (!_type_id.length) {
    
        if (self.invalidViewBlockFail) {
            
            [self removeFromSuperview];
            self.invalidViewBlockFail(@"请选择无效类型");
        }
        return;
    }
    
//    if (_timeBtn.content.text) {
//
////        if (self.invalidViewBlockFail) {
////
////            [self removeFromSuperview];
////            self.invalidViewBlockFail(@"请选择到访时间");
////        }
////        return;
//    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{
//                                                                                   @"visit_time":_timeBtn.content.text,
                                                                                   @"client_id":_client_id,
                                                                                   @"disabled_state":_type_id
                                                                                   
                                                                                   }];

    
    if (_timeBtn.content.text) {
        
        [param setObject:_timeBtn.content.text forKey:@"visit_time"];
    }
    if (_reasonTV.text) {
        
        [param setObject:_reasonTV.text forKey:@"comment"];
    }
    if (self.invalidViewBlock) {
        
        self.invalidViewBlock(param);
        [self removeFromSuperview];
    }
}



-(void)action_time
{
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        
        self->_timeBtn.content.text = [self gettime:date];
    };
    [self addSubview:view];
    
}

-(void)action_type
{
    
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.frame WithData:[UserModelArchiver unarchive].Configdic[@"18"][@"param"]];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        self->_typeBtn.content.text = MC;
        self->_type_id = [NSString stringWithFormat:@"%@",ID];
    };
    [self addSubview:view];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}



- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 123 *SIZE, 250 *SIZE, 370 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(220 *SIZE, 4 *SIZE, 26 *SIZE, 26 *SIZE);
    [cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(23 *SIZE, 34 *SIZE + i * 80 *SIZE, 100 *SIZE, 13 *SIZE)];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                label.text = @"到访时间:";
                break;
            }
            case 1:
            {
                label.text = @"无效类型:";
                break;
            }
            case 2:
            {
                label.text = @"无效描述:";
                break;
            }
            default:
                break;
        }
        [whiteView addSubview:label];
        
        if (i < 2) {
            
            DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(23 *SIZE, 60 *SIZE + i * 80 *SIZE, 204 *SIZE, 33 *SIZE)];
            
            if (i == 0) {
                
                _timeBtn = btn;
                [_timeBtn addTarget:self action:@selector(action_time) forControlEvents:UIControlEventTouchUpInside];
                [whiteView addSubview:btn];
            }else{
                
                _typeBtn = btn;
                [_typeBtn addTarget:self action:@selector(action_type) forControlEvents:UIControlEventTouchUpInside];
                [whiteView addSubview:btn];
            }
        }else{
            
            _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(23 *SIZE, 216 *SIZE, 204 *SIZE, 77 *SIZE)];
            _reasonTV.contentInset = UIEdgeInsetsMake(5 *SIZE, 5 *SIZE, 5 *SIZE, 5 *SIZE);
            _reasonTV.layer.cornerRadius = 5 *SIZE;
            _reasonTV.layer.borderWidth = SIZE;
            _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
            _reasonTV.clipsToBounds = YES;
            [whiteView addSubview:_reasonTV];
        }
    }
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(23 *SIZE, 314 *SIZE, 203 *SIZE, 37 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteView addSubview:_confirmBtn];
}


-(NSString * _Nonnull)gettime:(NSDate * _Nonnull)date//nsdate转字符转
{
    NSDateFormatter*dateFormatter = [[NSDateFormatter  alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString*currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}


@end
