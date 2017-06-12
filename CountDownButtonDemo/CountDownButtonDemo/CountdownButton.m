/*---------------------------------------------------------------------
 文件名称 : CountdownButton.m
 创建作者 : sam
 创建时间 : 2017/6/10
 文件描述 :
 版权信息 : Created by sam on 2017/6/10.
 ---------------------------------------------------------------------*/


#import "CountdownButton.h"

static NSString *const kSaveTimeKey = @"kSaveTimeKey";

@interface CountdownButton ()
{
    NSUInteger _totalTime;//用来存放当前存放的事件
}
@property (nonatomic, strong) NSUserDefaults *dfl;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation CountdownButton
#pragma mark - View LifeCyle
- (void)dealloc{
    NSLog(@"倒计时button销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}
#pragma mark - Override

#pragma mark - Initial Methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimeKey) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimeKey) name:UIApplicationWillTerminateNotification object:nil];
}

#pragma mark - Public Methods

#pragma mark - Privater Methods
- (void)updateTime{
    _second = _second - 1;
    if (_second <= 0) {
        //移除NSUserDefaults存放的时间
        [self.dfl removeObjectForKey:kSaveTimeKey];
        if (_finishCall) {
            [self setTitle:_finishCall(self) forState:UIControlStateNormal];
        }
        _second = _totalTime;
        self.fire = NO;
    }else{
        //保存当前的倒计时到NSUserDefaults
        [self saveSecond];
        if (_titleCall) {
            [self setTitle:_titleCall(self,_second) forState:UIControlStateNormal];
        }
    }
}

/**
 保存当前时间
 */
- (void)saveSecond{
    [self.dfl setObject:@(_second) forKey:kSaveTimeKey];
}
- (void)removeTimeKey{
    [self.dfl removeObjectForKey:kSaveTimeKey];
    [self.dfl synchronize];
}
#pragma mark - Target Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Delegate

#pragma mark - Setter Getter Methods
- (void)setSecond:(NSUInteger)second{
    //存储当前设置的事件
    _totalTime = second;
    //获取NSUserDefaults里面存储的时间
    NSNumber *time = [self.dfl objectForKey:kSaveTimeKey];
    //如果取出时间不为空，就直接启动定时器，并且从当前取出的时间倒计时开始
    if (time) {
        _second = time.integerValue;
        self.fire = YES;
    }else{
        _second = second;
    }
}
- (dispatch_source_t)timer{
    if (_timer == nil) {
        _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC,0);
        __weak typeof(self) WeakSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //在该方法里面更新时间
                [WeakSelf updateTime];
            });
        });
    }
    return _timer;
}
- (NSUserDefaults *)dfl{
    if (_dfl == nil) {
        _dfl = [NSUserDefaults standardUserDefaults];
    }
    return _dfl;
}
- (void)setFire:(BOOL)fire{
    _fire = fire;
    
    NSAssert(_totalTime > 0, @"倒计时不能小于0");
    
    if (_fire) {
        dispatch_resume(self.timer);
        self.enabled = NO;
    }else{
        if (_timer) {
            //退出定时器
            dispatch_source_cancel(_timer);
            //定时器设置为nil 第二次启动的时候通过懒加载再次启动timer
            _timer = nil;
        }
        self.enabled = YES;
    }
}
@end
