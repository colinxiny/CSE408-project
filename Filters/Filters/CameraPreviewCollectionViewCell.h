//
//  CameraPreviewCollectionViewCell.h
//  Filters
//
//  Created by Xin on 11/15/21.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import <AssetsLibrary/AssetsLibrary.h>


NS_ASSUME_NONNULL_BEGIN

@interface CameraPreviewCollectionViewCell : UICollectionViewCell <AVCaptureVideoDataOutputSampleBufferDelegate>
@property(strong, nonatomic) GPUImageStillCamera *mCamera;
@property(strong, nonatomic) GPUImageFilter *mFilter;
@property (weak, nonatomic) IBOutlet UIImageView *mGPUImgView;


- (void)setupImage:(UIImage *)image WithFilter:(GPUImageFilter *)filter;

@end

NS_ASSUME_NONNULL_END
