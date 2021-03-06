//
//  ViewController.m
//  MultiEnvironmentLearning
//
//  Created by MissSunRise on 2021/3/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *currentEnvironmentString;
    
#ifdef DEBUG
    currentEnvironmentString = @"DEBUG";
#elif INTERNAL
    currentEnvironmentString = @"INTERNAL";
#else
    currentEnvironmentString = @"RELEASE";
#endif
    
    NSLog(@"%@",currentEnvironmentString);

}


@end
