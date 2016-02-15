//
//  VideoCommentsTableViewCell.h
//  Acfun_demo
//
//  Created by DeppL on 16/2/14.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailCommentModelComment;
@class DetailCommentModelFrame;
static NSString * const VideoCommentsTableViewCellID = @"VideoCommentsTableViewCellID";

@interface VideoCommentsTableViewCell : UITableViewCell

- (void)setUpVideoCommentsTableViewCellWithModel:(DetailCommentModelComment *)model;

- (void)setUpVideoCommentsTableViewCellFrameWithModel:(DetailCommentModelFrame *)commentModelCommentF;

@end
