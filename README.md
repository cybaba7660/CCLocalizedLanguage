# CCLocalizedLanguage
iOS - 在 App 内优雅的切换语言

## 效果
![image](https://github.com/cybaba7660/CCLocalizedLanguage/blob/master/images/switch%20language.gif)

## 集成

##### 1、手动集成

手动前往 Github [项目地址](https://github.com/cybaba7660/CCLocalizedLanguage) ，下载完成后拷贝 `Localized` 目录到工程中

##### 2、Cocopods 集成

`Podfile` 文件导入 `pod 'CCLocalizedLanguage'`

## 使用

##### 1、导入 `\#import "LanguageManager.h"`

##### 2、切换语言

###### 指定国家语言

```objective-c
[LanguageManager switchLanguage:selectedLanguage];
```

###### 恢复跟随系统语言

```objective-c
[LanguageManager resetToSystemLanguage];
```

##### 3、刷新，重新指定根控制器以起到刷新所有页面的效果

```objective-c
NSArray *array = UIApplication.sharedApplication.connectedScenes.allObjects;
UIWindowScene *windowScene = array.firstObject;
UIWindow *window = windowScene.windows.firstObject;
UINavigationController *rootVC = (UINavigationController *)window.rootViewController;

UIViewController *newVC = [rootVC.viewControllers.firstObject.class.alloc init];
UINavigationController *newRootVC = [[UINavigationController alloc] initWithRootViewController:newVC];
            
SwitchLanguageVC *languageVC = [[SwitchLanguageVC alloc] init];
[newRootVC pushViewController:languageVC animated:NO];
            
window.rootViewController = newRootVC;
rootVC = nil;
            
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [newRootVC popViewControllerAnimated:YES];
});
```
## 文章地址 [iOS 如何优雅的集成 App 内切换多国语言功能](https://www.jianshu.com/p/ae4c064b7292)
