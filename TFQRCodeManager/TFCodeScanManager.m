//
//  TFCodeScanManager.m
//  TFQRCode
//
//  Created by 张永强 on 2018/2/26.
//  Copyright © 2018年 张永强. All rights reserved.
//

#import "TFCodeScanManager.h"
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>

@interface TFCodeScanManager () <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
/** 会话对象 */
@property (nonatomic , strong)AVCaptureSession *session;
/** 摄像头调用对象 */
@property (nonatomic , strong)AVCaptureVideoDataOutput *videoDataOutput;
/** 图像预览对象 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation TFCodeScanManager
static TFCodeScanManager *_instance;

+ (instancetype)TFSharedManager  {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void )TF_scanQRImage:(CGRect)windowSize
               viewSize:(CGRect)viewSize
      currentController:(UIViewController *)currentController {
    //1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2、创建设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device  error:nil];
    //3(1)、创建输入流
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
     //设置代理 在主线程里刷新
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    //3(2)、创建数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop = [self getScanCrop:windowSize readerViewBounds:viewSize];
    metadataOutput.rectOfInterest = scanCrop;
    //创建会话对象
    _session = [[AVCaptureSession alloc] init];
    //会话对象采集率
    [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    //5、添加设备输出流到会话对象
    [_session addOutput:metadataOutput];
    // 5(1)添加设备输出流到会话对象；与 3(1) 构成识别光线强弱
    [_session addOutput:_videoDataOutput];
    //6、添加输入流到会话对象
    [_session addInput:deviceInput];
    //7、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
   _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.frame = viewSize;
     [currentController.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    // 9、启动会话
    [_session startRunning];
}

#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(TF_codeScanManager:didOutputMetadataObjects:)]) {
        [self.delegate TF_codeScanManager:self didOutputMetadataObjects:metadataObjects];
    }
}

#pragma mark - - - AVCaptureVideoDataOutputSampleBufferDelegate的方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 这个方法会时时调用，但内存很稳定
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
//    NSLog(@"%f",brightnessValue);
    if (self.delegate && [self.delegate respondsToSelector:@selector(TF_codeScanManager:brightnessValue:)]) {
        [self.delegate TF_codeScanManager:self brightnessValue:brightnessValue];
    }
}
- (void)TFStartRunning {
    [_session startRunning];
}

- (void)TFStopRunning {
    [_session stopRunning];
}

- (void)TFVideoPreviewLayerRemoveFromSuperlayer {
    [_videoPreviewLayer removeFromSuperlayer];
}
- (void)TFResetSampleBufferDelegate {
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
}
- (void)TFCancelSampleBufferDelegate {
     [_videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
}
- (void)TFPalySoundName:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    
}


@end
