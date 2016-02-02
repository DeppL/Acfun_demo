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

//@property (nonatomic, strong) NSString *classifierMark;
//@property (nonatomic, strong)

@property (nonatomic, strong) ChannelModel *channelSubModel;

- (void)setFirstResponseViewWithIndex:(NSInteger)indexRow;

@end
