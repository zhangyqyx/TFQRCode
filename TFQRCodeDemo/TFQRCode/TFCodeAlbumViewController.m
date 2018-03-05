//
//  TFCodeAlbumViewController.m
//  TFQRCode
//
//  Created by 张永强 on 2018/2/27.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import "TFCodeAlbumViewController.h"
#import "TFCode.h"
#import "TFCodeDetailViewController.h"

@interface TFCodeAlbumViewController ()<TFCodeAlbumManagerDelegate>



@end

@implementation TFCodeAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"相册导入二维码";
    
    
}

- (IBAction)channelCode:(id)sender {
    
    TFCodeAlbumManager *manager = [[TFCodeAlbumManager alloc] init];
    [manager TF_readCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
}
#pragma mark - TFCodeAlbumManagerDelegate
- (void)TF_codeAlbumManagerDidCancelWithImagePickerController:(TFCodeAlbumManager *)albumManager {
    NSLog(@"取消了操作");
}

- (void)TF_codeAlbumManager:(TFCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    TFCodeDetailViewController * detailVc = [[TFCodeDetailViewController alloc] init];
    detailVc.titleStr = result;
    [self.navigationController pushViewController:detailVc animated:YES];
}




@end
