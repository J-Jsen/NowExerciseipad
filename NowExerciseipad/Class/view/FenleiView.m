//
//  FenleiView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "FenleiView.h"


@implementation FenleiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init{
    if (self = [super init]) {
        
        _tableV = [[UITableView alloc]init];
        
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _arr = [NSMutableArray array];
        _tableV.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableV];
        _tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.and.bottom.offset(0);
            
        }];
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}
- (void)createUIWithArr:(NSMutableArray *)arr{
    
    _arr = arr;
    if (_arr) {
        [_tableV reloadData];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _arr[indexPath.row][@"level_name"];
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * data = _arr[indexPath.row][@"content"];
    [self.delegate backdata:data];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

@end
