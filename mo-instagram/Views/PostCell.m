//
//  PostCell.m
//  mo-instagram
//
//  Created by mudi on 7/9/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
//    [self.profilePicView addGestureRecognizer:profileTapGestureRecognizer];
//    [self.profilePicView setUserInteractionEnabled:YES];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSInteger imageWidth = 32;
    self.profilePicView.layer.cornerRadius = imageWidth/2;
    
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.image = [UIImage imageNamed:@"white"];
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    
    if([post didUserLike:[PFUser currentUser]]){
        [self.likeButton setImage:[UIImage imageNamed:@"icons8-heart-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"icons8-heart-50"] forState:UIControlStateNormal];
    }
}

- (IBAction)didLike:(id)sender {
    if(![self.post didUserLike:[PFUser currentUser]]){
        [self.post like];
        [self.likeButton setImage:[UIImage imageNamed:@"icons8-heart-red"] forState:UIControlStateNormal];
    } else {
        [self.post unlike];
        [self.likeButton setImage:[UIImage imageNamed:@"icons8-heart-50"] forState:UIControlStateNormal];
    }
    self.likesLabel.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
}
- (IBAction)didTapUserProfile:(id)sender {
    [self.delegate postCell:self didTap:self.post.author];
}


@end
