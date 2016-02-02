//
//  CompilerMacros.h
//  NowApp
//
//  Created by Jay Lyerly on 7/8/13.
//  Copyright (c) 2013 StepLeader Inc. All rights reserved.
//

#ifndef RevealSDK_CompilerMacros_h
#define RevealSDK_CompilerMacros_h


// http://goodliffe.blogspot.com/2011/02/ios-dynamic-cast-in-objective-c.html
// simluate dynamic cast
// if object isn't subclass of type given, return nil
#define objc_dynamic_cast(TYPE, object) \
({ \
TYPE *dyn_cast_object = (TYPE*)(object); \
[dyn_cast_object isKindOfClass:[TYPE class]] ? dyn_cast_object : nil; \
})

// Turn off compiler warnings about dynamic selectors causing leaks
#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

// Turn off compiler warnings about problems with format statements
#define SUPPRESS_FORMAT_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wformat\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

// Turn off compiler warnings about problems with unresolved method statements
#define SUPPRESS_METHOD_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wobjc-method-access\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

// Turn off compiler warnings about deprecated API
#define SUPPRESS_DEPRECATION_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

#endif
