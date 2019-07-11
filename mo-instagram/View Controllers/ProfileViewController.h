//
//  ProfileViewController.h
//  mo-instagram
//
//  Created by mudi on 7/11/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic)NSArray *posts;
@property (weak, nonatomic) IBOutlet UIView *profileCardView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcountLabel;
@end

NS_ASSUME_NONNULL_END
