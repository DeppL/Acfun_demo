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
        HomeModelFrame *modelF = [[HomeModelFrame alloc]init];
        [modelF setUpFrameWithHomeModel:homeModelArr[i]];
        [mArr addObject:modelF];
    }
    return [mArr copy];
}

#pragma mark - Private
#pragma mark -




- (void)setUpFrameWithHomeModel:(HomeModel *)model {
    switch ([model.type.typeId integerValue]) {
        case HomeViewCellTypeVideos: {
            
            self.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            self.headLabelF = CGRectMake(CGRectGetMaxX(self.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(self.headLabelF) - kCustomPadding, CGRectGetHeight(self.headImageViewF));
            self.collectionViewF = CGRectMake(0, CGRectGetMaxY(self.headImageViewF) + kCustomPadding, kDeviceWidth, 550);
            if ([model.channelId integerValue]) {
                self.footLabelF = CGRectMake(0, CGRectGetMaxY(self.collectionViewF), kDeviceWidth, 40);
            } else {
                self.footLabelF = CGRectMake(0, CGRectGetMaxY(self.collectionViewF), 0, 0);
            }
            
            self.cellHight = CGRectGetMaxY(self.footLabelF);
            return;
        }
            
        case HomeViewCellTypeBanners: {
            self.imageViewF = CGRectMake(kCustomPadding, kCustomPadding, kDeviceWidth - kCustomPadding * 2.0, kDeviceWidth* 0.4 - kCustomPadding * 2.0);
            self.cellHight = CGRectGetMaxY(self.imageViewF) + kCustomPadding;
            return;
        }
            
        case HomeViewCellTypeCarousels: {
            self.scrollViewF = CGRectMake(0, 0, kDeviceWidth, 300);
            self.cellHight = CGRectGetMaxY(self.scrollViewF);
            return;
        }
            
        case HomeViewCellTypeBangumis: {
            
            self.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            self.headLabelF = CGRectMake(CGRectGetMaxX(self.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(self.headLabelF) - kCustomPadding, CGRectGetHeight(self.headImageViewF));
            self.collectionViewF = CGRectMake(0, CGRectGetMaxY(self.headImageViewF) + kCustomPadding, kDeviceWidth, kDeviceWidth);
            self.footLabelF = CGRectMake(0, CGRectGetMaxY(self.collectionViewF), kDeviceWidth, 40);
            self.cellHight = CGRectGetMaxY(self.footLabelF);
            return;
        }
        case HomeViewCellTypeArticles: {
            
            self.headImageViewF = CGRectMake(kCustomPadding, kCustomPadding, 25, 25);
            self.headLabelF = CGRectMake(CGRectGetMaxX(self.headImageViewF) + kCustomPadding, kCustomPadding, kDeviceWidth - CGRectGetMaxX(self.headLabelF) - kCustomPadding, CGRectGetHeight(self.headImageViewF));
            self.tableViewF = CGRectMake(0, CGRectGetMaxY(self.headImageViewF) + kCustomPadding, kDeviceWidth, 295);
            self.footLabelF = CGRectMake(0, CGRectGetMaxY(self.tableViewF), kDeviceWidth, 40);
            self.cellHight = CGRectGetMaxY(self.footLabelF);
            return;
        }
        default:
            break;
    }
}



@end
