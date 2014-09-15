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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.newsItems = [[NSMutableArray alloc] init];
    
    [self getNewsFromUrl:@"dfljh"];

   /* NewsItem *item1 = [[NewsItem alloc] init];
    item1.itemTitle = @"This is title";
    item1.itemText = @"Another is text ljsf göabg ökabgöj aöskhb asd ökbjasd öfkb aöbf j dsd adsfds d df adf sdf d adfdsf dfa adf dff ssse sfdg sfdg sfdg sfg sfg sfg sfg sfg sfg sfg sfg fg sdfg sfg sfg sfg sfg sfg sfg sfg sfg sdfg sdfg sfg sfg sfg sfg sfg sfg sfg sfg sg sfg sgf sfg sdg sg sfg sfg sfg sfg sfg sfg sg sfg ";
    [self.newsItems addObject:item1];
    
    NewsItem *item2 = [[NewsItem alloc] init];
    item2.itemTitle = @"Another is title";
    item2.itemText = @"Another is text ljsf göabg ökabgöj aöskhb asd ökbjasd öfkb aöbf j dsd adsfds d df adf sdf d adfdsf dfa adf dff sdfg sdfg sdfg sdfg sdfg sdfg sg ey erty erty erty ert yert y erty ety erty erty erty erty er yet ye yer yt ety ery ery t   ttyetyety  ety ety ey etyetyer yertye yety ert y etrye tye tyeyt ertyety ety y e yetryer tyery e y e tyety ey et y ety eryt etr y e ty e tryertyerty er ty e ty";
    [self.newsItems addObject:item2];
*/
    
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
    NSString *title = item.title ?: NSLocalizedString(@"[No Title]", nil);
    [cell.titleLabel setText:title];
}

- (void)setSubtitleForCell:(NewsCell *)cell item:(NewsItem *)item {
    NSString *newsText = item.content?: NSLocalizedString(@"[Text not available]", nil);
    
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
    int rowSize = 20;
    int titleSize = 17;
    int charsPerRow = 41;
    
    int retHeight = 0;
    int numOfChars = [[self.newsItems[indexPath.row]content] length];  //Total length of item text
    retHeight = numOfChars/charsPerRow;
    retHeight = retHeight*rowSize+titleSize;
    return retHeight;
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

-(void)getNewsFromUrl:(NSString*)URL
{
   /* AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //[manager.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"json"];
    
    //NSDictionary* params = [self createPointOfInterest:URL];
    //NSString* serviceURL = @"http://sog.devburk.com/RegisterVisitor.svc/Register";
    
    NSString* serviceURL = @"https://snaleboda.azure-mobile.net/tables/news";
    
    [manager GET:serviceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);

        for( id key in responseObject)
        {
            NewsItem *tempItem = [[NewsItem alloc] init];
            tempItem = [responseObject objectForKey:key];
            [self.newsItems addObject:tempItem];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];*/
}

@end

