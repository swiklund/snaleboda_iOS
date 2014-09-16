//
//  Report.m
//  snaleboda
//
//  Created by Wiklund on 2014-09-12.
//  Copyright (c) 2014 Wiklund. All rights reserved.
//

#import "Report.h"
#import "AFNetworking.h"

@implementation Report

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self cameraAlert];
    }
    
    self.reportItem = [[ReportItem alloc]init];
}

- (void)cameraAlert{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                          message:@"The device has no camera"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}


- (IBAction)takePhoto:(UIButton *)sender {
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self cameraAlert];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}

- (IBAction)sendReport:(UIButton *)sender {
    
    self.reportItem.Name = self.name.text;
    self.reportItem.Description = self.description.text;
    self.reportItem.Image = [self encodeToBase64String:self.imageView.image];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* params = @{
                             @"Name" : self.reportItem.Name,
                             @"Description" : self.reportItem.Description,
                             @"Image" : self.reportItem.Image,
                             };
    
    NSString* serviceURL = @"https://snaleboda.azure-mobile.net/tables/incidents";
    
    [manager POST:serviceURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

/*-(void)postReport:(NSString*)URL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //[manager.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"json"];
    
    NSDictionary* params = @{
                             @"ApplicationId" : appInfo.uuid,
                             @"Email" : visitor.email,
                             @"Name" : visitor.name,
                             };
    
    NSString* serviceURL = @"http://10.10.1.167/ScandinavianOutdoorGames.Visitor.WebServices/RegisterVisitor.svc/Register";
    
    [manager POST:serviceURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
*/

@end
