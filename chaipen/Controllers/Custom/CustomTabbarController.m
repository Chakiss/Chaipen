//
//  CustomTabbarController.m
//  chaipen
//
//  Created by Chakrit on 23/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "CustomTabbarController.h"

@interface CustomTabbarController ()

@end

@implementation CustomTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    /*
    NSLog(@"CustomTabbarController viewWillAppear");
    [self.tabBar.items[1] setImage:[UIImage imageNamed:@"pocket"]];
    UITabBarItem *centerTab = self.tabBar.items[1];
    centerTab.image = [[UIImage imageNamed:@"pocket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    centerTab.selectedImage = [[UIImage imageNamed:@"pocket_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     */
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
