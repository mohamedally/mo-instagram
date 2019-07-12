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

@protocol DetailsViewControllerDelegate
- (void) didTapLike;

@end

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet PFImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post* post;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
