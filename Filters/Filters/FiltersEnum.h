//
//  FiltersEnum.h
//  Filters
//
//  Created by Xin on 11/15/21.
//
#import <UIKit/UIKit.h>

#ifndef FiltersEnum_h
#define FiltersEnum_h
typedef NS_ENUM(NSInteger, FiltersType) {
    FiltersTypeContrastFilter = 0,
    FiltersTypeSaturationFilter,
    FiltersTypeGammaFilter,
    FiltersTypeSepiaFilter,
    FiltersTypePixellateFilter,
    FiltersTypeGrayscaleFilter,
    FiltersTypeSharpenFilter,
    FiltersTypeGaussianBlurFilter,
    FiltersTypeSketchFilter,
    FiltersTypeToonFilter
};
#endif /* FiltersEnum_h */
