//
//  ChannelCollectionViewCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/16.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "ChannelCollectionViewCell.h"

#define kChannelCollectionViewCellW 80
#define kChannelCollectionViewCellH 80
#define kChannelCollectionViewCellImageViewW 50
#define kChannelCollectionViewCellImageViewH 50

@implementation ChannelCollectionViewCell

- (UIImageView *)subChannelImageView {
    if (!_subChannelImageView) {
        CGRect subChannelImageViewRect = CGRectMake((kChannelCollectionViewCellW - kChannelCollectionViewCellImageViewW) * 0.5, 0, kChannelCollectionViewCellImageViewW, kChannelCollectionViewCellImageViewH);
        _subChannelImageView = [[UIImageView alloc]initWithFrame:subChannelImageViewRect];
        _subChannelImageView.backgroundColor = kMyWhite;
    }
    return _subChannelImageView;
}

- (UILabel *)subChannelLabel {
    if (!_subChannelLabel) {
        CGRect subChannelLabelRect = CGRectMake(0, kChannelCollectionViewCellImageViewH, kChannelCollectionViewCellW, (kChannelCollectionViewCellW - kChannelCollectionViewCellImageViewW));
        _subChannelLabel = [[UILabel alloc]initWithFrame:subChannelLabelRect];
        _subChannelLabel.textAlignment = NSTextAlignmentCenter;
        _subChannelLabel.textColor = RGB(150, 150, 150);
        _subChannelLabel.font = [UIFont systemFontOfSize:12];
        _subChannelLabel.backgroundColor = kMyWhite;
    }
    return _subChannelLabel;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = CGRectMake(0, 0, kChannelCollectionViewCellW, kChannelCollectionViewCellH);
        //    [self addSubview:self.subChannelButten];
        [self addSubview:self.subChannelImageView];
        [self addSubview:self.subChannelLabel];
    }
    return self;
}


@end
