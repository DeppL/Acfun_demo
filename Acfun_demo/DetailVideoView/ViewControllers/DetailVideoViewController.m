//
//  DetailVideoViewController.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/13.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "DetailVideoViewController.h"

#import "VideoTableViewCell.h"
#import "VideoDescriptionTableViewCell.h"
#import "VideoOwnerTableViewCell.h"
#import "VideoCommentsTableViewCell.h"

#import "DetailVideoModel.h"
#import "DetailCommentModel.h"
#import "DetailCommentModelFrame.h"

#import <GPUImage.h>



static NSString * const detailVideosURL = @"http://api.aixifan.com/videos";
static NSString * const detailCommentsURL = @"http://mobile.acfun.tv/comment/content/list?app_version=4.1.0&market=appstore&origin=ios&pageNo=1&pageSize=20&resolution=2048x1536&sys_name=ios&sys_version=9.2&version=4";

#define kVideoViewF CGRectMake(0, 0, kDeviceWidth, 400)
typedef void(^completed)();


@interface DetailVideoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, strong) DetailVideoModel *detailViderModel;
@property (nonatomic, strong) DetailCommentModel *detailCommentModel;
@property (nonatomic, copy) NSDictionary *detailCommentModelFrameDict;

@property (nonatomic, strong) UINavigationController *defautNaviC;

//@property (nonatomic, strong) UIImage *videoTableViewCellImage;
@property (nonatomic, strong) UIImage *navigetionBackgroundPicture;

@property (nonatomic, assign, getter=isVideoViewHidden) BOOL videoViewHidden;

@end

@implementation DetailVideoViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTransparentNav];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawingNavigetionBackgroundPicture:) name:DetailVideoTableViewCellImageCompleted object:nil];
    
    __weak __typeof(self) weakSelf = self;
    
    self.detailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setUpDetailVideo];
        [weakSelf setUpDetailComments];
    }];
    
    [self.detailTableView.mj_header beginRefreshing];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingView"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


#pragma mark - 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - initialize

- (UITableView *)detailTableView {
    if (!_detailTableView) {
        CGRect rect = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
        _detailTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.showsHorizontalScrollIndicator = NO;
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:VideoTableViewCellID];
        [_detailTableView registerClass:[VideoDescriptionTableViewCell class] forCellReuseIdentifier:VideoDescriptionTableViewCellID];
        [_detailTableView registerClass:[VideoOwnerTableViewCell class] forCellReuseIdentifier:VideoOwnerTableViewCellID];
        [_detailTableView registerClass:[VideoCommentsTableViewCell class] forCellReuseIdentifier:VideoCommentsTableViewCellID];
        [self.view addSubview:_detailTableView];
    }
    return _detailTableView;
}


/**
 *  设置 透明导航栏
 */
- (void)setUpTransparentNav {
    
    self.videoViewHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:IMAGE(@"transparent") forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.tabBarController.tabBar.hidden = YES;
    
}

/**
 *  设置 高斯模糊导航栏
 */
- (void)setUpBlurredNav {
    
    self.videoViewHidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:self.navigetionBackgroundPicture forBarMetrics:UIBarMetricsDefault];
}

/**
 *  下载 视频信息 UP主信息
 *
 */
- (void)setUpDetailVideo {
    
    NSString *str = [detailVideosURL stringByAppendingPathComponent:self.strURL];
    
    __weak __typeof(self) weakSelf = self;
    
    [DLHttpTool get:str params:nil cachePolicy:DLHttpToolReturnCacheDataElseLoad success:^(id json) {
        
        if (!weakSelf) return;
        weakSelf.detailViderModel = [DetailVideoModel mj_objectWithKeyValues:json[@"data"]];
        [weakSelf.detailTableView reloadData];
        
        [weakSelf.detailTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        if (!weakSelf) return;
        
        NSLog(@"failure");
        [weakSelf.detailTableView.mj_header endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"链接失败" message:@"网络连接失败，请重试。" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:nil];
        [alert show];
        
    }];
}

/**
 *  下载 评论内容
 */
- (void)setUpDetailComments {
    
    NSString *str = [detailCommentsURL stringByAppendingFormat:@"&contentId=%@",self.strURL];
    
    __weak __typeof(self) weakSelf = self;
    [DLHttpTool get:str params:nil cachePolicy:DLHttpToolReloadIgnoringLocalCacheData success:^(id json) {
        
        if (!weakSelf) return;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            DetailCommentModel *commentModel = [DetailCommentModel mj_objectWithKeyValues:json[@"data"]];
            
            __block NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
            [commentModel.page.map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                DetailCommentModelComment *subCommentModel = [DetailCommentModelComment mj_objectWithKeyValues:obj];
                [mDict setValue:subCommentModel forKey:key];
            }];
            commentModel.page.map = mDict;
            
            weakSelf.detailCommentModel = commentModel;
            weakSelf.detailCommentModelFrameDict = [DetailCommentModelFrame setUpFrameWithDetailCommentModelDict:mDict];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_detailViderModel) {
//                    [weakSelf.detailTableView reloadData];
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
                    [weakSelf.detailTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                }
            });
            
        });
        
    } failure:^(NSError *error) {
    }];
}


