//
//  Repos.m
//  2w4d1_gitHubRepos
//
//  Created by Seantastic31 on 17/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "Repos.h"

@implementation Repos

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _repoFullName = info[@"full_name"];
    }
    return self;
}

@end
