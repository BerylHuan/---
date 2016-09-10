//
//  ViewController.m
//  执行拷贝-黏贴操作
//
//  Created by 上海易裁 on 16/9/10.
//  Copyright © 2016年 上海易裁. All rights reserved.
//

#import "ViewController.h"
#import "MyLable.h"
#import "MyImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MyLable *lable = [[MyLable alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width - 20, 20)];
    lable.text = @"Do any additional setup after loading the view, typically from a nib.";
    [self.view addSubview:lable];
    MyImageView *myImageView = [[MyImageView alloc]initWithFrame:CGRectMake(20, lable.frame.origin.y + lable.frame.size.height + 100, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    myImageView.userInteractionEnabled = YES;
    myImageView.image = [UIImage imageNamed:@"2-2.jpg"];
    [self.view addSubview:myImageView];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
