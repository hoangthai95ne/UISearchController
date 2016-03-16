//
//  Animal.h
//  SearchBar
//
//  Created by Hoàng Thái on 3/16/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@interface Animal : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) DetailsViewController *detailViewController;

-(instancetype)initWithName: (NSString*)name photo: (UIImage*)photo;

@end
