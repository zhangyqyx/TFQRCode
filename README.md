## 二维码的封装使用
所有二维码逻辑都封装在``TFQRCodeManager``文件夹中 , 使用的时候导入``TFCode.h``文件即可。

``resource``是一些图片资源；``TFQRCodeGenerateManager``用来生成二维码图片；``TFBarcodeGenerateManager``用来生成条形码图片；``TFCodeScanManager``用来扫描二维码和条形码；``TFCodeHelperTool``是用于打开、关闭手电筒；``TFCodeScanningView``二维码扫描动画和扫描框；``TFCodeAlbumManager``用来识别相册中的二维码图片;


### 1、二维码的生成
使用方法
```
//生成默认二维码图片
[TFQRCodeGenerateManager TF_generateQRCodeWithStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️" sizeWidth:200];
//生成自定义的二维码图片
[TFQRCodeGenerateManager TF_generateQRCodeWithLogoStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
logoImageName:@"logo-1"
logoScaleToSuperView:10
backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
mainColor:[CIColor colorWithRed:1.0 green:1.0 blue:0.4]];
```
### 2、条形码的生成
使用方法
```
//生成一张基本的条形码图片
[TFBarcodeGenerateManager TF_generateBarcodeWithStr:@"18410286154" ];
//生成一张自定义的二维码图片
[TFBarcodeGenerateManager TF_generateBarcodeWithStr:@"www.baidu.com" codeImageSize:CGSizeMake(240, 50) red:0.5f green:0.3f blue:0.8f];

```
### 3、扫描二维码、条形码
使用方法
```
//1、设置扫描视图
_scanningView = [[TFCodeScanningView alloc]initWithFrame:self.view.frame];
_scanningView.center = self.view.center;
_scanningView.scanningImageName = @"scan_net.png";
_scanningView.scnningType = TFScanningAnimationTypeGrid;
_scanningView.scanSize = CGSizeMake(260, 260);
_scanningView.cornerColor = [UIColor orangeColor];
//2、设置二维码扫描对象
self.manager = [TFCodeScanManager TFSharedManager];
[_manager TF_scanQRImage:CGRectMake(0, 0, 260, 260) viewSize:[UIScreen mainScreen].bounds currentController:self];
_manager.delegate = self;
//3、添加定时器动画
[self.scanningView addTimer];
//4、扫描到二维码信息会在代理方法中回调
- (void)TF_codeScanManager:(TFCodeScanManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects;

```
### 4、导入相册中的二维码
使用方法
```
//1、设置访问相册对象
TFCodeAlbumManager *manager = [[TFCodeAlbumManager alloc] init];
[manager TF_readCodeFromAlbumWithCurrentController:self];
manager.delegate = self;
//2、识别二维码、条形码会在代码方法中回调
- (void)TF_codeAlbumManagerDidCancelWithImagePickerController:(TFCodeAlbumManager *)albumManager;//图片选择控制器取消按钮的点击回调方法
- (void)TF_codeAlbumManager:(TFCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;// 图片选择控制器选取图片完成之后的回调方法

```



