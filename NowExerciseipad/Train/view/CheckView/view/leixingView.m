//
//  leixingView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "leixingView.h"

@interface leixingView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArr;
    UITableView * tableV;
    
}

@end

@implementation leixingView

- (instancetype)init{
    if (self = [super init]) {
        dataArr = [NSArray arrayWithObjects:@"入职",@"季度", nil];
        tableV = [[UITableView alloc]init];
        tableV.dataSource = self;
        tableV.delegate = self;
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leixingCELL"];
        tableV.bounces = NO;

        [self addSubview:tableV];
        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"leixingCELL"];
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        [self.delegate backleixingStr:dataArr[indexPath.row]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
