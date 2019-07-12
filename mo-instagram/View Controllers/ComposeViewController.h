//
//  ComposeViewController.h
//  mo-instagram
//
//  Created by mudi on 7/9/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
- (void)didPost;

@end

@interface ComposeViewController : UIViewController
@property(strong, nonatomic) UIImage *originalImage;
@property(strong, nonatomic) UIImage *editedImage;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)share:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;
- (IBAction)takePicture:(id)sender;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
