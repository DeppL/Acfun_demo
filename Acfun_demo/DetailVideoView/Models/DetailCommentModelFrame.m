//
//  DetailCommentModelFrame.m
//  Acfun_demo
//
//  Created by DeppL on 16/2/15.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "DetailCommentModelFrame.h"
#import "DetailCommentModel.h"

@implementation DetailCommentModelFrame

+ (NSDictionary *)setUpFrameWithDetailCommentModelDict:(NSDictionary *)detailCommentModelDict {
    __block NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    
    [detailCommentModelDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        DetailCommentModelFrame *commentModelF = [[DetailCommentModelFrame alloc]init];
        [commentModelF setUpFrameWithDetailCommentModel:obj];
        [mDict setValue:commentModelF forKey:key];
    }];
    
    
    return [mDict copy];
}

- (void)setUpFrameWithDetailCommentModel:(DetailCommentModelComment *)commentModel {
    self.userAvatarF = CGRectMake(kCustomPadding, kCustomPadding, 50, 50);
    self.userNameLabelF = CGRectMake(CGRectGetMaxX(self.userAvatarF) +kCustomPadding, kCustomPadding, 400, 25);
    self.releaseDateLabelF = CGRectMake(CGRectGetMinX(self.userNameLabelF), CGRectGetMaxY(self.userNameLabelF), 400, 25);
    self.floorLabelF = CGRectMake(kDeviceWidth - 100, CGRectGetMinY(self.userNameLabelF), 100, 25);
    
    CGRect rect = CGRectMake(kCustomPadding * 2, CGRectGetMaxY(self.userAvatarF) + kCustomPadding, kDeviceWidth - 3 * kCustomPadding, CGFLOAT_MAX);
    CGRect autoHeightRect = [commentModel.content boundingRectWithSize:rect.size
                                                               options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                            attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}
                                                               context:nil];
    rect.size.height = autoHeightRect.size.height;
    self.commentContentLabelF = rect;
    
    self.cellHeight = CGRectGetMaxY(self.commentContentLabelF) + kCustomPadding;
}

@end
