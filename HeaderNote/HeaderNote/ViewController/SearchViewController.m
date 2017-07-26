//
//  SearchViewController.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/23.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSearchBar];
}
- (void)setupSearchBar{
    self.searchBar.scopeButtonTitles = @[@"新闻",@"娱乐",@"热点",@"可爱"];
//    self.searchBar.prompt = @"备注";
//    self.searchBar.barStyle = UISearchBarStyleMinimal;
    self.searchBar.showsScopeBar = YES;
    self.searchBar.selectedScopeButtonIndex = 1;
    self.searchBar.placeholder = @"请输入文字";
    
//    self.searchBar.showsBookmarkButton = YES;
//    self.searchBar.showsCancelButton = YES;
    
    self.searchBar.showsSearchResultsButton = YES;
    [self.searchBar setSearchResultsButtonSelected:YES];
    
    self.searchBar.tintColor = [UIColor redColor];
    self.searchBar.barTintColor = [UIColor greenColor];
    
    
    [self.view addSubview:self.searchBar];
    [self.searchBar sizeToFit];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"1"]];
    [self.searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"2"]];
    [self.searchBar setScopeBarButtonDividerImage:[UIImage imageNamed:@"1"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    [self.searchBar setSearchTextPositionAdjustment:UIOffsetMake(130, 30)];// 设置搜索框中文本框的文本偏移量
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    NSLog(@"%s",__FUNCTION__);
//    return YES;
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    NSLog(@"%s",__FUNCTION__);
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"%s",__FUNCTION__);
//    return YES;
//}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"%s",__FUNCTION__);
//}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"%s",__FUNCTION__);
//}
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"%s",__FUNCTION__);
//    return YES;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__FUNCTION__);
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__FUNCTION__);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__FUNCTION__);
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%d",searchBar.searchResultsButtonSelected);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0){
    NSLog(@"%s",__FUNCTION__);
}


- (UISearchBar *)searchBar{
    if (!_searchBar) {
        //高度并不会发生改变
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width -2 *10, 100)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
