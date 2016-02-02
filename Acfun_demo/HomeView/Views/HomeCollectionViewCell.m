//
//  HomeCollectionViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/20.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeCollectionViewCell.h"

#define kHomeCollectionViewCellPadding 20
#define kHomeCollectionViewCellW 300
#define kHomeCollectionViewCellH 170
#define kHomeCollectionViewCellImageViewW 300
#define kHomeCollectionViewCellImageViewH 150

@implementation HomeCollectionViewCell

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        CGRect mainImageViewRect = CGRectMake(0, 0, kHomeCollectionViewCellW, kHomeCollectionViewCellImageViewH);
        _mainImageView = [[UIImageView alloc]initWithFrame:mainImageViewRect];
        
    }
    return _mainImageView;
}


- (UILabel *)labelTitle {
    if (!_labelTitle) {
        CGRect labelTitleRect = CGRectMake(0, kHomeCollectionViewCellImageViewH, kHomeCollectionViewCellW, kHomeCollectionViewCellH - kHomeCollectionViewCellImageViewH);
        _labelTitle = [[UILabel alloc]initWithFrame:labelTitleRect];
    }
    return _labelTitle;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = CGRectMake(0, 0, kHomeCollectionViewCellW, kHomeCollectionViewCellH);
        self.backgroundColor = kMyRed;
        [self addSubview:self.mainImageView];
        [self addSubview:self.labelTitle];   
    }
    return self;
}

@end
