//
//  ArticleTableViewCell.h
//  chaipen
//
//  Created by Chakrit on 25/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"

@interface ArticleTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *articleView;
@property (nonatomic, weak) IBOutlet UIView *shadowView;
@property (nonatomic, weak) IBOutlet UIImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;

@end
