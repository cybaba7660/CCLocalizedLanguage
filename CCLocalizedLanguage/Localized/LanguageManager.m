//
//  LanguageManager.m
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import "LanguageManager.h"

NSString * const kLocalizedLanguageDidChangedNotification = @"kLocalizedLanguageDidChangedNotification";

//系统默认读取 app 语言的 key
#define kAppleLanguages     @"appleLanguages"
//记录用户使用的语言
#define kLastUsedLanguage   @"kLastUsedLanguage"

@implementation LanguageManager
+ (NSString *)currentLanguageName {
    NSString *lastLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUsedLanguage];
    NSString *language = lastLanguage.length ? lastLanguage : NSLocale.preferredLanguages.firstObject;
    return language;
}
+ (BOOL)resetToSystemLanguage {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastUsedLanguage];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kAppleLanguages];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)switchLanguage:(NSString *)language {
    if (!language.length) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:kLastUsedLanguage];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:kAppleLanguages];
    BOOL rs = [[NSUserDefaults standardUserDefaults] synchronize];
    if (rs) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocalizedLanguageDidChangedNotification object:language];
    }
    return rs;
}
@end
