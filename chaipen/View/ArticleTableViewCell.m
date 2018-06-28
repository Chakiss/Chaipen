//
//  ArticleTableViewCell.m
//  chaipen
//
//  Created by Chakrit on 25/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.cornerRadius = 5.f;
    self.shadowView.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    self.shadowView.layer.shadowRadius = 5.0f;
    self.shadowView.layer.shadowOpacity = .2f;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView.bounds].CGPath;
}

- (void)layoutIfNeeded {
    self.tagListHeight.constant = 50;
    if (self.tagListView.tags.count > 4) {
        self.tagListHeight.constant += 40;
    }
}

@end
