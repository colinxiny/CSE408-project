//
//  FilterCollectionViewCell.m
//  Filters
//
//  Created by Xin on 11/12/21.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setupFilter:(UIImage *)image andFilter:(GPUImageFilter *)filter andFilterName:(NSString *)name {
    [filter forceProcessingAtSize:image.size];
    [filter useNextFrameForImageCapture];
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc]initWithImage:image];
    [imagePicture addTarget:filter];
    [imagePicture processImage];
    [imagePicture removeAllTargets];
    UIImage *newImg = [filter imageFromCurrentFramebuffer];
    [self.imageView setImage:newImg];
    self.resultImage = newImg;
    self.filterName.text = name;
}
- (IBAction)compareAction:(id)sender {
    [self.delegate filterCellWithResultImage:self.resultImage];
}
- (IBAction)saveAction:(UIButton *)sender {
    [self.delegate saveImageToAlbum:self.resultImage];
}

@end
