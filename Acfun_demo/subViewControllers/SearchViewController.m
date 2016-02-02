//
//  SearchViewController.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/28.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (nonatomic, strong) UITextField *searchFeild;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(1536 / 2.0 - 44, 20, 44, 44)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancelBtn addTarget:self action:@selector(clickBtnToCancel) forControlEvents:UIControlEventTouchUpInside];
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

- (void)clickBtnToCancel {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
