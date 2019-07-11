//
//  PostCell.h
//  mo-instagram
//
//  Created by mudi on 7/9/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

- (void)setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
