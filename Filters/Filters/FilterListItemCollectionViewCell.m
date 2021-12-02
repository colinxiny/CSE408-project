//
//  FilterListItemCollectionViewCell.m
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import "FilterListItemCollectionViewCell.h"

@implementation FilterListItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupImage:(UIImage *)image WithFilter:(GPUImageFilter *)filter {
    [filter forceProcessingAtSize:image.size];
    [filter useNextFrameForImageCapture];
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc]initWithImage:image];
    [imagePicture addTarget:filter];
    [imagePicture processImage];
    [imagePicture removeAllTargets];
    UIImage *newImg = [filter imageFromCurrentFramebuffer];
    [self.imageView setImage:newImg];
}

@end
