//
//  ProfileViewController.m
//  mo-instagram
//
//  Created by mudi on 7/11/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "ProfilePostCell.h"
#import "DetailsViewController.h"
#import "DateTools.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.profileCardView;
    
    PFUser *currentUser = [PFUser currentUser];
    self.userLabel.text = currentUser.username;
    [self fetchData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

-(void) fetchData{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = posts;
            self.postcountLabel.text = [NSString stringWithFormat:@"%lu",self.posts.count];
            [self.tableView reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfilePostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.captionLabel.text = post[@"caption"];
    cell.usernameLabel.text = [@"@" stringByAppendingString:post[@"author"][@"username"]];
    cell.timeLabel.text = [self timeAgo:post.createdAt];
    [cell setPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

-(NSString *) timeAgo: (NSDate *)postDate{
    
    NSString *timeAgo;
    NSDate *now = [NSDate date];
    long monthDiff = [now monthsFrom:postDate];
    long dayDiff = [now daysFrom:postDate];
    long hourDiff = [now hoursFrom:postDate];
    long minuteDiff = [now minutesFrom:postDate];
    long secondDiff = [now secondsFrom:postDate];
    
    if (monthDiff == 0){
        
        if (dayDiff != 0){
            timeAgo = [[NSString stringWithFormat:@"%lu", dayDiff] stringByAppendingString:@" days ago"];
        } else if (hourDiff != 0){
            timeAgo = [[NSString stringWithFormat:@"%lu", hourDiff] stringByAppendingString:@" hours ago"];
        } else if (minuteDiff != 0){
            timeAgo = [[NSString stringWithFormat:@"%lu", minuteDiff] stringByAppendingString:@" minutes ago"];
        } else {
            timeAgo = [[NSString stringWithFormat:@"%lu", secondDiff] stringByAppendingString:@" seconds ago"];
        }
        
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        timeAgo = [formatter stringFromDate:postDate];
    }
    
    return timeAgo;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view display

// Added the next 2 functions to make the separator strech across the entire screen.
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
