//
//  TFCodeScanManager.h
//  TFQRCode
//
//  Created by 张永强 on 2018/2/26.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TFCodeScanManager;
@protocol TFCodeScanManagerDelegate <NSObject>

@required
/**
 扫描二维码后的回调

 @param manager 二维码对象
 @param metadataObjects 回调信息
 */
- (void)TF_codeScanManager:(TFCodeScanManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects;
@optional
/**
 光线的强弱回调

 @param manager 二维码对象
 @param brightnessValue 光线强弱值
 */
- (void)TF_codeScanManager:(TFCodeScanManager *)manager brightnessValue:(CGFloat)brightnessValue;

@end

@interface TFCodeScanManager : NSObject

/** 代理对象 */
@property (nonatomic , weak)id<TFCodeScanManagerDelegate> delegate;
/**
 创建单例
 @return 单例对象
 */
+ (instancetype)TFSharedManager;
/**
 扫描二维码
 @param windowSize 扫描尺寸
 @param viewSize 视图尺寸
  @param currentController 当前控制器
 */
- (void )TF_scanQRImage:(CGRect)windowSize
            viewSize:(CGRect)viewSize
      currentController:(UIViewController *)currentController;

/**
 开启会话对象扫描
 */
- (void)TFStartRunning;
/** 停止会话对象扫描 */
- (void)TFStopRunning;
/** 移除 videoPreviewLayer 对象 */
- (void)TFVideoPreviewLayerRemoveFromSuperlayer;
/** 播放音效文件 */
- (void)TFPalySoundName:(NSString *)name;
/** 重置根据光线强弱值打开手电筒的 delegate 方法 */
- (void)TFResetSampleBufferDelegate;
/** 取消根据光线强弱值打开手电筒的 delegate 方法 */
- (void)TFCancelSampleBufferDelegate;






@end
