//
//  HomeViewController.m
//  mo-instagram
//
//  Created by mudi on 7/8/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PostCell.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "InfiniteScrollActivityView.h"
#import "DateTools.h"
#import "ProfileViewController.h"

@interface HomeViewController () <ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, PostCellDelegate, ProfileViewControllerDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@end

@implementation HomeViewController
InfiniteScrollActivityView* loadingMoreView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    [self fetchData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void) fetchData{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"composeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }else if ([segue.identifier isEqualToString:@"detailsSegue"]) {
        DetailsViewController* detailsController = [segue destinationViewController];
        
        UITableViewCell *tappedCell = sender;
        [tappedCell setSelected:NO];
        NSIndexPath *indexPath =  [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        detailsController.post = post;
        
    } else if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.user = sender;
        profileController.delegate = self;
    }
    
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)addPicture:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.delegate = self;
    Post *post = self.posts[indexPath.row];
    cell.captionLabel.text = post[@"caption"];
    cell.usernameLabel.text =[@"@" stringByAppendingString:post[@"author"][@"username"]];
    cell.timestampLabel.text = [self timeAgo:post.createdAt];
    cell.profilePicView.file = post.author[@"profilePicture"];
    [cell.profilePicView loadInBackground];
    cell.likesLabel.text = [NSString stringWithFormat:@"%@", post.likeCount];
    [cell setPost:post];
    

    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Post* post = self.posts[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


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

- (void)didPost {
    [self fetchData];
    [self.tableView reloadData];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            // ... Code to load more results ...
            self.isMoreDataLoading = true;
            
            // Update position of loadingMoreView, and start loading indicator
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            loadingMoreView.frame = frame;
            [loadingMoreView startAnimating];
            
            [self fetchMoreData:self.posts.count];
           
        }
    }
}

-(void) fetchMoreData: (NSInteger)skip {
//    Post *lastPost = self.posts[skip - 1];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createdAt < %@", lastPost.createdAt];
//    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post" predicate:predicate];
    
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.skip = skip;
    postQuery.limit = 20;
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            
            // Update flag
            self.isMoreDataLoading = false;
            [loadingMoreView stopAnimating];
            [self.posts  addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)postCell:(PostCell *) postCell didTap: (PFUser *)user
{
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

-(void) didChangeProfilePic {
    [self fetchData];
    [self.tableView reloadData];
}


@end
