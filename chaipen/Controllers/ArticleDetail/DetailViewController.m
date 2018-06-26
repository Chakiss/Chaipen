//
//  DetailViewController.m
//  chaipen
//
//  Created by Chakrit on 26/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"

@import Firebase;
@import FirebaseStorage;


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];    
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        return  210.0f;
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"DetailTableViewCell";
    if (indexPath.row == 1) {
        identifier = @"DetailTableViewCell1";
    } else if (indexPath.row == 2) {
        identifier = @"DetailTableViewCell2";
    }
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row == 0) {
        FIRStorageReference *storageRef = [[FIRStorage storage] reference];
        FIRStorageReference *imagesRef = [storageRef child:@"images/posts"];
        NSString *fileName = self.data[COVER];
        imagesRef = [imagesRef child:[[fileName componentsSeparatedByString:@"/"] lastObject]];
        
        [imagesRef dataWithMaxSize:5000000 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
            } else {
                UIImage *image = [UIImage imageWithData: data];
                cell.imageView.image = image;
            }
        }];
    } else {
        cell.titleLabel.text = self.data[TITLE];
        cell.descriptionLabel.text = self.data[CONTENT];
        
    }
   
    
//    cell.tagListView.canSelectTags = NO;
//    cell.tagListView.tagSelectedTextColor = [UIColor blackColor];
//    cell.tagListView.tagCornerRadius = 5.0f;
//    cell.tagListView.tagTextFont = [UIFont fontWithName:@"KrungthaiFast-LightItalic" size:14.0];
//    [cell.tagListView.tags addObjectsFromArray:[self getTypeString:data[USER_TYPES]]];
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
