//
//  AuthenticationViewController.h
//  mo-instagram
//
//  Created by mudi on 7/8/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthenticationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)registerUser:(id)sender;
- (IBAction)loginUser:(id)sender;

@end

NS_ASSUME_NONNULL_END
