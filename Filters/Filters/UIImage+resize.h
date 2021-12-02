//
//  UIImage+resize.h
//  Filters
//
//  Created by Xin on 11/16/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Resize)

- (CGImageRef)convertToCGImage;
- (UIImage *)reSizeImage:(CGSize)reSize;
- (UIImage *)scaleImage:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END
