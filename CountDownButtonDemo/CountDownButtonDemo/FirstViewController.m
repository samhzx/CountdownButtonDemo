/*---------------------------------------------------------------------
 文件名称 : FirstViewController.m
 创建作者 : sam
 创建时间 : 2017/6/11
 文件描述 :
 版权信息 : Created by sam on 2017/6/11.
 ---------------------------------------------------------------------*/

#import "FirstViewController.h"
#import "CountdownButton.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet CountdownButton *getCode;
@property (nonatomic, strong) CountdownButton *countDownBtn;
@end

@implementation FirstViewController

#pragma mark - View Controller LifeCyle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
#pragma mark - Public Methods

#pragma mark - Privater Methods
- (void)initData {
    
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _countDownBtn = [CountdownButton buttonWithType:UIButtonTypeCustom];
    _countDownBtn.second = 20;
    [_countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _countDownBtn.bounds = CGRectMake(0, 0, 150, 50);
    _countDownBtn.center = self.view.center;
    _countDownBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _countDownBtn.layer.borderWidth = 1;
    _countDownBtn.layer.cornerRadius = 5;
    _countDownBtn.layer.masksToBounds = YES;
    [_countDownBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_countDownBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _countDownBtn.titleCall = ^NSString *(CountdownButton *sender, NSUInteger time) {
        return [NSString stringWithFormat:@"%zd秒后重新获取",time];
    };
    _countDownBtn.finishCall = ^NSString *(CountdownButton *sender) {
        return @"获取验证码";
    };
    [self.view addSubview:_countDownBtn];
    
    _getCode.second = 20;
    _getCode.layer.borderColor = [UIColor orangeColor].CGColor;
    _getCode.layer.borderWidth = 1;
    _getCode.layer.cornerRadius = 5;
    _getCode.layer.masksToBounds = YES;
    _getCode.titleCall = ^NSString *(CountdownButton *sender, NSUInteger time) {
        return [NSString stringWithFormat:@"%zd秒后重新获取",time];
    };
    _getCode.finishCall = ^NSString *(CountdownButton *sender) {
        return @"获取验证码";
    };
    [_getCode addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Override
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Initial Methods

#pragma mark - Target Methods
- (void)buttonClick:(CountdownButton *)sender{
    sender.fire = YES;
}

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Delegate

#pragma mark - Setter Getter Methods

@end
