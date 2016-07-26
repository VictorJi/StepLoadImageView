//
//  ViewController.m
//  StepLoadImageViewDemo
//
//  Created by Victor Ji on 16/7/26.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "ViewController.h"
#import "StepLoadImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet StepLoadImageView *imageView;

- (IBAction)nextButtonClickAction:(id)sender;
- (IBAction)previousButtonClickAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *strings = @[@"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/57861489eea30.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148a1c714.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148a3a171.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148a58561.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148a74c18.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148a90c97.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148b4636f.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148b0c760.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148b292b1.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148b6527a.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148b8648c.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148ba419d.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148c0bfd6.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148bc2da6.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148be54b9.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148c2ac8a.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148c5fd0b.jpg",
                         @"http://o7ayoj9ye.bkt.clouddn.com/2016-07-13/5786148c44e7e.jpg"];
    self.imageView.imageUrlStrings = strings;
    
    [self.imageView startUpDowloadImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextButtonClickAction:(id)sender {
    [self.imageView toNextPage];
}

- (IBAction)previousButtonClickAction:(id)sender {
    [self.imageView toPreviousPage];
}

@end
