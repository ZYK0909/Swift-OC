//
//  ViewController.m
//  Objective-CCode
//
//  Created by ZYK on 2018/4/25.
//  Copyright © 2018年 ZYK. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "popView.h"
#import "PresentViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createAddButton];
}

- (void)createAddButton {
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"addbg"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [addButton addTarget:self action:@selector(didAddButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)didAddButtonClick {
    NSLog(@"我被点击了");
    popView *pView = [[popView alloc] init];
    [pView showView:self];
    __weak typeof(self) weakself = self;
    pView.presentControllerBlock = ^{
        PresentViewController *VC = [[PresentViewController alloc] init];
        [weakself presentViewController:VC animated:YES completion:nil];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
