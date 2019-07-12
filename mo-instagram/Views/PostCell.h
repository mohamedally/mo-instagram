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

@protocol PostCellDelegate;
@interface PostCell : UITableViewCell

@property (nonatomic, weak) id<PostCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;


- (void)setPost:(Post *)post;

@end

@protocol PostCellDelegate
- (void)postCell:(PostCell *) postCell didTap: (PFUser *)user;
@end

NS_ASSUME_NONNULL_END
