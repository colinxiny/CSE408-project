//
//  FilterListItemCollectionViewCell.h
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterListItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (void)setupImage:(UIImage *)image WithFilter:(GPUImageFilter *)filter;

@end

NS_ASSUME_NONNULL_END
