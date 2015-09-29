//
//  ViewController.m
//  SuperheroPedia
//
//  Created by Jim on 9/28/15.
//  Copyright (c) 2015 Jim Witheril. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property NSArray *heroes;
@property (weak, nonatomic) IBOutlet UITableView *superheroTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.heroes = [NSArray new];

    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.heroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.superheroTableView reloadData];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.heroes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperheroesID"];
    NSDictionary *superhero = [self.heroes objectAtIndex:indexPath.row];
    cell.textLabel.text = [superhero objectForKey:@"name"];
    cell.detailTextLabel.text = [superhero objectForKey:@"description"];

    return cell;
}


@end
