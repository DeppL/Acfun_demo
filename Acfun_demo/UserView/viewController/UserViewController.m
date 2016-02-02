//
//  UserViewController.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/26.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()


@end

@implementation UserViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    UIImage *img = [UIImage imageNamed:@"tabbar_item_person"];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"USER" image:img selectedImage:nil];
    self.tabBarItem = tabBarItem;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
