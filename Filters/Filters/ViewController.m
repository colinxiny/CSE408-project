//
//  ViewController.m
//  Filters
//
//  Created by Xin on 11/11/21.
//

#import "ViewController.h"
#import "FiltersViewController.h"
#import "FilterListViewController.h"
#import "FilterCameraViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *addFiltersBtn;
@property (nonatomic, strong) UIImage *originImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGuesture2Image];
    
}

- (void)addGuesture2Image {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePtotoAction)];
    [self.imageView addGestureRecognizer:tapGesture];
}

- (void)choosePtotoAction {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionLib = [UIAlertAction actionWithTitle:@"Library" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openLibrary];
    }];
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"Camera" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [actionSheet addAction:actionLib];
    [actionSheet addAction:actionCamera];
    [actionSheet addAction:cancelBtn];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)openLibrary {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion: nil];
    }else{
        NSLog(@"there are something wrong to open library");
    }
}
- (void)openCamera{
    FilterCameraViewController *vc = [[FilterCameraViewController alloc]init];
    vc.callback = ^(UIImage * _Nonnull image) {
        [self.imageView setImage:image];
        self.originImage = image;
        self.tipLabel.hidden = false;
        self.addFiltersBtn.hidden = false;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)addFilterAction:(UIButton *)sender {
    FilterListViewController *vc = [[FilterListViewController alloc] initWithImage:self.originImage];
//    FiltersViewController *vc = [[FiltersViewController alloc]initWithImage:self.originImage];
    [self.navigationController pushViewController:vc animated:YES];
}

# pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    [self.imageView setImage:image];
    self.originImage = image;
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.tipLabel.hidden = false;
        self.addFiltersBtn.hidden = false;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
