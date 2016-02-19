//
//  HomeModelFrame.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/29.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "HomeModelFrame.h"
#import "HomeModelConfig.h"

@implementation HomeModelFrame

#pragma mark - Public
#pragma mark -

+ (NSArray *)setUpFrameWithHomeModelArr:(NSArray *)homeModelArr {
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (int i = 0; i < homeModelArr.count; i ++) {
        
        HomeModelFrame *modelF = [HomeModelFrame setUpFrameWithHomeModel:homeModelArr[i]];
        
        [mArr addObject:modelF];
    }
    return [mArr copy];
}

+ (HomeModelFrame *)setUpFrameWithHomeModel:(HomeModel *)model {
    
    HomeModelFrame *modelF = [[HomeModelFrame alloc]init];
    switch ([model.type.typeId integerValue]) {
        case HomeViewCellTypeVideos: {
            
            modelF.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            modelF.headLabelF = CGRectMake(CGRectGetMaxX(modelF.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(modelF.headLabelF) - kCustomPadding, CGRectGetHeight(modelF.headImageViewF));
            modelF.collectionViewF = CGRectMake(0, CGRectGetMaxY(modelF.headImageViewF) + kCustomPadding, kDeviceWidth, 550);
            if ([model.channelId integerValue]) {
                modelF.footLabelF = CGRectMake(0, CGRectGetMaxY(modelF.collectionViewF), kDeviceWidth, 40);
            } else {
                modelF.footLabelF = CGRectMake(0, CGRectGetMaxY(modelF.collectionViewF), 0, 0);
            }
            
            modelF.cellHight = CGRectGetMaxY(modelF.footLabelF);
            return modelF;
        }
            
        case HomeViewCellTypeBanners: {
            modelF.imageViewF = CGRectMake(kCustomPadding, kCustomPadding, kDeviceWidth - kCustomPadding * 2.0, kDeviceWidth* 0.4 - kCustomPadding * 2.0);
            modelF.cellHight = CGRectGetMaxY(modelF.imageViewF) + kCustomPadding;
            return modelF;
        }
            
        case HomeViewCellTypeCarousels: {
            modelF.scrollViewF = CGRectMake(0, 0, kDeviceWidth, 300);
            modelF.cellHight = CGRectGetMaxY(modelF.scrollViewF);
            return modelF;
        }
            
        case HomeViewCellTypeBangumis: {
            
            modelF.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            modelF.headLabelF = CGRectMake(CGRectGetMaxX(modelF.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(modelF.headLabelF) - kCustomPadding, CGRectGetHeight(modelF.headImageViewF));
            modelF.collectionViewF = CGRectMake(0, CGRectGetMaxY(modelF.headImageViewF) + kCustomPadding, kDeviceWidth, kDeviceWidth);
            modelF.footLabelF = CGRectMake(0, CGRectGetMaxY(modelF.collectionViewF), kDeviceWidth, 40);
            modelF.cellHight = CGRectGetMaxY(modelF.footLabelF);
            return modelF;
        }
        case HomeViewCellTypeArticles: {
            
            modelF.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            modelF.headLabelF = CGRectMake(CGRectGetMaxX(modelF.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(modelF.headLabelF) - kCustomPadding, CGRectGetHeight(modelF.headImageViewF));
            modelF.tableViewF = CGRectMake(0, CGRectGetMaxY(modelF.headImageViewF) + kCustomPadding, kDeviceWidth, 295);
            modelF.footLabelF = CGRectMake(0, CGRectGetMaxY(modelF.tableViewF), kDeviceWidth, 40);
            modelF.cellHight = CGRectGetMaxY(modelF.footLabelF);
            return modelF;
        }
        default:
            return nil;
    }
}



@end
