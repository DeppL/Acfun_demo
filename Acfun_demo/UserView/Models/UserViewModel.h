//
//  UserViewModel.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/18.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserTableViewCellStyle) {
    UserTableViewCellStyleNone = 0,
    UserTableViewCellStyleSwitch,
    UserTableViewCellStyleList,
    UserTableViewCellStyleLabel,
    UserTableViewCellStylePushToOther
};

@interface UserViewModel : NSObject

@property (nonatomic, copy) NSString *mainTitle;

@property (nonatomic, copy) NSArray *sectionArr;

@end

@interface UserViewSectionModel : NSObject

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, copy) NSArray *rowArr;

@end

@interface UserViewRowModel : NSObject

@property (nonatomic, copy) NSString *rowTitle;

@property (nonatomic, assign) UserTableViewCellStyle rowType;

@property (nonatomic, copy) NSArray *detailTextArr;

@end

