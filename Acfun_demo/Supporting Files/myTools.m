//
//  myTools.m
//  Acfun_demo
//
//  Created by DeppL on 16/1/16.
//  Copyright © 2016年 DeppL. All rights reserved.
//

#import "myTools.h"
#import <objc/runtime.h>

@implementation myTools

+ (void)getProperties_obj:(id)obj {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    NSLog(@"%@",props);
}

//+ (void)printMothListOfObj:(id)obj
//{
//    unsigned int mothCout_f =0;
//    Method* mothList_f = class_copyMethodList([obj class],&mothCout_f);
//    for(int i=0;i<mothCout_f;i++)
//    {
//        Method temp_f = mothList_f[i];
////        IMP imp_f = method_getImplementation(temp_f);
////        SEL name_f = method_getName(temp_f);
//        const char* name_s =sel_getName(method_getName(temp_f));
//        int arguments = method_getNumberOfArguments(temp_f);
//        const char* encoding =method_getTypeEncoding(temp_f);
//        NSLog(@"\n\n方法名：%@\n参数个数：%d\n编码方式：%@\n",[NSString stringWithUTF8String:name_s],arguments,[NSString stringWithUTF8String:encoding]);
//    }
//    free(mothList_f);
//}

@end
