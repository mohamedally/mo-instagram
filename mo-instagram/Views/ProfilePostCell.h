//
//  ProfilePostCell.h
//  mo-instagram
//
//  Created by mudi on 7/11/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface ProfilePostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet PFImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END