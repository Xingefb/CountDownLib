//
//  ViewController.m
//  DzyTimer
//
//  Created by Dzy on 07/11/2017.
//  Copyright © 2017 Dzy. All rights reserved.
//

#import "ViewController.h"
#import "DzyTimer.h"

@interface ViewController ()
<
DzyTimerDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *showNum;
@property (nonatomic ) NSString *number;

@end

@implementation ViewController

/**
 DzyTimerDelegate
 */
- (void)startingCountDown {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *num = [NSString stringWithFormat:@"%ld",_showNum.text.integerValue - 1];
        if ([num isEqualToString:@"0"]) {
            [[DzyTimer sharedDzyTimer] stopTimer];
        }
        if (num.integerValue >= 0) {
            [_showNum setText:num];
        }
    });

}

- (IBAction)toStart:(UIButton *)sender {
    [[DzyTimer sharedDzyTimer] startCountDown];
}

- (IBAction)toPause:(UIButton *)sender {
    [[DzyTimer sharedDzyTimer] pauseTimer];
}

- (IBAction)toResume:(UIButton *)sender {
    [[DzyTimer sharedDzyTimer] resumeTimer];
}

- (IBAction)toStop:(UIButton *)sender {
    _showNum.text = @"60";
    [[DzyTimer sharedDzyTimer] stopTimer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_showNum.text.integerValue <= 30) {
        NSString *num = [NSString stringWithFormat:@"%ld",_showNum.text.integerValue + 30];
        _showNum.text = num;
        [[DzyTimer sharedDzyTimer] restarTimer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _showNum.text = @"60";
    // 暂停 - 重置      停止 - 开始
    [DzyTimer sharedDzyTimer].delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
