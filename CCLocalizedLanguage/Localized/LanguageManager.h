//
//  LanguageManager.h
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kLocalizedLanguageDidChangedNotification;
@interface LanguageManager : NSObject

/// 当前使用语言
+ (NSString *)currentLanguageName;

/// 重置使用系统语言
+ (BOOL)resetToSystemLanguage;

/// 当前是否跟随的系统语言
+ (BOOL)isUsedSystemLanguage;

/// 切换语言
/// @param language 语言缩写
+ (BOOL)switchLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
