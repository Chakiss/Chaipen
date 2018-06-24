//
//  ArticleViewController.m
//  chaipen
//
//  Created by Chakrit on 14/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "ArticleViewController.h"

@import Firebase;

@interface ArticleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FIRFirestore *defaultFirestore;
@property (nonatomic, strong) NSArray *documentArray;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.defaultFirestore = [FIRFirestore firestore];
    // Do any additional setup after loading the view.
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[self.defaultFirestore collectionWithPath:POSTS]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
         if (error != nil) {
             NSLog(@"Error getting documents: %@", error);
         } else {
             for (FIRDocumentSnapshot *document in snapshot.documents) {
                 NSLog(@"%@ => %@", document.documentID, document.data);
             }
         }
     }];
    
    

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
