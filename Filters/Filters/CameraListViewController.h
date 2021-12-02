//
//  CameraListViewController.h
//  Filters
//
//  Created by Xin on 11/15/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FilterCallBack)(NSInteger indexRow);


@interface CameraListViewController : UIViewController
@property (copy, nonatomic) FilterCallBack callBack;

@property(assign, nonatomic) BOOL isPreview;

@end

NS_ASSUME_NONNULL_END
