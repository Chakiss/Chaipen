//
//  CategoryCollectionViewCell.h
//  chaipen
//
//  Created by Chakrit on 24/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, assign) BOOL isSelected;
@end
