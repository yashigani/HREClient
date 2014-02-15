//
//  StationSearchViewController.m
//  RecommendArbeit
//
//  Created by taiki on 2/5/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import "StationSearchViewController.h"

#import "StationSearchDataSource.h"

@interface StationSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet StationSearchDataSource *dataSource;
@end

@implementation StationSearchViewController

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"dataSource.stations"];
}

- (void)awakeFromNib
{
    [self addObserver:self
           forKeyPath:@"dataSource.stations"
              options:NSKeyValueObservingOptionOld
              context:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexSet *indexSet = change[NSKeyValueChangeIndexesKey];
    NSKeyValueChange changeKind = (NSKeyValueChange)[change[NSKeyValueChangeKindKey] integerValue];

    NSMutableArray *indexPaths = [NSMutableArray array];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }];

    [self.tableView beginUpdates];
    if (changeKind == NSKeyValueChangeInsertion) { // 新規追加
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (changeKind == NSKeyValueChangeRemoval) { // 削除
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (changeKind == NSKeyValueChangeReplacement) { // 更新
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self.tableView endUpdates];
}

- (IBAction)searchFieldDidChanged:(id)sender
{
    [_dataSource refresh:_searchField.text];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(stationSearchViewController:didSelectStation:)]) {
        [_delegate stationSearchViewController:self didSelectStation:_dataSource.stations[indexPath.row]];
    }
}

@end
