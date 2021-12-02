//
//  FiltersViewController.m
//  Filters
//
//  Created by Xin on 11/11/21.
//

#import "FiltersViewController.h"
#import "FilterCollectionViewCell.h"
#import "GPUImage.h"
#import "CompareViewController.h"

@interface FiltersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FilterDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIImage *orignImage;
@property (strong, nonatomic) NSArray *filtersArray;
@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Filters";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupFilters];
    [self setupView];
}

- (void)setupView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 124);
    layout.footerReferenceSize = CGSizeMake(10, self.view.frame.size.height);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width + 10, self.view.frame.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FilterCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class])];
    [collectionView setContentOffset:CGPointMake(self.view.frame.size.width * self.currentIndexPath.row + self.currentIndexPath.row * 10, 0)];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.orignImage = image;
    }
    return self;
}

- (void)setupFilters {
    NSArray *array = [NSArray arrayWithObjects: @(FiltersTypeContrastFilter),
                                                @(FiltersTypeSaturationFilter),
                                                @(FiltersTypeGammaFilter),
                                                @(FiltersTypeSepiaFilter),
                                                @(FiltersTypePixellateFilter),
                                                @(FiltersTypeGrayscaleFilter),
                                                @(FiltersTypeSharpenFilter),
                                                @(FiltersTypeGaussianBlurFilter),
                                                @(FiltersTypeSketchFilter),
                                                @(FiltersTypeToonFilter),
                      nil];
    self.filtersArray = array;
}

# pragma - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.filtersArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class]) forIndexPath:indexPath];
    FilterCollectionViewCell *filterCell = (FilterCollectionViewCell *)cell;
    filterCell.delegate = self;
    switch (indexPath.row) {
        case FiltersTypeContrastFilter:
        {
            GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init];
            filter.contrast = 2;
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Contrast Filter"];
            break;
        }
        case FiltersTypeSaturationFilter:
        {
            GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
            filter.saturation = 2;
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Saturation Filter"];
            break;
        }
        case FiltersTypeGammaFilter:
        {
            GPUImageGammaFilter *filter = [[GPUImageGammaFilter alloc] init];
            filter.gamma = 2;
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Gamma Filter"];
            break;
        }
        case FiltersTypeSepiaFilter:
        {
            GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Sepia Filter"];
            break;
        }
        case FiltersTypePixellateFilter:
        {
            GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Pixelate Filter"];
            break;
        }
        case FiltersTypeGrayscaleFilter:
        {
            GPUImageGrayscaleFilter *filter = [[GPUImageGrayscaleFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Gray Scale Filter"];
            break;
        }
        case FiltersTypeSharpenFilter:
        {
            GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Sharpen Filter"];
            break;
        }
        case FiltersTypeGaussianBlurFilter:
        {
            GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Gaussian Blur Filter"];
            break;
        }
        case FiltersTypeSketchFilter:
        {
            GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Sketch Filter"];
            break;
        }
        case FiltersTypeToonFilter:
        {
            GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
            [filterCell setupFilter:self.orignImage andFilter:filter andFilterName:@"Cartoon Filter"];
            break;
        }
        default:
            break;
    }
    return cell;
}
- (void)filterCellWithResultImage:(UIImage *)image {
    CompareViewController *vc = [[CompareViewController alloc] init];
    vc.orignImage = self.orignImage;
    vc.filteredImage = image;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)saveImageToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
