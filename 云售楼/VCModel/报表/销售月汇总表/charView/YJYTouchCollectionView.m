//
//  YJYTouchCollectionView.m
//  YJYConsultant
//
//  Created by 谷治墙 on 2018/10/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "YJYTouchCollectionView.h"

@implementation YJYTouchCollectionView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
    
}

@end
