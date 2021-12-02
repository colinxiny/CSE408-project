//
//  FilterCameraViewController.h
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ImageCallBack)(UIImage *image);

@interface FilterCameraViewController : UIViewController
@property(copy, nonatomic)ImageCallBack callback;


@end

NS_ASSUME_NONNULL_END
