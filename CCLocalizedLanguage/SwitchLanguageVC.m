//
//  SwitchLanguageVC.m
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import "SwitchLanguageVC.h"
#import "LanguageManager.h"

// 配置语言种类缩写和切换语言页面的语言列表（如果不知道语言名称，可以通过配置完国际化语言包后打开工程目录查看 .lproj 文件前缀）
#define LANGUAGE_NAMES_1   @[@"zh-Hans", @"en", @"ja", @"ko", @"th"]
#define LANGUAGE_NAMES_2   @[@"简体中文", @"English", @"日本語", @"한국어", @"ภาษาไทย"]

@interface SwitchLanguageVC ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray *languages;
    NSUInteger originalIndex;
    NSUInteger selectedIndex;
}
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@end

@implementation SwitchLanguageVC
#pragma mark - Dealloc
- (void)dealloc {
    NSLog(@"dealloc - SwitchLanguageVC");
}
#pragma mark - Set/Get

#pragma mark - LiftCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark - Init
- (void)initData {
    languages = [@[NSLocalizedString(@"跟随系统", nil)] arrayByAddingObjectsFromArray:LANGUAGE_NAMES_2];
    selectedIndex = 0;
    
    NSString *currentLanguage = [LanguageManager currentLanguageName];
    [LANGUAGE_NAMES_1 enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:currentLanguage]) {
            selectedIndex = idx + 1;
            *stop = YES;
        }
    }];
    originalIndex = selectedIndex;
}
#pragma mark - UI
- (void)setupUI {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, screenWidth, screenHeight - 44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.tableFooterView = tableFooterView;
    [self.view addSubview:tableView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.indicatorView = indicator;
    indicator.frame = CGRectMake((screenWidth - 100) / 2, (screenHeight - 100) / 2, 100, 100);
    indicator.color = UIColor.whiteColor;
    indicator.backgroundColor = UIColor.grayColor;
    indicator.layer.cornerRadius = indicator.bounds.size.height / 10;
    [self.view addSubview:indicator];
}

#pragma mark - Request
#pragma mark - EventMethods
- (void)completedButtonClickedEvent {
    if (originalIndex == selectedIndex) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.indicatorView startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            
            if (self->selectedIndex == 0) {
                [LanguageManager resetToSystemLanguage];
            }else {
                NSString *selectedLanguage = LANGUAGE_NAMES_1[self->selectedIndex - 1];
                [LanguageManager switchLanguage:selectedLanguage];
            }

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
        });
    }
}
#pragma mark - CommonMethods

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"language_sel"]];
        cell.accessoryView = imageView;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = languages[indexPath.row];
    cell.accessoryView.hidden = indexPath.row != selectedIndex;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *kNormalHeadId = @"kNormalHeadId";
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kNormalHeadId];
    if (!headView) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kNormalHeadId];
    }
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    UIButton *completedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    completedButton.frame = CGRectMake(20, 40, UIScreen.mainScreen.bounds.size.width - 40, 50);
    [completedButton setBackgroundColor:UIColor.greenColor];
    [completedButton setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
    completedButton.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightSemibold];
    [completedButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [completedButton addTarget:self action:@selector(completedButtonClickedEvent) forControlEvents:UIControlEventTouchUpInside];
    [completedButton setAdjustsImageWhenHighlighted:NO];
    completedButton.layer.cornerRadius = 6;
    [footerView addSubview:completedButton];
    
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedIndex) {
        return;
    }
    UITableViewCell *lastSelectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    lastSelectedCell.accessoryView.hidden = YES;
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryView.hidden = NO;
    selectedIndex = indexPath.row;
}
@end
