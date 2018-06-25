//
//  OnboardingViewController.m
//  chaipen
//
//  Created by Chakrit on 14/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "OnboardingViewController.h"
#import "CustomTabbarController.h"
#import "ToggleButton.h"

#import "CategoryCollectionViewCell.h"

@import Firebase;

@interface OnboardingViewController () <UICollectionViewDelegate , UICollectionViewDataSource>


@property (nonatomic, strong) FIRFirestore *defaultFirestore;

@property (nonatomic, weak) IBOutlet ToggleButton *manButton;
@property (nonatomic, weak) IBOutlet ToggleButton *womanButton;

@property (nonatomic, weak) IBOutlet ToggleButton *ageLower18Button;
@property (nonatomic, weak) IBOutlet ToggleButton *age1825Button;
@property (nonatomic, weak) IBOutlet ToggleButton *age2645Button;
@property (nonatomic, weak) IBOutlet ToggleButton *ageUpper45Button;

@property (nonatomic, strong) NSString *gendor;
@property (nonatomic, strong) NSString *age;



@property (nonatomic, assign) BOOL isGetCategory;
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectedCategoryArray;

@end

@implementation OnboardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.defaultFirestore = [FIRFirestore firestore];
    
    self.manButton.toggleIsOn = NO;
    self.womanButton.toggleIsOn = NO;
    self.gendor = @"";
    
    self.ageLower18Button.toggleIsOn = NO;
    self.age1825Button.toggleIsOn = NO;
    self.age2645Button.toggleIsOn = NO;
    self.ageUpper45Button.toggleIsOn = NO;
    self.age = @"";
    
    self.selectedCategoryArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (self.isGetCategory) {
        [SVProgressHUD show];
        [self getCategory];
    }
}


- (IBAction)gendorButtonSelect:(id)sender {
    ToggleButton *toggleButton = sender;
    if (toggleButton.tag == 0) {
        if (toggleButton.toggleIsOn) {
            self.manButton.toggleIsOn = NO;
            [self.manButton setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
        } else {
            self.gendor = @"male";
            self.manButton.toggleIsOn = YES;
            self.womanButton.toggleIsOn = NO;
            [self.manButton setImage:[UIImage imageNamed:@"man_active"] forState:UIControlStateNormal];
            [self.womanButton setImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
        }
        
    } else {
        if (toggleButton.toggleIsOn) {
            self.womanButton.toggleIsOn = NO;
            [self.womanButton setImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
        } else {
            self.gendor = @"female";
            self.womanButton.toggleIsOn = YES;
            self.manButton.toggleIsOn = NO;
            [self.manButton setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
            [self.womanButton setImage:[UIImage imageNamed:@"woman_active"] forState:UIControlStateNormal];
        }
    }
}


- (IBAction)ageButtonSelected:(id)sender {
    
    ToggleButton *toggleButton = sender;
    if (toggleButton.tag == 1) {
        if (toggleButton.toggleIsOn) {
            self.ageLower18Button.toggleIsOn = NO;
            [self.ageLower18Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        } else {
            self.age = @"lower18";
            self.ageLower18Button.toggleIsOn = YES;
            self.age1825Button.toggleIsOn = NO;
            self.age2645Button.toggleIsOn = NO;
            self.ageUpper45Button.toggleIsOn = NO;
            
            [self.ageLower18Button setImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateNormal];
            [self.age1825Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.age2645Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.ageUpper45Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            
        }
        
    } else if (toggleButton.tag == 2)  {
        if (toggleButton.toggleIsOn) {
            self.age1825Button.toggleIsOn = NO;
            [self.age1825Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        } else {
            self.age = @"18-25";
            self.ageLower18Button.toggleIsOn = NO;
            self.age1825Button.toggleIsOn = YES;
            self.age2645Button.toggleIsOn = NO;
            self.ageUpper45Button.toggleIsOn = NO;
            
            [self.age1825Button setImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateNormal];
            
            [self.ageLower18Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.age2645Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.ageUpper45Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        }
    } else if (toggleButton.tag == 3)  {
        if (toggleButton.toggleIsOn) {
            self.age2645Button.toggleIsOn = NO;
            [self.age2645Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        } else {
            self.age = @"26-45";
            self.ageLower18Button.toggleIsOn = NO;
            self.age1825Button.toggleIsOn = NO;
            self.age2645Button.toggleIsOn = YES;
            self.ageUpper45Button.toggleIsOn = NO;
            [self.age2645Button setImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateNormal];
            
            [self.ageLower18Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.age1825Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.ageUpper45Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        }
    } else {
        if (toggleButton.toggleIsOn) {
            self.ageUpper45Button.toggleIsOn = NO;
            [self.ageUpper45Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        } else {
            self.age = @"45upper";
            self.ageLower18Button.toggleIsOn = NO;
            self.age1825Button.toggleIsOn = NO;
            self.age2645Button.toggleIsOn = NO;
            self.ageUpper45Button.toggleIsOn = YES;
            [self.ageUpper45Button setImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateNormal];
            
            [self.ageLower18Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.age1825Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.age2645Button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        }
    }
}


- (IBAction)nextButtonTapped:(id)sender {
    
    [SVProgressHUD show];
    FIRDocumentReference *documentRef =
    [[self.defaultFirestore collectionWithPath:USER] documentWithPath:[FIRAuth auth].currentUser.uid];
    [documentRef updateData:@{
                              GENDOR : self.gendor,
                              AGE : self.age,
                              UPDATED : [NSDate date]
                              } completion:^(NSError * _Nullable error) {
                                  if (error != nil) {
                                      NSLog(@"Error updating document: %@", error);
                                  } else {
                                      OnboardingViewController *onboardingViewController2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OnboardingViewController2"];
                                      onboardingViewController2.isGetCategory = YES;
                                      [self setModalPresentationStyle: UIModalPresentationFullScreen];
                                      [self presentViewController:onboardingViewController2 animated:YES completion:^{
                                
                                      }];
                                  }
                              }];
    
    
}



/////////////// CATEGORY ///////////

- (void)getCategory {
    
    FIRCollectionReference *categoryRef = [self.defaultFirestore collectionWithPath:USER_TYPES];
    [categoryRef getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSLog(@"snapshot.documents[0] = %@",snapshot.documents[0]);
        self.categoryArray = [NSArray arrayWithArray:snapshot.documents];
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    FIRQueryDocumentSnapshot *data = self.categoryArray[indexPath.row];
    cell.title.text = data[TITLE];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isSelected) {
        cell.isSelected = NO;
        FIRQueryDocumentSnapshot *data = self.categoryArray[indexPath.row];
        [self.selectedCategoryArray removeObject:data.documentID];
    } else {
        cell.isSelected = YES;
        FIRQueryDocumentSnapshot *data = self.categoryArray[indexPath.row];
        [self.selectedCategoryArray addObject:data.documentID];
    }
    [cell setNeedsDisplay];
    
    
    // Determine the selected items by using the indexPath
    
    
}


- (IBAction)finishButtonTapped:(id)sender {
    
    FIRDocumentReference *documentRef =
    [[self.defaultFirestore collectionWithPath:USER] documentWithPath:[FIRAuth auth].currentUser.uid];
    [documentRef updateData:@{
                              USER_TYPES : self.selectedCategoryArray,
                    
                              } completion:^(NSError * _Nullable error) {
                                  if (error != nil) {
                                      NSLog(@"Error updating document: %@", error);
                                  } else {
                                      CustomTabbarController *customTabbarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarController"];
                                      [[UIApplication sharedApplication].keyWindow setRootViewController:customTabbarController];
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
