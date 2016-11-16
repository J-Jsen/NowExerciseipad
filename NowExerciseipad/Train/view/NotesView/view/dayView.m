//
//  dayView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/14.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "dayView.h"

@interface dayView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArr;
    UITableView * tableV;
    
}
@end
@implementation dayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithArray:(NSArray *)arr{
    if (self = [super init]) {
        dataArr = [NSArray arrayWithArray:arr];
        tableV = [[UITableView alloc]init];
        tableV.dataSource = self;
        tableV.delegate = self;
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"day"];
        [self addSubview:tableV];
        tableV.backgroundColor = WINDOW_backgroundColor;
        [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",dataArr.count);
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"day"];
    cell.textLabel.text = dataArr[indexPath.row][@"name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate dayselectNumber:[dataArr[indexPath.row][@"id"] integerValue] anddayL:dataArr[indexPath.row][@"name"]];
    
}


@end
