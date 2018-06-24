//
//  CategoryCollectionViewCell.m
//  chaipen
//
//  Created by Chakrit on 24/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (void)setNeedsDisplay {
    if (self.isSelected) {
        self.backgroundImageView.image = [UIImage imageNamed: @"button_active"];
    } else {
        self.backgroundImageView.image = [UIImage imageNamed: @"button"];
    }
}
@end
