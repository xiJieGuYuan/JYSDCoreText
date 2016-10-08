//
//  UIButton+Delay.m
//  Test001
//
//  Created by StriEver on 16/4/18.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "UIButton+Delay.h"
#import <objc/runtime.h>
#define defaultInteral  @"1"
@implementation UIButton (Delay)
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (!self.isNeedDelay) {
        [super sendAction:action to:target forEvent:event];
        return;
    }
    self.delayInterval = [defaultInteral integerValue] ; //倒计时时间
    if (self.timer) {
       dispatch_source_cancel(self.timer);
        self.timer = nil;
    
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (!self.timer) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    }
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
    if(self.delayInterval==0){ //倒计时结束，关闭
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        [super sendAction:action to:target forEvent:event];
        self.delayInterval = [defaultInteral integerValue];
    }else{
        [super sendAction:@selector(handleAction:) to:self forEvent:event];
        self.delayInterval--;
    }
});
      dispatch_resume(self.timer);

}
- (void)handleAction:(id)sender {
    
}
- (NSInteger)delayInterval{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
- (void)setDelayInterval:(NSInteger)delayInterval{
    objc_setAssociatedObject(self, @selector(delayInterval), @(delayInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (dispatch_source_t)timer{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTimer:(dispatch_source_t)timer{
    objc_setAssociatedObject(self, @selector(timer),timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void)setIsNeedDelay:(BOOL)isNeedDelay{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isNeedDelay), @(isNeedDelay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isNeedDelay{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
