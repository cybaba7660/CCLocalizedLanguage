//
//  ViewController.m
//  CCLocalizedLanguage
//
//  Created by Chenyi on 2020/5/12.
//  Copyright © 2020 Chenyi. All rights reserved.
//

#import "ViewController.h"
#import "SwitchLanguageVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 + 44 + 50, screenWidth, 60)];
    titleLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBlack];
    titleLabel.textColor = UIColor.blackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.text = NSLocalizedString(@"语言本地化", nil);
    
    UIButton *switchLanguageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    switchLanguageButton.frame = CGRectMake((screenWidth - 240) / 2, (screenHeight - 50) / 2, 240, 50);
    [switchLanguageButton setBackgroundColor:UIColor.blackColor];
    switchLanguageButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBlack];
    [switchLanguageButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [switchLanguageButton addTarget:self action:@selector(switchLanguageButtonClickedEvent) forControlEvents:UIControlEventTouchUpInside];
    [switchLanguageButton setAdjustsImageWhenHighlighted:NO];
    [self.view addSubview:switchLanguageButton];
    switchLanguageButton.layer.cornerRadius = 8;
    [switchLanguageButton setTitle:NSLocalizedString(@"切换语言", nil) forState:UIControlStateNormal];
}

- (void)switchLanguageButtonClickedEvent {
    SwitchLanguageVC *vc = [[SwitchLanguageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
