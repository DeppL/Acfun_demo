//
//  UserViewController.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/26.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "UserViewController.h"
#import "UserViewModel.h"


@interface UserViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UserViewModel *userViewStructureModel;

@end

@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserViewStruction" ofType:@"plist"];
    
    self.userViewStructureModel = [UserViewModel mj_objectWithFile:path];
    
    self.navigationItem.title = self.userViewStructureModel.mainTitle;
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    NSArray *arr = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    UserViewSectionModel *sectionModel = self.userViewStructureModel.sectionArr[section];
    return sectionModel.rowArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableViewID = @"tableViewID";
    UserViewSectionModel *sectionModel = self.userViewStructureModel.sectionArr[indexPath.section];
    UserViewRowModel *rowModel = sectionModel.rowArr[indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = rowModel.rowTitle;
    
    switch (rowModel.rowType) {
        case UserTableViewCellStyleNone: {
            
            break;
        }
        case UserTableViewCellStyleSwitch: {
            UISwitch *sw = [[UISwitch alloc]init];
            cell.accessoryView = sw;
            
            break;
        }
        case UserTableViewCellStyleList: {
            cell.detailTextLabel.text = rowModel.detailTextArr[1];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        case UserTableViewCellStyleLabel: {
            double fileSize = [DLHttpTool getCacheFileSize];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2fM", fileSize];
            
            break;
        }
        case UserTableViewCellStylePushToOther: {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.userViewStructureModel.sectionArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    UserViewSectionModel *sectionModel = self.userViewStructureModel.sectionArr[section];
    return sectionModel.sectionTitle;
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserViewSectionModel *sectionModel = self.userViewStructureModel.sectionArr[indexPath.section];
    UserViewRowModel *rowModel = sectionModel.rowArr[indexPath.row];
    
    if (rowModel.rowType == UserTableViewCellStyleList) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:rowModel.detailTextArr[0] preferredStyle:UIAlertControllerStyleAlert];
        
        for (int i = 1; i < rowModel.detailTextArr.count; i++) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:rowModel.detailTextArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = action.title;
            }];
            
            [alertController addAction:alertAction];
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if (rowModel.rowType == UserTableViewCellStyleLabel) {
        [DLHttpTool clearCacheFile];
        NSArray *arr = [NSArray arrayWithObject:indexPath];
        [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    }
    
}




@end
