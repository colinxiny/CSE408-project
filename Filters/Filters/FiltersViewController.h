//
//  FiltersViewController.h
//  Filters
//
//  Created by Xin on 11/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FiltersViewController : UIViewController
@property (strong, nonatomic) NSIndexPath *currentIndexPath;

- (instancetype)initWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
