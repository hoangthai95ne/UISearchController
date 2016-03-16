//
//  DetailsViewController.h
//  SearchBar
//
//  Created by Hoàng Thái on 3/16/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *animalName;

- (instancetype)initWithImage: (UIImage*)image andAnimalName: (NSString*)animalName;

@end
