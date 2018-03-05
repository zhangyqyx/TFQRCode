//
//  TFQRCodeGenerateController.m
//  TFQRCode
//
//  Created by 张永强 on 2018/2/26.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import "TFQRCodeGenerateController.h"
#import "TFQRCodeGenerateManager.h"

@interface TFQRCodeGenerateController ()
/**  图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation TFQRCodeGenerateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二维码生成";
//        self.imageView.image = [TFQRCodeGenerateManager TF_generateQRCodeWithStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️" sizeWidth:200];
    //    self.imageView.image = [TFQRCodeGenerateManager TF_generateQRCodeWithLogoStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
    //                                                                   logoImageName:@"logo-1"
    //                                                            logoScaleToSuperView:10];
    //   self.imageView.image = [TFQRCodeGenerateManager TF_generateWithColorQRCodeStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
    //                                                                 backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
    //                                                                       mainColor:[CIColor colorWithRed:1.0 green:0.2 blue:0.4]];
    
        self.imageView.image = [TFQRCodeGenerateManager TF_generateQRCodeWithLogoStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
                                                                       logoImageName:@"logo-1"
                                                                logoScaleToSuperView:10
                                                                     backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
                                                                           mainColor:[CIColor colorWithRed:1.0 green:1.0 blue:0.4]];
    
    
    
}



@end
