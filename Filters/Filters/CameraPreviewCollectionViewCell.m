//
//  CameraPreviewCollectionViewCell.m
//  Filters
//
//  Created by Xin on 11/15/21.
//

#import "CameraPreviewCollectionViewCell.h"

@implementation CameraPreviewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupImage:(UIImage *)image WithFilter:(GPUImageFilter *)filter {
    [filter forceProcessingAtSize:image.size];
    [filter useNextFrameForImageCapture];
    if (image != nil) {
        GPUImagePicture *imagePicture = [[GPUImagePicture alloc]initWithImage:image];
        [imagePicture addTarget:filter];
        [imagePicture processImage];
        [imagePicture removeAllTargets];
        UIImage *newImg = [filter imageFromCurrentFramebuffer];
        [self.mGPUImgView setImage:newImg];
    }
    
}
@end
