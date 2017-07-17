//
//  Repos.h
//  2w4d1_gitHubRepos
//
//  Created by Seantastic31 on 17/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repos : NSObject

@property (strong, nonatomic) NSString *repoFullName;

-(instancetype)initWithInfo:(NSDictionary*)info;

@end
