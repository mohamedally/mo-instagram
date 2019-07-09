//
//  ComposeViewController.h
//  mo-instagram
//
//  Created by mudi on 7/9/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property(strong, nonatomic) UIImage *originalImage;
@property(strong, nonatomic) UIImage *editedImage;
- (IBAction)takePicture:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)share:(id)sender;


@end

NS_ASSUME_NONNULL_END
