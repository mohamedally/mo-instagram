//
//  ProfilePostCell.m
//  mo-instagram
//
//  Created by mudi on 7/11/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "ProfilePostCell.h"

@implementation ProfilePostCell

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
    self.posterView.file = post[@"image"];
    [self.posterView loadInBackground];
}

@end
