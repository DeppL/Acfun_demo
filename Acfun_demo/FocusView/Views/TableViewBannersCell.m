//
//  TableViewBannersCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewBannersCell.h"
#import "HomeModelConfig.h"

@interface TableViewBannersCell ()

@property (nonatomic, strong) UIImageView *mainImageView;

@end

@implementation TableViewBannersCell

#pragma mark - Public
#pragma mark -

- (void)setUpWithModel:(HomeModel *)model {
    
    NSURL *url = [[NSURL alloc]init];
    if (!model.image.length) {
        HomeModelContent *subModel = model.contents[0];
        url = [NSURL URLWithString:subModel.image];
    } else {
        url = [NSURL URLWithString:model.image];
    }
    
    UIImage *image = [UIImage imageNamed:@"placeHolder"];
    [self.mainImageView sd_setImageWithURL:url placeholderImage:image];
}

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame {
    self.mainImageView.frame = modelFrame.imageViewF;
}

#pragma mark - Private
#pragma mark -
- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_mainImageView];
    }
    return _mainImageView;
}



@end
