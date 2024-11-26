//
//  AutomateViewController.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/25.
//

#import "AutomateViewController.h"

@interface AutomateViewController ()

@end

@implementation AutomateViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    NSLog(@"self.view.bounds.size.width11=%f",self.view.bounds.size.width);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}


@end
