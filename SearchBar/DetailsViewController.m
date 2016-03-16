//
//  DetailsViewController.m
//  SearchBar
//
//  Created by Hoàng Thái on 3/16/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController {
    CGPoint center;
    UIImageView *imageView;
    UILabel *label;
}

- (instancetype)initWithImage:(UIImage *)image andAnimalName:(NSString *)animalName {
    if (self = [super init]) {
        self.image = image;
        self.animalName = animalName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = center;
    label.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 200);
    label.text = self.animalName;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
//    NSLog(@"%@", self.animalName);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
