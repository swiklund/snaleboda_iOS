//
//  News.m
//  snaleboda
//
//  Created by Wiklund on 2014-09-12.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import "News.h"
#import "NewsItem.h"
#import "NewsCell.h"
#import "AFNetworking.h"


static NSString * const NewsCellIdentifier = @"NewsCell";

@implementation News

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentMax = 200;  //Max num of chars in content-text
    self.newsItems = [[NSMutableArray alloc] init];
    
    [self getNewsFromService];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsItems count];
}

- (void)configureBasicCell:(NewsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NewsItem *item = self.newsItems[indexPath.row];
    [self setTitleForCell:cell item:item];
    [self setTextForCell:cell item:item];
}

- (void)setTitleForCell:(NewsCell *)cell item:(NewsItem *)item {
    NSString *title = item.title ?: NSLocalizedString(@"[No Title]", nil);
    [cell.titleLabel setText:title];
}

- (void)setTextForCell:(NewsCell *)cell item:(NewsItem *)item {
    NSString *newsText = item.content?: NSLocalizedString(@"[Text not available]", nil);
    
    // Some textscan be really long, only display the first 200 characters
    if (newsText.length > self.contentMax) {
        newsText = [NSString stringWithFormat:@"%@...", [newsText substringToIndex:self.contentMax]];
    }
    
    [cell.newsText setText:newsText];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (NewsCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int rowSize = 27;
    int titleSize = 70;
    int charsPerRow = 41;
    
    int retHeight = 0;
    int numOfChars = [[self.newsItems[indexPath.row]content] length];  //Total length of item text
    if( numOfChars > self.contentMax )numOfChars = self.contentMax;    //Content max initialized in viewdidload
    retHeight = numOfChars/charsPerRow;
    if( retHeight < 1 )retHeight = 1;
    
    return retHeight*rowSize+titleSize;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static NewsCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}


- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

-(void)getNewsFromService {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSString* serviceURL = @"https://snaleboda.azure-mobile.net/tables/news";
    
    [manager GET:serviceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON: %@", responseObject);

        for( id item in responseObject)
        {
            NewsItem *newsItem = [[NewsItem alloc] init];
            newsItem.title = [item objectForKey:@"title"];
            newsItem.content = [item objectForKey:@"content"];

            [self.newsItems addObject:newsItem];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end

