//
//  ButtonView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSArray * dataArr;
    
}

@end
@implementation ButtonView

- (instancetype)init{
    if (self = [super init]) {
    
        dataArr = @[@"本  周",@"本  月",@"本  年",@"全  部"];
        tableV = [[UITableView alloc]init];
        tableV.dataSource = self;
        tableV.delegate = self;
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"timeCELL"];
        
        tableV.separatorColor = [UIColor clearColor];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"timeCELL"];
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate) {
        [self.delegate changeTimeWithString:dataArr[indexPath.row] andindexpath_row:indexPath.row];
        [self removeFromSuperview];
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
