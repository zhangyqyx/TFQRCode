//
//  TFCodeAlbumManager.h
//  TFQRCode
//
//  Created by 张永强 on 2018/2/27.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFCodeAlbumManager;
@protocol TFCodeAlbumManagerDelegate <NSObject>

@required

/**
 图片选择控制器取消按钮的点击回调方法

 @param albumManager 识别图片对象
 */
- (void)TF_codeAlbumManagerDidCancelWithImagePickerController:(TFCodeAlbumManager *)albumManager;
/**
 图片选择控制器选取图片完成之后的回调方法

 @param albumManager 识别图片对象
 @param result 获取的二维码数据
 */
- (void)TF_codeAlbumManager:(TFCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;

@end

@interface TFCodeAlbumManager : NSObject

/** 快速创建单利方法 */
+ (instancetype)TFsharedManager;
/** 代理对象  */
@property (nonatomic, weak) id<TFCodeAlbumManagerDelegate> delegate;
/** 判断相册访问权限是否授权 */
@property (nonatomic, assign) BOOL isPHAuthorization;

/** 从相册中读取二维码方法，必须实现的方法 */
- (void)TF_readCodeFromAlbumWithCurrentController:(UIViewController *)currentController;





@end
