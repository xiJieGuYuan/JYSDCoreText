//
//  JYFaBiaoPingLunViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 16/9/3.
//  Copyright © 2016年 MrReYun.demo. All rights reserved.
//

#import "JYFaBiaoPingLunViewController.h"
#import "PYPhotosView.h"
#import "LayoutTextView.h"

@interface JYFaBiaoPingLunViewController ()<PYPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) PYPhotosView *publishPhotosView;/** 即将发布的图片存储的photosView */
@property(nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic,strong) NSMutableArray * imagesArray;//图片数组

@property (nonatomic,strong) LayoutTextView *layoutTextView ;

@end

@implementation JYFaBiaoPingLunViewController

-(NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self createPublishPhotosView];
}

#pragma mark - 1.设置导航栏相关内容
-(void)setNav{
    
    self.title = @"发表评论";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //第一种方法
    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [addButton setTitle:@"发送" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor yellowColor];
    [addButton addTarget:self action:@selector(sendContent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * myButton = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = myButton ;
    
    
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES ;
}

-(void)sendContent{
    
    
    NSLog(@"点击了发送按钮");
    
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    CGFloat layoutTextHeight = 44;

//    [self.layoutTextView removeFromSuperview];
    
    if (!self.layoutTextView) {
        self.layoutTextView = [[LayoutTextView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, layoutTextHeight)];
        [self.view addSubview:self.layoutTextView];
        [self.layoutTextView.textView becomeFirstResponder];
        self.layoutTextView.placeholder = @"@测试一下子";
        
        [self.layoutTextView setSendBlock:^(UITextView *textView) {
            NSLog(@"%@",textView.text);
        }];

    }else{
        
       // [self.layoutTextView setHidden: NO];
        [self.layoutTextView.textView becomeFirstResponder];

    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.layoutTextView removeFromSuperview];
   // [self.layoutTextView setHidden: YES];
    [self.layoutTextView.textView resignFirstResponder];
}


#pragma mark - 创建publishPhotosView
-(void)createPublishPhotosView{
    
    _publishPhotosView = [PYPhotosView photosView];
    _publishPhotosView.py_x = 10 * 8;
    _publishPhotosView.py_y = 10 * 8 + 64;
    
    _publishPhotosView.backgroundColor = [UIColor yellowColor];
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    
    
     //2.设置本地图片
    _publishPhotosView.images = originalImageUrls;
    //3.设置代理
    _publishPhotosView.delegate = self;
    
    //4.添加photosView
    [self.view addSubview:_publishPhotosView];
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    
    NSLog(@"点击了添加图片按钮 --- 添加前有%zd张图片", images.count);
 
    [self tapChooseImage];
    
    // 刷新
    NSLog(@"添加图片 --- 添加后有%zd张图片", photosView.images.count);
}


-(void)tapChooseImage{

    self.imagePickerController.presentedViewController.modalPresentationStyle  = UIModalPresentationOverCurrentContext;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    [alert addAction:actionCamera];
    
    
    UIAlertAction *actionLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    [alert addAction:actionLibrary];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

#pragma mark - UIImagePickerControllerDelegate  代理方法
//在选择完图片后调用  不管是从相机来还是相册来，都一样的调用这个方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    UIImage *image =  [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    UIImage *image =  [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    
    [self.imagesArray addObject:image];
    [self.publishPhotosView reloadDataWithImages:self.imagesArray];
}


-(void)dealloc{
    
    NSLog(@"发表评论控制器释放");
    
    NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@ ====self.layoutTextView:%@",self.navigationController.viewControllers,self.publishPhotosView,self.layoutTextView,self.imagePickerController);
    
    self.layoutTextView = nil;
    self.publishPhotosView = nil;
    self.imagePickerController = nil;
    
    
    NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@ ====self.layoutTextView:%@",self.navigationController.viewControllers,self.publishPhotosView,self.layoutTextView,self.imagePickerController);
    NSLog(@"self.navigationController:%@,数组%@  =====firstObject:%@ ====self.layoutTextView:%@",self.navigationController,self.navigationController.viewControllers,[self.navigationController.viewControllers firstObject],self.layoutTextView);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testDeallocReleaseNotifi" object:nil];
}
@end
