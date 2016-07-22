//
//  ViewController.m
//  GDC
//
//  Created by demon on 16/5/12.
//  Copyright © 2016年 demon. All rights reserved.
//

#import "ViewController.h"
#define global_queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define main_queue dispatch_get_main_queue()
@interface ViewController ()
@property (nonatomic,assign)BOOL log;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"1---%@",[NSThread currentThread]);
//    [self performSelector:@selector(run) withObject:nil afterDelay:3.0];
//    dispatch_queue_t  queue = dispatch_queue_create("name", 0);
//    dispatch_async(queue, ^{
//        NSLog(@"2--%@",[NSThread currentThread]);
//        [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"after---%@",[NSThread currentThread]);
//    });
//    dispatch_queue_t queue1 = dispatch_queue_create(0, 0);
//    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC);
//    dispatch_after(when, queue1, ^{
//        NSLog(@"queue1---%@",[NSThread currentThread]);
//    });
//    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    
  
 /*   dispatch_async(global_queue, ^{
        NSLog(@"---%@",[NSThread currentThread]);
        UIImage *image1 = [self imageWithUrl:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg"];
        UIImage *image2 = [self imageWithUrl:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        dispatch_async(main_queue, ^{
            NSLog(@"main----%@",[NSThread currentThread]);
            self.imageView1.image = image1;
            self.imageView2.image = image2;
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), YES, 0.0);
            [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
            [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
            self.imageView3.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSLog(@"hecheng---%@",[NSThread currentThread]);
        });
    });*/
    
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *image1 = nil;
////    dispatch_async(global_queue, ^{
    dispatch_group_async(group, global_queue, ^{
         image1 = [self imageWithUrl:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg"];
        NSLog(@"111---%@",[NSThread currentThread]);
    });
    
    __block UIImage *image2 = nil;
    dispatch_group_async(group, global_queue, ^{
        image2 = [self imageWithUrl:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSLog(@"222---%@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, main_queue, ^{
        self.imageView3.backgroundColor = [UIColor redColor];
        self.imageView1.image = image1;
        self.imageView2.image = image2;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), YES, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        self.imageView3.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog(@"333---%@",[NSThread currentThread]);
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_log == NO) {
        NSLog(@"vixingyici--%@",[NSThread currentThread]);
        _log =YES;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次--%@",[NSThread currentThread]);
    });
    NSLog(@"yici---%@",[NSThread currentThread]);
}
- (void)test{
    NSLog(@"test---%@",[NSThread currentThread]);
    
}
- (void)run{
    
    NSLog(@"run---%@",[NSThread currentThread]);
}
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_async(dispatch_queue_create(0, 0), ^{
        NSLog(@"touch---%@",[NSThread currentThread]);
        [self performSelector:@selector(test) withObject:nil afterDelay:2.0];
    });
    dispatch_sync(dispatch_queue_create(0, 0), ^{
        [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    });
    
}*/

- (UIImage *)imageWithUrl:(NSString *)urlstr{
    
    NSURL *url = [NSURL URLWithString:urlstr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
