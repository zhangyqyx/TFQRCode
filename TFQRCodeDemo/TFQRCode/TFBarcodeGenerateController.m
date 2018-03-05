//
//  TFBarcodeGenerateController.m
//  TFQRCode
//
//  Created by 张永强 on 2018/2/26.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import "TFBarcodeGenerateController.h"
#import "TFBarcodeGenerateManager.h"

@interface TFBarcodeGenerateController ()
/** 二维码图片 */
@property (weak, nonatomic) IBOutlet UIImageView *barcodeImage;

@end

@implementation TFBarcodeGenerateController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.barcodeImage.image = [TFBarcodeGenerateManager TF_generateBarcodeWithStr:@"18410286154" ];
//    self.barcodeImage.image = [TFBarcodeGenerateManager TF_generateBarcodeWithStr:@"18410286154" codeImageSize:CGSizeMake(240, 50)];
    self.barcodeImage.image = [TFBarcodeGenerateManager TF_generateBarcodeWithStr:@"www.baidu.com" codeImageSize:CGSizeMake(240, 50) red:0.5f green:0.3f blue:0.8f];
}



@end
