//
//  TableViewCarouselsCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewCarouselsCell.h"
//#import "HomeModel.h"
#import "HomeModelConfig.h"
#import "HomeModelFrame.h"

@interface TableViewCarouselsCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TableViewCarouselsCell

#pragma mark - Public
#pragma mark -

- (void)setUpWithModel:(HomeModel *)model {
    NSInteger viewPage = model.contents.count;
    UIImage *placeHolder = [UIImage imageNamed:@"placeHolder"];
    
    
    for (int i = 0; i < viewPage; i ++) {
        
        HomeModelContent *subModel = model.contents[i];
        
        CGRect rect = CGRectMake(kDeviceWidth * i, 0, kDeviceWidth, 300);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        NSURL *url = [NSURL URLWithString:subModel.image];
        [imageView sd_setImageWithURL:url placeholderImage:placeHolder];
        
        [self.scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth * viewPage, 300);
    [self.contentView addSubview:_scrollView];
    self.contentView.frame = CGRectZero;
}

- (void)setUpWithModelFrame:(HomeModelFrame *)modelFrame {
    self.scrollView.frame = modelFrame.scrollViewF;
}

#pragma mark - Private
#pragma mark -

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

@end
