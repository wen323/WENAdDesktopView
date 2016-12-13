//
//  ViewController.m
//  WENAdDesktopView
//
//  Created by HS001 on 2016/12/13.
//  Copyright © 2016年 WEN. All rights reserved.
//

#import "ViewController.h"
#import "WENDesktopView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_SIZE.width,SCREEN_SIZE.height)];
    downView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:downView];
    
    UIButton *adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    adBtn.frame = CGRectMake(SCREEN_SIZE.width/2 - 75, 200, 150, 30);
    adBtn.backgroundColor = [UIColor redColor];
    [adBtn setTitle:@"弹出广告页面" forState:UIControlStateNormal];
    adBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [adBtn addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];

    [downView addSubview:adBtn];


}

- (void)topClick:(UIButton *)btn{
    WENDesktopView *adView = [[WENDesktopView alloc]init];
    [adView showInView:self.view  image:[UIImage imageNamed:@"minhaha"]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
