//
//  GCDViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/10/13.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//
//1.给你这个A、B、C 三个任务并发，完成后执行任务 D
//2.先执行A,然后再执行B C D并发

#import "GCDViewController.h"

@interface GCDViewController ()
@property (assign, nonatomic) int index;

@end

@implementation GCDViewController

+(void)load{/**<load 方法会在加载类的时候就被调用，也就是 ios 应用启动的时候，就会加载所有的类，就会调用每个类的 + load 方法 */
    [super load];
    NSLog(@"执行了GCDViewController+++load方法");
}
+(void)initialize{/**<+ initialize 方法：苹果官方对这个方法有这样的一段描述：这个方法会在 第一次初始化这个类之前 被调用，我们用它来初始化静态变量 */
    [super initialize];
    NSLog(@"执行了initialize"); //2017-10-14 16:37:22.229 JYSDCoreText[336:57532] 执行了initialize
}
-(instancetype)init{
    if (self = [super init]) {
    NSLog(@"类的init方法");
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"类的ViewWillAppear");//16:37:35.952
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"执行了viewDidLoad");//16:37:25.317
    [self setNav];
    
    [self A_After_BCD_Func];
//  [self  ABC_After_D_Func];
}
-(void)setNav{
    self.title = @"GCD";
    self.view.backgroundColor = [UIColor whiteColor];
}
//说明dispatch_barrier_async的顺序执行还是依赖queue的类型啊，必需要queue的类型为dispatch_queue_create创建的，而且attr参数值必需是DISPATCH_QUEUE_CONCURRENT类型，前面两个非dispatch_barrier_async的类型的执行是依赖其本身的执行时间的，如果attr如果是DISPATCH_QUEUE_SERIAL时，那就完全是符合Serial queue的FIFO特征了。
//http://blog.csdn.net/wildfireli/article/details/18668897
////串行队列  DISPATCH_QUEUE_SERIAL
//dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", DISPATCH_QUEUE_SERIAL);
//并行队列  DISPATCH_QUEUE_CONCURRENT
//dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", DISPATCH_QUEUE_CONCURRENT);
-(void)A_After_BCD_Func{/**<先执行A然后再去执行BCD*///[NSThread sleepForTimeInterval:1];
    
    dispatch_queue_t queue = dispatch_queue_create("AAfterBCD",DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i <5; i++) {
        NSLog(@"==========================================================");
        dispatch_async(queue, ^{//第0个异步请求
            NSLog(@"0000000");
        });
        dispatch_async(queue, ^{//第一个异步请求
            NSLog(@"暂停之前的时间");
            [NSThread sleepForTimeInterval:3];
            NSLog(@"暂停之后的时间");
        });
        NSLog(@"---------------");
        dispatch_barrier_sync(queue, ^{//第二个异步请求
            NSLog(@"barrier_11111111111");
        });
        
        dispatch_async(queue, ^{//第三个个异步请求
            NSLog(@"22222222");
        });
        NSLog(@"==========================================================");
    }
    
    /**<
     #define NSEC_PER_SEC 1000000000ull
     #define USEC_PER_SEC 1000000ull
     #define NSEC_PER_USEC 1000ull
     NSEC：纳秒。
     USEC：微秒。
     SEC：秒
     PER：每
     */
    
    //1.获取全局并发队列
//         dispatch_queue_t queue1= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     //2.计算任务执行的时间
         dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
     //3.会在when这个时间点，执行queue中的这个任务  dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC))
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"延迟之后的效果 看一下");
    });
}

-(void)ABC_After_D_Func{/**<给你这个A、B、C 三个任务并发，完成后执行任务 D */
    
    //创建一个组队列
    dispatch_group_t group = dispatch_group_create();/**<创建一个队列组 */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    static dispatch_once_t onceToken;
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i <20; i++) {
        NSLog(@"--------------------------------------------------------------------");
//        __block int  index = 0;
        dispatch_group_async(group, queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"当前的线程:%@ =====执行了:任务A,index:%d",[NSThread currentThread],weakSelf.index);
            weakSelf.index = 1;
            NSLog(@"当前的线程:%@ =====执行了:任务A,index:%d",[NSThread currentThread],weakSelf.index);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_group_async(group, queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

            NSLog(@"当前的线程:%@ =====执行了:任务B,index:%d",[NSThread currentThread],weakSelf.index);
            weakSelf.index = 2;
            NSLog(@"当前的线程:%@ =====执行了:任务B,index:%d",[NSThread currentThread],weakSelf.index);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"B执行完成了之后,,回到了主线程");
            });
               dispatch_semaphore_signal(semaphore);
        });
        dispatch_group_async(group, queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"当前的线程:%@ =====执行了:任务C,index:%d",[NSThread currentThread],weakSelf.index);
            weakSelf.index = 3;
            NSLog(@"当前的线程:%@ =====执行了:任务C,index:%d",[NSThread currentThread],weakSelf.index);
               dispatch_semaphore_signal(semaphore);
        });
        dispatch_once(&onceToken, ^{
            NSLog(@"6666666666666666666666666666666666666666666666");
        });
    }
//    __weak typeof(self)weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"子线程当前都执行完了,回到主线程,执行DD ==== %@",[NSThread currentThread]);
        weakSelf.view.backgroundColor = [UIColor orangeColor];
    });
//    __block int  index = 0;
//    dispatch_group_async(group, queue, ^{
//
//        NSLog(@"当前的线程:%@ =====执行了:任务A,index:%d",[NSThread currentThread],index);
//        index = 1;
//        NSLog(@"当前的线程:%@ =====执行了:任务A,index:%d",[NSThread currentThread],index);
//        });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"当前的线程:%@ =====执行了:任务B,index:%d",[NSThread currentThread],index);
//
//        index = 2;
//        NSLog(@"当前的线程:%@ =====执行了:任务B,index:%d",[NSThread currentThread],index);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"B执行完成了之后,,回到了主线程");
//        });
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"当前的线程:%@ =====执行了:任务C,index:%d",[NSThread currentThread],index);
//
//        index = 3;
//        NSLog(@"当前的线程:%@ =====执行了:任务C,index:%d",[NSThread currentThread],index);
//
//    });
//    dispatch_group_wait(group , 0.000001);
//    NSLog(@"子线程当前都执行完了,执行DD");
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"子线程当前都执行完了,回到主线程,执行DD ==== %@",[NSThread currentThread]);
//    });
}
-(void)dealloc{
    NSLog(@"GCD_dealloc");
}
@end
