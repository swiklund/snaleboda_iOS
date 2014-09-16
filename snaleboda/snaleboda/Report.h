//
//  Report.h
//  snaleboda
//
//  Created by Wiklund on 2014-09-12.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Report : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)sendReport:(UIButton *)sender;

@end
