//
//  ClassifierViewController.h
//  Acfun_demo
//
//  Created by DeppL on 16/1/21.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChannelModel;

@interface ClassifierViewController : UIViewController


- (void)setChannelModel:(ChannelModel *)subModel andFirstResponseViewWithIndex:(NSInteger)indexRow;

@end
