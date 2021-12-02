//
//  FilterListViewController.m
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import "FilterListViewController.h"
#import "FilterCollectionViewCell.h"
#import "FilterListItemCollectionViewCell.h"
#import "FiltersViewController.h"

@interface FilterListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIImage *orignImage;
@property (strong, nonatomic) NSArray *filtersArray;

@end

@implementation FilterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Filters";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupU];
    [self setupFilters];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.orignImage = image;
    }
    return self;
}

- (void)setupU {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 2, self.view.frame.size.width / 2);
    layout.footerReferenceSize = CGSizeMake(10, self.view.frame.size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([FilterListItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FilterListItemCollectionViewCell class])];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.filtersArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FilterListItemCollectionViewCell class]) forIndexPath:indexPath];
    FilterListItemCollectionViewCell *filterCell = (FilterListItemCollectionViewCell* )cell;
    switch (indexPath.row) {
        case FiltersTypeContrastFilter:
        {
            GPUImageContrastFilter* filter = [[GPUImageContrastFilter alloc] init];
            filter.contrast = 2;
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeSaturationFilter:
        {
            GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
            filter.saturation = 2;
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeGammaFilter:
        {
            GPUImageGammaFilter* filter = [[GPUImageGammaFilter alloc] init];
            filter.gamma = 2;
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeSepiaFilter:
        {
            GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypePixellateFilter:
        {
            GPUImagePixellateFilter *filter = [[GPUImagePixellateFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeGrayscaleFilter:
        {
            GPUImageGrayscaleFilter* filter = [[GPUImageGrayscaleFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeSharpenFilter:
        {
            GPUImageSharpenFilter* filter = [[GPUImageSharpenFilter alloc] init];
            filter.sharpness = 2;
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeGaussianBlurFilter:
        {
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeSketchFilter:
        {
            GPUImageSketchFilter* filter = [[GPUImageSketchFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        case FiltersTypeToonFilter:
        {
            GPUImageToonFilter* filter = [[GPUImageToonFilter alloc] init];
            [filterCell setupImage:self.orignImage WithFilter:filter];
            break;
        }
        default:
            break;
    }
    return filterCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FiltersViewController *vc = [[FiltersViewController alloc] initWithImage:self.orignImage];
    vc.currentIndexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
