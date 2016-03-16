//
//  Animal.m
//  SearchBar
//
//  Created by Hoàng Thái on 3/16/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)initWithName:(NSString *)name photo:(UIImage *)photo {
    if(self == [super init]) {
        self.name = name;
        self.photo = photo;
        DetailsViewController* detail = [DetailsViewController new];
        detail.image = self.photo;
        detail.animalName = self.name;
    }
    return self;
}

@end
