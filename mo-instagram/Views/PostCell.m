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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.image = [UIImage imageNamed:@"white"];
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}


@end
