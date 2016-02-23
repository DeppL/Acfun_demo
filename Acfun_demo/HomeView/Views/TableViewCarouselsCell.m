//
//  TableViewCarouselsCell.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/26.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "TableViewCarouselsCell.h"
#import "HomeModelConfig.h"
#import "HomeModelFrame.h"

NSString * const TableViewCarouselsCellID = @"TableViewCarouselsCellID";

static CGFloat TimerDelayInSec = 4.0;
@interface TableViewCarouselsCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) HomeModel *model;

@end

@implementation TableViewCarouselsCell

#pragma mark - Public
#pragma mark -

- (void)setUpWithModel:(HomeModel *)model {
    
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    
    __weak __typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.model = model;
        NSInteger viewPage = model.contents.count;
        UIImage *placeHolder = [UIImage imageNamed:@"placeHolder"];
        
        NSMutableArray *mContentsArr = [NSMutableArray arrayWithArray:model.contents];
        [mContentsArr insertObject:mContentsArr.lastObject atIndex:0];
        [mContentsArr insertObject:mContentsArr[1] atIndex:mContentsArr.count];
        
        for (int i = 0; i < viewPage + 2; i ++) {
            
            HomeModelContent *subModel = mContentsArr[i];
            
            CGRect rect = CGRectMake(kDeviceWidth * i, 0, kDeviceWidth, 300);
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            NSURL *url = [NSURL URLWithString:subModel.image];
            [imageView sd_setImageWithURL:url placeholderImage:placeHolder];
            
            [weakSelf.scrollView addSubview:imageView];
        }
        
        weakSelf.scrollView.contentSize = CGSizeMake(kDeviceWidth * (viewPage + 2), 300);
        [weakSelf.scrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.contentView addSubview:weakSelf.scrollView];
            [weakSelf.contentView addSubview:weakSelf.pageControl];
            [weakSelf setUpTimer];
    
        });
    });

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
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.backgroundColor = kMyWhite;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        CGRect rect = CGRectMake(0, 0, 200, 100);
        _pageControl.frame = rect;
        _pageControl.center = CGPointMake(kDeviceWidth / 2, 275);
        _pageControl.numberOfPages = self.model.contents.count;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}


- (void)timerFired {
    CGPoint point = CGPointMake(self.scrollView.contentOffset.x, 0);
    NSUInteger set = point.x / kDeviceWidth;
    set += 1;
    point.x = set * kDeviceWidth;
    [self.scrollView setContentOffset:point animated:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (0 == offsetX) {
        CGPoint point = CGPointMake(kDeviceWidth * (self.model.contents.count), 0);
        [self.scrollView setContentOffset:point animated:NO];
        self.pageControl.currentPage = 4;
    }
    else if (kDeviceWidth * (self.model.contents.count + 1) == offsetX) {
        CGPoint point = CGPointMake(kDeviceWidth, 0);
        [self.scrollView setContentOffset:point animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = (offsetX / kDeviceWidth) - 0.5;
    }
    
}

- (void)setUpTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:TimerDelayInSec target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}




@end
