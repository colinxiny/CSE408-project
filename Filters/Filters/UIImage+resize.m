//
//  UIImage+resize.m
//  Filters
//
//  Created by Xin on 11/16/21.
//

#import "UIImage+resize.h"
#import <CoreMedia/CoreMedia.h>

@implementation UIImage (Resize)

- (UIImage *)scaleImage:(CGFloat)scale {
    CGSize reSize = CGSizeMake((self.size.width / 2) * scale, (self.size.width / 2) *scale);
    return [self reSizeImage:reSize];
}

- (UIImage *)reSizeImage:(CGSize)reSize {
    UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.mainScreen.scale);
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return resizeImage;
}

- (CGImageRef)convertToCGImage {
    CGImageRef cgimg = self.CGImage;
    if (cgimg == nil) {
        CIImage *ciimage = self.CIImage;
        CIContext *cont = [[CIContext alloc]init];
        return [cont createCGImage:ciimage fromRect:ciimage.extent];
    }else {
        return cgimg;
    }
}

@end
