//
//  Post.h
//  mo-instagram
//
//  Created by mudi on 7/9/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, weak) NSNumber *userLiked;

@property (nonatomic, weak) NSArray *likedBy;


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
- (Boolean) didUserLike:(PFUser *)user;
- (void) like;
- (void) unlike;

@end

NS_ASSUME_NONNULL_END
