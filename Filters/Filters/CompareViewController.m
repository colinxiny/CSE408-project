//
//  CompareViewController.m
//  Filters
//
//  Created by Xin on 11/13/21.
//

#import "CompareViewController.h"

@interface CompareViewController ()

@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupUI];
    
}

- (void)setupUI {
    UIImageView *orignImgView = [[UIImageView alloc] initWithImage:self.orignImage];
    orignImgView.contentMode = UIViewContentModeScaleAspectFit;
    orignImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height / 2) - 2.5);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height / 2) + 2, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor systemGrayColor];
    
    UIImageView *filteredImgView = [[UIImageView alloc] initWithImage:self.filteredImage];
    filteredImgView.contentMode = UIViewContentModeScaleAspectFit;
    filteredImgView.frame = CGRectMake(0, (self.view.frame.size.height / 2) + 5, self.view.frame.size.width, (self.view.frame.size.height / 2) - 2.5);
    
    [self.view addSubview:orignImgView];
    [self.view addSubview:line];
    [self.view addSubview:filteredImgView];
}


@end
