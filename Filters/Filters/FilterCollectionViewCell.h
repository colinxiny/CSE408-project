//
//  FilterCollectionViewCell.h
//  Filters
//
//  Created by Xin on 11/12/21.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "FiltersEnum.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FilterDelegate <NSObject>
- (void)filterCellWithResultImage:(UIImage *)image;
- (void)saveImageToAlbum:(UIImage *)image;

@end


@interface FilterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *resultImage;
@property (weak, nonatomic) IBOutlet UILabel *filterName;
@property (weak, nonatomic) id<FilterDelegate> delegate;
- (void)setupFilter:(UIImage *)image andFilter:(GPUImageFilter *)filter andFilterName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
