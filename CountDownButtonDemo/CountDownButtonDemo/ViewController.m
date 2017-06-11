//
//  ViewController.m
//  CountDownButtonDemo
//
//  Created by sam on 2017/6/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [UILabel new];
    lable.center = self.view.center;
    lable.text = @"第一个界面";
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    [self.view addSubview:lable];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    FirstViewController *firstVC = [sb instantiateViewControllerWithIdentifier:@"FirstVC"];
    [self presentViewController:firstVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
