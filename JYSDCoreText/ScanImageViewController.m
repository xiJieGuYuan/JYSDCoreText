//
//  ScanImageViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2018/1/19.
//  Copyright © 2018年 MrReYun.demo. All rights reserved.
//


#import "ScanImageViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanImageViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * session;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * previewLayer;

@property (strong, nonatomic) NSTimer * timer;//为了做扫描动画的定时器
@property (strong, nonatomic) UIImageView * lineImage;//扫描动画的横线
@property (strong, nonatomic) UIView *outputView ;


@end

@implementation ScanImageViewController

#pragma mark -------- 懒加载---------
- (AVCaptureDevice *)device{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
- (AVCaptureDeviceInput *)input{
    if (!_input ) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
- (AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}
// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//  out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        // 1.获取屏幕的frame
        CGRect viewRect =self.view.frame;
        
        // 2.获取扫描容器的frame
        CGRect containerRect = CGRectMake(80, 100, 300, 300);
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        
        // CGRect outRect = CGRectMake(x, y, width, height);
        // [_output rectForMetadataOutputRectOfInterest:outRect];
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
}

-(UIImageView *)lineImage{
    if (!_lineImage) {
        CGFloat outputW = self.outputView.frame.size.width;
        _lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,outputW, 2)];
        _lineImage.image = [UIImage imageNamed:@"京东京豆"];
    }
    return _lineImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIView * testView = [[UIView alloc]initWithFrame:self.view.bounds];
        testView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    testView.opaque =NO;
//    testView.backgroundColor = [UIColor ];
    
    CGRect myRect =CGRectMake(100,100,200, 200);
    int radius = myRect.size.width/2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0, testView.bounds.size.width, testView.bounds.size.height)cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100,100,2.0*radius,2.0*radius)cornerRadius:radius];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor grayColor].CGColor;
    fillLayer.opacity =0.5;
    [testView.layer addSublayer:fillLayer];
    
    
    [self.view addSubview:testView];
    
    self.outputView = [[UIView alloc]initWithFrame:CGRectMake(80, 100, 300, 300)];
    _outputView.layer.borderColor = [UIColor redColor].CGColor;
    _outputView.layer.borderWidth = 2;
    _outputView.backgroundColor = [UIColor clearColor];
    [testView addSubview:_outputView];
    // 开始扫描二维码
    [self startScan];
}



- (void)startScan
{
    
    
    
    // 1.判断输入能否添加到会话中
    if (![self.session canAddInput:self.input]) return;
    [self.session addInput:self.input];

    // 2.判断输出能够添加到会话中
    if (![self.session canAddOutput:self.output]) return;
    [self.session addOutput:self.output];

    // 4.设置输出能够解析的数据类型
    // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;

    // 5.设置监听监听输出解析到的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    // 6.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = self.view.bounds;

    // 7.添加容器图层
//    [self.view.layer addSublayer:self.containerLayer];
//    self.containerLayer.frame = self.view.bounds;

    // 8.开始扫描
    [self.session startRunning];
    //9.添加动画
    [self.outputView addSubview:self.lineImage];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5f
                                                            target:self
                                                          selector:@selector(lineAction)
                                                          userInfo:nil
                                                           repeats:YES];
}
- (void)lineAction{
    CGFloat outputW = self.outputView.frame.size.width;
    CGFloat outputH = self.outputView.frame.size.height;
    [UIView animateWithDuration:2.4f animations:^{
        CGRect frame = CGRectMake(0, outputH-2, outputW, 2);
        self.lineImage.frame = frame;
    } completion:^(BOOL finished) {
        CGRect frame = CGRectMake(0, 0, outputW, 2);
        self.lineImage.frame = frame;
    }];
}

