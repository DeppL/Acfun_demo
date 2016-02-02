//
//  HomeModelFrame.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/29.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeModel;

@interface HomeModelFrame : NSObject

@property (nonatomic, assign) CGRect headImageViewF;

@property (nonatomic, assign) CGRect headLabelF;

@property (nonatomic, assign) CGRect footLabelF;

@property (nonatomic, assign) CGRect scrollViewF;

@property (nonatomic, assign) CGRect imageViewF;

@property (nonatomic, assign) CGRect collectionViewF;

@property (nonatomic, assign) CGRect tableViewF;

@property (nonatomic, assign) CGFloat cellHight;

//@property (nonatomic, copy) NSArray *homeModelFrameArr;

+ (NSArray *)setUpFrameWithHomeModelArr:(NSArray *)homeModelArr;

@end
