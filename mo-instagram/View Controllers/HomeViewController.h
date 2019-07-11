//
//  HomeViewController.h
//  mo-instagram
//
//  Created by mudi on 7/8/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property(strong, nonatomic)NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)logout:(id)sender;
- (IBAction)addPicture:(id)sender;

@end

NS_ASSUME_NONNULL_END