#pragma mark --------AVCaptureMetadataOutputObjectsDelegate ---------
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // id 类型不能点语法,所以要先去取出数组中对象
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];

    if (object == nil) return;
    // 只要扫描到结果就会调用
    
    NSString * string = object.stringValue;
    NSLog(@"扫描二维码的结果String:%@",string);
    
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
//#import "ScanImageViewController.h"
//#import <AVFoundation/AVFoundation.h>
//
//#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
//#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//@interface ScanImageViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//
//@property (strong,nonatomic)AVCaptureDevice * device;
//@property (strong,nonatomic)AVCaptureDeviceInput * input;
//@property (strong,nonatomic)AVCaptureMetadataOutput * output;
//@property (strong,nonatomic)AVCaptureSession * session;
//
//@property (strong, nonatomic) UIView *outputView;//xib中扫描的View
//
//@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
//@property (strong, nonatomic) NSTimer * timer;//为了做扫描动画的定时器
//@property (strong, nonatomic) UIImageView * lineImage;//扫描动画的横线
//@end
//
//@implementation ScanImageViewController
//
//-(UIImageView *)lineImage{
//    if (!_lineImage) {
//        CGFloat outputW = self.outputView.frame.size.width;
//        _lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,outputW, 2)];
//        _lineImage.image = [UIImage imageNamed:@"京东京豆"];
//    }
//    return _lineImage;
//}
//
////-(UIView *)outputView{
////    if (!_outputView) {
////        _outputView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
////    }
////    return _outputView;
////}
//
//-(void)viewDidLoad{
//    [super viewDidLoad];
//
//    self.outputView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
////    _outputView.backgroundColor = [UIColor yellowColor];
//
//    _outputView.layer.borderColor = [UIColor redColor].CGColor;
//    _outputView.layer.borderWidth = 2;
//    [self.view addSubview:_outputView];
//
//    // Device
//    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//
//    // Input
//    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
//
//    // Output
//    _output = [[AVCaptureMetadataOutput alloc]init];
//    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//
//    // Session
//    _session = [[AVCaptureSession alloc]init];
//    [_session setSessionPreset:AVCaptureSessionPresetHigh];
//    //连接输入和输出
//    if ([_session canAddInput:self.input])
//    {
//        [_session addInput:self.input];
//    }
//
//    if ([_session canAddOutput:self.output])
//    {
//        [_session addOutput:self.output];
//    }
//    //设置条码类型
//    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//
//    //设置条码位置
//    CGFloat X = (SCREEN_WIDTH/2-100)/SCREEN_HEIGHT;
//    CGFloat Y = (SCREEN_HEIGHT/2-100)/SCREEN_HEIGHT;
//    CGFloat W = 200/SCREEN_WIDTH;
//    CGFloat H = 200/SCREEN_HEIGHT;
//
//
//    //设置扫描范围（注意，X与Y交互，W与H交换）
//    [_output setRectOfInterest:CGRectMake(Y, X, H, W)];
//    //添加扫描画面
//    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
//    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
//    _preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);//self.view.layer.bounds;
//    [self.view.layer insertSublayer:_preview atIndex:0];
//    //开始扫描
//    [_session startRunning];
//
//    //添加扫描动画定时器
//    [self.outputView addSubview:self.lineImage];
//    // Do any additional setup after loading the view from its nib.
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5f
//                                              target:self
//                                            selector:@selector(lineAction)
//                                            userInfo:nil
//                                             repeats:YES];
//}
//
//-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//
//
//    NSString *stringValue;
//    if ([metadataObjects count] >0){
//        //停止扫描
//        //[_session stopRunning];
//        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
//
//
//        stringValue = metadataObject.stringValue;//stringValue是扫描拿到的内容，更具内容进行后续工作。
//
//    }
//}
//
//- (void)lineAction{
//    CGFloat outputW = self.outputView.frame.size.width;
//    CGFloat outputH = self.outputView.frame.size.height;
//    [UIView animateWithDuration:2.4f animations:^{
//        CGRect frame = CGRectMake(0, outputH, outputW, 2);
//        self.lineImage.frame = frame;
//    } completion:^(BOOL finished) {
//        CGRect frame = CGRectMake(0, 0, outputW, 2);
//        self.lineImage.frame = frame;
//    }];
//}
//@end

