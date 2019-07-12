//
//  ProfileViewController.h
//  mo-instagram
//
//  Created by mudi on 7/11/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@protocol ProfileViewControllerDelegate

-(void) didChangeProfilePic;

@end

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic)NSArray *posts;
@property (weak, nonatomic) IBOutlet UIView *profileCardView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcountLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property(strong, nonatomic) UIImage *originalImage;
@property(strong, nonatomic) UIImage *editedImage;
@property(strong, nonatomic) PFUser *user;
@property (nonatomic, weak) id<ProfileViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
