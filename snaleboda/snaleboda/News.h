//
//  News.h
//  snaleboda
//
//  Created by Wiklund on 2014-09-12.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News : UITableViewController

@property NSMutableArray *newsItems;

- (void)getNewsFromUrl:(NSString*)URL;


@end