/**
 *  获取导航栏模糊化图片
 */
- (void)drawingNavigetionBackgroundPicture:(NSNotification *)notify {
    
    if (!self || self.navigetionBackgroundPicture) return;
    
    @synchronized(self) {
        
        if (!self || self.navigetionBackgroundPicture) return;
        
        __block UIImage *staticImage = notify.object;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // 截取整张图片
            UIGraphicsBeginImageContext(kVideoViewF.size);
            [staticImage drawInRect:CGRectMake(kVideoViewF.origin.x, kVideoViewF.origin.y, kVideoViewF.size.width, kVideoViewF.size.height)];
            UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            // 截取目标区域图片
            CGImageRef imageRef = reSizeImage.CGImage;
            CGRect rect = CGRectMake(0, (kVideoViewF.size.height - 64), kDeviceWidth, 64);
            imageRef = CGImageCreateWithImageInRect(imageRef, rect);
            UIImage *sendImage = [[UIImage alloc]initWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationUp];
            
            // 释放内存
            CGImageRelease(imageRef);
            
            // 图片模糊化
            GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc]init];
            blurFilter.blurRadiusInPixels = 10.0;
            UIImage *blurredImage = [blurFilter imageByFilteringImage:sendImage];
            self.navigetionBackgroundPicture = blurredImage;
            
            
        });

    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    else if (1 == section ) {
        return 2;
    }
    else {
        return self.detailCommentModel.page.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    id cell;
    
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:VideoTableViewCellID forIndexPath:indexPath];
        [cell setUpVideoTableViewCellWithModel:self.detailViderModel];
    }
    else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            cell = [tableView dequeueReusableCellWithIdentifier:VideoDescriptionTableViewCellID forIndexPath:indexPath];
            [cell setUpVideoDescriptionTableViewCellWithModel:self.detailViderModel];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:VideoOwnerTableViewCellID forIndexPath:indexPath];
            [cell setUpVideoOwnerTableViewCellWithModel:self.detailViderModel];
        }
        
    }
    else if (2 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:VideoCommentsTableViewCellID forIndexPath:indexPath];
        NSString *str = self.detailCommentModel.page.list[indexPath.row];
        NSString *keyStr = [NSString stringWithFormat:@"c%@",str];
        DetailCommentModelComment *commentModelComment = [self.detailCommentModel.page.map objectForKey:keyStr];
        DetailCommentModelFrame *commentModelCommentF = [self.detailCommentModelFrameDict objectForKey:keyStr];
        [cell setUpVideoCommentsTableViewCellWithModel:commentModelComment];
        [cell setUpVideoCommentsTableViewCellFrameWithModel:commentModelCommentF];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 400;
    }
    else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            return 104;
        }
        else return 90;
    }
    else if (2 == indexPath.section) {
        NSString *keyStr = [NSString stringWithFormat:@"c%@",self.detailCommentModel.page.list[indexPath.row]];
        DetailCommentModelFrame *modelFrame = [self.detailCommentModelFrameDict valueForKey:keyStr];
        return modelFrame.cellHeight;
    }
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 0;
    }
    else {
        return 44;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 == section) return nil;
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    headerView.textLabel.textColor = kMyRed;
    if (1 == section) {
        headerView.textLabel.text = @"视频信息";
    }
    else {
        headerView.textLabel.text = @"评论内容";
    }
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y > 400 - 64) && (!self.videoViewHidden)) {
        [self setUpBlurredNav];
        scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    else if ((scrollView.contentOffset.y < 400 - 64) && self.videoViewHidden) {
        [self setUpTransparentNav];
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}



@end
