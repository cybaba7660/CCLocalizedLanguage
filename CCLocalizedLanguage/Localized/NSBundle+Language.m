//
//  NSBundle+Language.m
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import "NSBundle+Language.h"
#import "LanguageManager.h"
#import <objc/runtime.h>

@implementation NSBundle (Language)
+ (void)load {
    SEL originalSel = @selector(localizedStringForKey:value:table:);
    SEL newSel = @selector(exchange_localizedStringForKey:value:table:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}
- (NSString *)exchange_localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSString *language = [LanguageManager currentLanguageName];
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:language ofType:@".lproj"];
    if (bundlePath.length) {
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        return [bundle exchange_localizedStringForKey:key value:value table:tableName];
    }
    return [self exchange_localizedStringForKey:key value:value table:tableName];
}
@end
