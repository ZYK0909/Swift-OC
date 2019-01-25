//
//  popView.m
//  Objective-CCode
//
//  Created by ZYK on 2018/4/25.
//  Copyright © 2018年 ZYK. All rights reserved.
//

#import "popView.h"
#import <pop/pop.h>



#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define BUTTON_WIDTH     80.0
#define BUTTON_HEIGHT    110.0

@interface popView()

@property (nonatomic, strong) NSMutableArray *buttonArray; //按钮数组
@property (nonatomic, strong) NSArray *imageArray;         //图片数组



@end
@implementation popView

- (NSMutableArray *)buttonArray {
    if(!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSArray *)imageArray {
    if(!_imageArray) {
        _imageArray = @[@"xin",@"xie",@"music",@"loacl",@"save",@"dian"];
    }
    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    //创建按钮
    [self createButton];
    
}
#pragma mark - 创建按钮
- (void)createButton {
    CGFloat buttonMargin = (SCREEN_WIDTH - 3 * BUTTON_WIDTH) / 4;
    for (int i = 0; i < 6; i++) {
        UIButton *button = [[UIButton alloc] init];
        int coloumIndex = i % 3;
        int rowIndex = i / 3;
        CGFloat buttonX = buttonMargin + (BUTTON_WIDTH + buttonMargin) * coloumIndex;
        CGFloat buttonY = (buttonMargin + BUTTON_HEIGHT) * rowIndex + SCREEN_HEIGHT;
        [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [self addSubview:button];
        button.frame = CGRectMake(buttonX, buttonY, BUTTON_WIDTH, BUTTON_HEIGHT);
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(didMusicButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 按钮点击事件 被点击放大 其余缩小
- (void)didMusicButtonClick:(UIButton *)button {
    [UIView animateWithDuration:1.0 animations:^{
        for (UIButton *musicButton in self.buttonArray) {
            if(button == musicButton) {
                musicButton.transform = CGAffineTransformMakeScale(2, 2);
            }
            else {
                musicButton.transform = CGAffineTransformMakeScale(0.2, 0.2);
                musicButton.alpha = 0.1;
            }
        }
    } completion:^(BOOL finished) {
        if(self.presentControllerBlock) {
            self.presentControllerBlock();
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - 按钮执行动画
- (void)buttonAnimation:(UIButton *)button index:(NSUInteger)index isShow:(BOOL)isShow {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    springAnimation.springBounciness = 10.0;
    springAnimation.springSpeed = 5;
    //延迟时间
    springAnimation.beginTime = CACurrentMediaTime() + index * 0.025;
    CGFloat buttonCenterY = button.center.y + (isShow ? -350 : 350);
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(button.center.x, buttonCenterY)];
    [button pop_addAnimation:springAnimation forKey:nil];
}
#pragma mark - 外部调用加载View
- (void)showView:(UIViewController *)VC {
    [VC.view addSubview:self];
    //开始动画
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton   * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self buttonAnimation:button index:idx isShow:YES];
    }];
}
#pragma mark - 点击移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //结束动画 ，0.5 秒后移除 反向遍历数组
    [[[self.buttonArray reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self buttonAnimation:button index:idx isShow:NO];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}


@end
