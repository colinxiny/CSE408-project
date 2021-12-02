//
//  CameraListViewController.m
//  Filters
//
//  Created by Xin on 11/15/21.
//

#import "CameraListViewController.h"
#import "FiltersEnum.h"
#import "CameraPreviewCollectionViewCell.h"
#import "UIImage+resize.h"

@interface CameraListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, AVCaptureVideoDataOutputSampleBufferDelegate>
@property(strong, nonatomic) UICollectionView *collectionView;
@property(strong, nonatomic) NSArray *filtersArray;
@property(strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property(strong, nonatomic) UIImage *handleImage;
@property(nonatomic, strong) NSTimer * timer;
@property(assign, nonatomic) BOOL flag;


@end

@implementation CameraListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupFilters];
    [self cameraConfig];
    self.flag = NO;
}

- (void)cameraConfig {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    if (input != nil) {
        AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc]init];
        [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32RGBA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
        dispatch_queue_t queue = dispatch_queue_create("video_filter", DISPATCH_QUEUE_CONCURRENT);
        [videoOutput setSampleBufferDelegate:self queue:queue];

        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        [session addInput:input];
        [session addOutput:videoOutput];
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = CGRectMake(0, 0, self.view.frame.size.width / 2, self.view.frame.size.width / 2);
        [session startRunning];
    }
}


- (void)setupFilters {
    NSArray *array = [NSArray arrayWithObjects: @(FiltersTypeContrastFilter),
                                                @(FiltersTypeSaturationFilter),
                                                @(FiltersTypeGammaFilter),
                                                @(FiltersTypeSepiaFilter),
                                                @(FiltersTypePixellateFilter),
                                                @(FiltersTypeGrayscaleFilter),
                                                @(FiltersTypeSharpenFilter),
                                                @(FiltersTypeGaussianBlurFilter),
                                                @(FiltersTypeSketchFilter),
                                                @(FiltersTypeToonFilter),
                      nil];
    self.filtersArray = array;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 2, self.view.frame.size.width / 2);
    layout.footerReferenceSize = CGSizeMake(10, self.view.frame.size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([CameraPreviewCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CameraPreviewCollectionViewCell class])];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.filtersArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CameraPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CameraPreviewCollectionViewCell class]) forIndexPath:indexPath];
    switch (indexPath.row) {
        case FiltersTypeContrastFilter:
        {
            GPUImageContrastFilter* filter = [[GPUImageContrastFilter alloc] init];
            filter.contrast = 2;
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }
            break;
        }
        case FiltersTypeSaturationFilter:
        {
            GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
            filter.saturation = 2;
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeGammaFilter:
        {
            GPUImageGammaFilter* filter = [[GPUImageGammaFilter alloc] init];
            filter.gamma = 2;
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeSepiaFilter:
        {
            GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypePixellateFilter:
        {
            GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeGrayscaleFilter:
        {
            GPUImageGrayscaleFilter* filter = [[GPUImageGrayscaleFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }
            break;
        }
        case FiltersTypeSharpenFilter:
        {
            GPUImageSharpenFilter* filter = [[GPUImageSharpenFilter alloc] init];
            filter.sharpness = 2;
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeGaussianBlurFilter:
        {
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeSketchFilter:
        {
            GPUImageSketchFilter* filter = [[GPUImageSketchFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        case FiltersTypeToonFilter:
        {
            GPUImageToonFilter* filter = [[GPUImageToonFilter alloc] init];
            if (self.handleImage != nil) {
                [cell setupImage:self.handleImage WithFilter:filter];
            }            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.callBack(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    UIImage *image = [self handleSampleBuffer:sampleBuffer];
    dispatch_async(dispatch_get_main_queue(), ^{
            if(!self.flag){
                if (image != nil) {
                    self.handleImage = image;
                    [self.collectionView reloadData];
//                    if (!self.isPreview) {
//                        self.flag = YES;
//                    }
                }
            }
    });
}

- (UIImage *)handleSampleBuffer:(CMSampleBufferRef )sampleBuffer {
    if (sampleBuffer != nil) {
        CVImageBufferRef bufferImageRef = CMSampleBufferGetImageBuffer(sampleBuffer);
        CIImage *ciImage =  [[CIImage alloc]initWithCVPixelBuffer:bufferImageRef];
        UIImage *image = [[[UIImage alloc] initWithCIImage:ciImage scale:1 orientation:UIImageOrientationRight] scaleImage:1];
        return image;
    }
    return nil;
}

@end
