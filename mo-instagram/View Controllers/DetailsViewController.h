//
//  DetailsViewController.h
//  mo-instagram
//
//  Created by mudi on 7/10/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet PFImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post* post;

@end

NS_ASSUME_NONNULL_END