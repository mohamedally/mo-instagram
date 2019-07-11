//
//  DetailsViewController.m
//  mo-instagram
//
//  Created by mudi on 7/10/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.captionLabel.text = self.post.caption;
    self.detailsImageView.file = self.post.image;
    [self.detailsImageView loadInBackground];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.timeStampLabel.text = [self timeAgo:self.post.createdAt];
    self.usernameLabel.text =  [@"@" stringByAppendingString:self.post[@"author"][@"username"]];
    
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

@end
