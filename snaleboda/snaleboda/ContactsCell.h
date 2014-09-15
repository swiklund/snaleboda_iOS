//
//  ContactsCell.h
//  snaleboda
//
//  Created by Wiklund on 2014-09-15.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Phone;
@property (weak, nonatomic) IBOutlet UILabel *Email;

@end
