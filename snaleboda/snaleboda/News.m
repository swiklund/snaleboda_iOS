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

static NSString * const NewsCellIdentifier = @"NewsCell";

@implementation News

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.newsItems = [[NSMutableArray alloc] init];

    NewsItem *item1 = [[NewsItem alloc] init];
    item1.itemTitle = @"This is title";
    item1.itemText = @"This is text";
    [self.newsItems addObject:item1];
    
    NewsItem *item2 = [[NewsItem alloc] init];
    item2.itemTitle = @"Another is title";
    item2.itemText = @"Another is text";
    [self.newsItems addObject:item2];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.newsItems count];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.startWebView stopLoading];
    
}

- (void)configureBasicCell:(NewsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NewsItem *item = self.newsItems[indexPath.row];
    [self setTitleForCell:cell item:item];
    [self setSubtitleForCell:cell item:item];
}

- (void)setTitleForCell:(NewsCell *)cell item:(NewsItem *)item {
    NSString *title = item.itemTitle ?: NSLocalizedString(@"[No Title]", nil);
    [cell.titleLabel setText:title];
}

- (void)setSubtitleForCell:(NewsCell *)cell item:(NewsItem *)item {
    NSString *newsText = item.itemText?: NSLocalizedString(@"[Text not available]", nil);
    
    // Some subtitles can be really long, so only display the
    // first 200 characters
    if (newsText.length > 200) {
        newsText = [NSString stringWithFormat:@"%@...", [newsText substringToIndex:200]];
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


//Ta reda på height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( indexPath == 0)return 100;
    else return 500;
    return [self heightForBasicCellAtIndexPath:indexPath];
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



@end

