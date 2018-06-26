//
//  DetailViewController.h
//  chaipen
//
//  Created by Chakrit on 26/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) FIRQueryDocumentSnapshot *data;
@end
