//
//  SearchViewController.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/28.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UITextField *searchFeild;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGPoint originPoint;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMyWhite;
    [self.view addSubview:self.webView];
    self.navigationItem.title = @"Acfun";
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)setUpNavi {
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(1536 / 2.0 - 44, 20, 44, 44)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *cancelBarButten = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = cancelBarButten;
    
    
    
    self.searchFeild = [[UITextField alloc]initWithFrame:CGRectMake(0, 20, 1536 / 2.0 - 100, 30)];
    self.searchFeild.placeholder = @"请输入关键词或ac号";
    self.searchFeild.backgroundColor = [UIColor whiteColor];
    [self.searchFeild setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIBarButtonItem *searchBarButten = [[UIBarButtonItem alloc]initWithCustomView:self.searchFeild];
    
    self.navigationItem.leftBarButtonItem = searchBarButten;
    
    [self.searchFeild becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
        _webView.backgroundColor = kMyWhite;
        _webView.scrollView.delegate = self;
        _webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, -64, 0);
        _webView.scrollView.bounces = NO;
        NSURL *url = [NSURL URLWithString:@"http://m.acfun.tv/search/?query=Acfun&back=http%3A%2F%2Fm.acfun.tv%2F"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
    }
    return _webView;
}

//- (void)clickBtnToCancel {
//    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController popToRootViewControllerAnimated:NO];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIScrollViewDelegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.originPoint = scrollView.contentOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint point = *targetContentOffset;
    
    if (velocity.y > 0 || self.originPoint.y < point.y) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else if (velocity.y < 0 || self.originPoint.y > point.y) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }

    
}
@end
