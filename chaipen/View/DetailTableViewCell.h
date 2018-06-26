//
//  DetailTableViewCell.h
//  chaipen
//
//  Created by Chakrit on 26/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end
