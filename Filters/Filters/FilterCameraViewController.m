//
//  FilterCameraViewController.m
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import "FilterCameraViewController.h"
#import "GPUImage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CameraListViewController.h"
#import "FiltersEnum.h"

@interface FilterCameraViewController ()
@property(strong, nonatomic) GPUImageStillCamera *mCamera;
@property(strong, nonatomic) GPUImageFilter *mFilter;
@property(strong, nonatomic) GPUImageView *mGPUImgView;
@property(strong, nonatomic) UIButton *cancelBtn;
@property(strong, nonatomic) UIButton *filterBtn;
@property(strong, nonatomic) UIButton *saveBtn;
@property(strong, nonatomic) UIButton *captureBtn;
@property(strong, nonatomic) UIButton *previewBtn;
@property(strong, nonatomic) UIImage *captureImage;

@end

@implementation FilterCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;

    _mFilter = [[GPUImageFilter alloc] init];
    _mGPUImgView = [[GPUImageView alloc]initWithFrame: self.view.bounds];
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mGPUImgView];
    [self.view addSubview:_mGPUImgView];
    [_mCamera startCameraCapture];
    
    // capture button
    UIButton *captureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captureBtn.frame = CGRectMake((self.view.frame.size.width / 2) - 40, self.view.frame.size.height - 50 - 80, 80, 80);
    captureBtn.clipsToBounds = YES;
    captureBtn.backgroundColor = UIColor.labelColor;
    captureBtn.layer.cornerRadius = 40;
    [captureBtn addTarget:self action:@selector(captureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captureBtn];
    self.captureBtn = captureBtn;
    
    // capture button
    UIButton *preview = [UIButton buttonWithType:UIButtonTypeCustom];
    preview.frame = CGRectMake((self.view.frame.size.width / 2) - 20, self.view.frame.size.height - 50 - 80 - 60, 40, 40);
    preview.clipsToBounds = YES;
    preview.hidden = NO;
    [preview setTitle:@"preview" forState:UIControlStateNormal];
    preview.backgroundColor = UIColor.labelColor;
    preview.layer.cornerRadius = 20;
    [preview addTarget:self action:@selector(previewAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:preview];
    self.previewBtn = preview;
    
    //cancel button
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(20, self.view.frame.size.height - 25 - 80, 80, 30);
    [cancel setTitle:@"cancel" forState:UIControlStateNormal];
    cancel.hidden = YES;
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    self.cancelBtn = cancel;
    
    //filter button
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    filterButton.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 25 - 80, 80, 30);
    [filterButton setTitle:@"filters" forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(addFilters) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterButton];
    self.filterBtn = filterButton;
    
    //save button
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 25 - 80, 80, 30);
    saveButton.hidden = YES;
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    self.saveBtn = saveButton;
}

- (void)captureAction {
    [self.mCamera capturePhotoAsJPEGProcessedUpToFilter:self.mFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
        UIImage *image = [[UIImage alloc]initWithData: processedJPEG];
        self.captureImage = image;
        self.cancelBtn.hidden = NO;
        self.saveBtn.hidden = NO;
        self.filterBtn.hidden = YES;
        self.captureBtn.hidden = YES;
        self.previewBtn.hidden = YES;
        [self.mCamera stopCameraCapture];
    }];
}

- (void)previewAction {
    CameraListViewController *vc = [[CameraListViewController alloc] init];
    vc.isPreview = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveAction {
    UIImageWriteToSavedPhotosAlbum(self.captureImage, nil, nil, nil);
    self.callback(self.captureImage);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelAction {
    self.cancelBtn.hidden = YES;
    self.saveBtn.hidden = YES;
    self.filterBtn.hidden = NO;
    self.captureBtn.hidden = NO;
    self.previewBtn.hidden = NO;

    [self.mCamera startCameraCapture];
}

- (void)addFilters {
    CameraListViewController *vc = [[CameraListViewController alloc] init];
    vc.isPreview = NO;
    __weak typeof(self) weakSelf = self;
    vc.callBack = ^(NSInteger indexRow) {
        __strong typeof(self) strongSelf = weakSelf;
        [self.mCamera removeAllTargets];
        switch (indexRow) {
            case FiltersTypeContrastFilter:
            {
                GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init];
                filter.contrast = 2;
                strongSelf.mFilter = filter;
                [strongSelf.mCamera addTarget:_mFilter];
                [strongSelf.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeSaturationFilter:
            {
                GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
                filter.saturation = 2;
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeGammaFilter:
            {
                GPUImageGammaFilter* filter = [[GPUImageGammaFilter alloc] init];
                filter.gamma = 2;
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeSepiaFilter:
            {
                GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypePixellateFilter:
            {
                GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeGrayscaleFilter:
            {
                GPUImageGrayscaleFilter* filter = [[GPUImageGrayscaleFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeSharpenFilter:
            {
                GPUImageSharpenFilter* filter = [[GPUImageSharpenFilter alloc] init];
                filter.sharpness = 2;
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeGaussianBlurFilter:
            {
                GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeSketchFilter:
            {
                GPUImageSketchFilter* filter = [[GPUImageSketchFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            case FiltersTypeToonFilter:
            {
                GPUImageToonFilter* filter = [[GPUImageToonFilter alloc] init];
                self.mFilter = filter;
                [self.mCamera addTarget:_mFilter];
                [self.mFilter addTarget:_mGPUImgView];
                break;
            }
            default:
                break;
        };
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
