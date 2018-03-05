//
//  TFCodeDetailViewController.m
//  TFQRCode
//
//  Created by 张永强 on 2018/2/27.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import "TFCodeDetailViewController.h"

@interface TFCodeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation TFCodeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫描结果";
    self.detailLabel.text = self.titleStr;
    
}



@end
