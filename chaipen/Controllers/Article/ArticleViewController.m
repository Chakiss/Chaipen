//
//  ArticleViewController.m
//  chaipen
//
//  Created by Chakrit on 14/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleTableViewCell.h"
#import "DetailViewController.h"

@import Firebase;
@import FirebaseStorage;

@interface ArticleViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIRefreshControl *refreshControl;
}

@property (nonatomic, strong) FIRFirestore *defaultFirestore;
@property (nonatomic, strong) NSMutableArray *documentArray;
@property (nonatomic, strong) NSMutableArray *userTypesArray;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.defaultFirestore = [FIRFirestore firestore];
    
    self.userTypesArray = [NSMutableArray array];
    self.documentArray = [NSMutableArray array];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    if (MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) == 812.0) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar"]
                                           forBarMetrics:UIBarMetricsDefault];
        
    }
    else
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar"]
                                           forBarMetrics:UIBarMetricsDefault];
    
}

- (void)refresh {

    [refreshControl endRefreshing];
    [SVProgressHUD show];
    FIRDocumentReference *docRef =
    [[self.defaultFirestore collectionWithPath:USER] documentWithPath:[FIRAuth auth].currentUser.uid];
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
        if (snapshot.exists) {
            
            //            for (id user_types in snapshot.data[USER_TYPES] ) {
            //                //NSLog(@"%@",[NSString stringWithFormat:@"%@.%@",USER_TYPES,user_types]);
            //                [self.userTypesArray addObject:user_types];
            //            }
            
            [[self.defaultFirestore collectionWithPath:POSTS] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                self.documentArray = (NSMutableArray *)snapshot.documents;
                [self.tableView reloadData];
                
                [SVProgressHUD dismiss];
            }];
            
            
        } else {
            NSLog(@"Document does not exist");
            [SVProgressHUD dismiss];
        }
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[self.defaultFirestore collectionWithPath:USER_TYPES] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        for (id user_types in snapshot.documents) {
            [self.userTypesArray addObject:user_types];
        }
        
    }];
    
    [self refresh];
     

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.documentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleTableViewCell"];
    
    FIRQueryDocumentSnapshot *data = self.documentArray[indexPath.row];
    
    cell.titleLabel.text = data[TITLE];
    cell.descriptionLabel.text = data[EXCERPT];
    
    FIRStorageReference *storageRef = [[FIRStorage storage] reference];
    FIRStorageReference *imagesRef = [storageRef child:@"images/posts"];
    NSString *fileName = data[COVER];
    imagesRef = [imagesRef child:[[fileName componentsSeparatedByString:@"/"] lastObject]];

    [imagesRef dataWithMaxSize:5000000 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            UIImage *image = [UIImage imageWithData: data];
            cell.articleImageView.image = image;
        }
    }];
    
    cell.tagListView.canSelectTags = NO;
    cell.tagListView.tagSelectedTextColor = [UIColor blackColor];
    cell.tagListView.tagCornerRadius = 5.0f;
    cell.tagListView.tagTextFont = [UIFont fontWithName:@"KrungthaiFast-LightItalic" size:14.0];
    [cell.tagListView.tags addObjectsFromArray:[self getTypeString:data[USER_TYPES]]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FIRQueryDocumentSnapshot *data = self.documentArray[indexPath.row];
    
    [[[self.defaultFirestore collectionWithPath:POSTS] documentWithPath:data.documentID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }];
}

- (NSArray *)getTypeString:(NSDictionary *)data {
    NSMutableArray *returnArray = [NSMutableArray array];
    for (NSString* key in data) {
        id value = data[key];
        if ([value boolValue]) {
            for (id type in self.userTypesArray) {
                FIRQueryDocumentSnapshot *data = type;
                if ([data.documentID isEqualToString:key]) {
                    [returnArray addObject:data[TITLE]];
                }
                
            }
        }
    }
    
    return returnArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
