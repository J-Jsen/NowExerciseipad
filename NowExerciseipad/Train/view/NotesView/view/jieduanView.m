//
//  jieduanView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/14.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "jieduanView.h"

@interface jieduanView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArr;
    UITableView * tableV;
    
    
}

@end

@implementation jieduanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithArray:(NSMutableArray *)arr{
    
    if (self = [super init]) {
        self.backgroundColor = WINDOW_backgroundColor;
        
        dataArr = [NSArray array];
        dataArr = arr;
        
        tableV = [[UITableView alloc]init];
        tableV.delegate = self;
        tableV.dataSource = self;
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"jieduan"];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"jieduan"];
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate selectjieduanNumber:indexPath.row andjieduanStr:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
@end
