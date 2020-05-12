//
//  SwitchLanguageVC.h
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 配置语言种类缩写和切换语言页面的语言列表（如果不知道语言名称，可以通过配置完国际化语言包后打开工程目录查看 .lproj 文件前缀）
#define LANGUAGE_NAMES_1   @[@"zh-Hans", @"en", @"ja", @"ko", @"th"]
#define LANGUAGE_NAMES_2   @[@"简体中文", @"English", @"日本語", @"한국어", @"ภาษาไทย"]

@interface SwitchLanguageVC : UIViewController

@end

NS_ASSUME_NONNULL_END
