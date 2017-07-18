//
//  ViewController.m
//  2w4d1_gitHubRepos
//
//  Created by Seantastic31 on 17/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "ViewController.h"
#import "Repos.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Repos*> *repos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repos = @[];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/harrisonkimca/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError)
        {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // temp array to store results which are a list of repo objects (array of dictionaries)
        NSMutableArray *tmpRepos = [@[] mutableCopy];
        for (NSDictionary *repo in repos)
        {
            Repos *myRepo = [[Repos alloc]initWithInfo:repo];
            [tmpRepos addObject:myRepo];
            NSString *repoName = repo[@"full_name"];
            NSLog(@"repo: %@", repoName);
        }
        self.repos = [NSArray arrayWithArray:tmpRepos];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    
    [dataTask resume];
}


#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Repos *repos = self.repos[indexPath.row];
    cell.textLabel.text = repos.repoFullName;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end
