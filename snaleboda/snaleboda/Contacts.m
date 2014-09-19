//
//  Contacts.m
//  snaleboda
//
//  Created by Wiklund on 2014-09-12.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import "Contacs.h"
#import "ContactsCell.h"
#import "ContactItem.h"
#import "AFNetworking.h"

static NSString * const ContactsCellIdentifier = @"ContactsCell";

@implementation Contacs

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contactItems = [[NSMutableArray alloc] init];
    
    [self getNewsFromService];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactItems count];
}

- (void)configureBasicCell:(ContactsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ContactItem *item = self.contactItems[indexPath.row];
    [self setNameForCell:cell item:item];
    [self setPhoneForCell:cell item:item];
    [self setEmailForCell:cell item:item];

}

- (void)setNameForCell:(ContactsCell *)cell item:(ContactItem *)item {
    NSString *title = item.name ?: NSLocalizedString(@"[Name not available]", nil);
    [cell.Name setText:title];
}

- (void)setPhoneForCell:(ContactsCell *)cell item:(ContactItem *)item {
    NSString *phoneText = item.phone?: NSLocalizedString(@"[Phone not available]", nil);
    [cell.Phone setText:phoneText];
}

- (void)setEmailForCell:(ContactsCell *)cell item:(ContactItem *)item {
        NSString *emailText = item.email?: NSLocalizedString(@"[Email not available]", nil);
    [cell.Email
     setText:emailText];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (ContactsCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    ContactsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ContactsCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)getNewsFromService {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString* serviceURL = @"https://snaleboda.azure-mobile.net/tables/contacts";
    
    [manager GET:serviceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        
        for( id item in responseObject)
        {
            ContactItem *contactItem = [[ContactItem alloc] init];
            contactItem.name = [item objectForKey:@"name"];
            contactItem.phone = [item objectForKey:@"phone"];
            contactItem.email = [item objectForKey:@"email"];

            [self.contactItems addObject:contactItem];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}


@end
