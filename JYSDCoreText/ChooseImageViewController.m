//
//  ChooseImageViewController.m
//  JYSDCoreText
//
//  Created by Mr  liao jia yang  on 2017/5/9.
//  Copyright © 2017年 MrReYun.demo. All rights reserved.
//

#import "ChooseImageViewController.h"

#import "TZImagePickerController.h"

@interface ChooseImageViewController ()<TZImagePickerControllerDelegate>


@property (strong, nonatomic) NSMutableArray *  selectedAssets;


@end

@implementation ChooseImageViewController


-(NSMutableArray *)selectedAssets{
    
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return  _selectedAssets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    

}

-(void)setNav {
    
    self.title = @"选择图片";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    if (_selectedAssets.count > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; //目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto) {
        
         weakSelf.selectedAssets = [NSMutableArray arrayWithArray:assets];
        
        
        [weakSelf createImageViewWithImaageArray:photos];
        
        
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


-(void)createImageViewWithImaageArray:(NSArray * )array{
    
    for (int i = 0; i < array.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 80 * i, 100 + 10, 60, 60)];
    
        [imageView setImage:array[i]];
        [self.view addSubview:imageView];
        
    }
    
    
    
    
}




@end
