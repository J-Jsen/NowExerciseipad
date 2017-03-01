//
//  searchView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "searchView.h"

#import "OrderModel.h"
#import "OrderCell.h"


@interface searchView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    
    NSString * url;
}

@end

@implementation searchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = WINDOW_backgroundColor;
        
        dataArr = [NSMutableArray array];
        tableV = [[UITableView alloc]init];
        tableV.separatorColor = [UIColor clearColor];
        tableV.delegate = self;
        tableV.dataSource = self;
        [tableV registerClass:[OrderCell class] forCellReuseIdentifier:@"orderCELL"];
        
        tableV.backgroundColor = WINDOW_backgroundColor;
        [self addSubview:tableV];
        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
    }
    return self;
}
#pragma mark 网址---请求数据

- (void)seturlWithString:(NSString *)str{
    
    NSString * string = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];

    url = [NSString stringWithFormat:@"%@pad/?method=coach.search&kv=%@&version=v2",BASEURL,string];
    
    [self updata];
}
- (void)updata{
    
    [dataArr removeAllObjects];
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSLog(@"%@",data);
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            NSArray * arr = dic[@"data"];
            for (NSDictionary * dic in arr) {
                OrderModel * model = [[OrderModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic];
                model.newOrder = NO;
                [dataArr addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
                
            });
            
        }else{
        }
    } andfailBlock:^(NSError *error) {
        
        
    }];
    
}

#pragma mark tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderCELL"];
    if (dataArr.count > 0) {
        OrderModel * model = dataArr[indexPath.row];
        [cell createCellWithmodel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderModel * model = dataArr[indexPath.row];
    _detaiV = [[searchDetailView alloc]init];
    
    _detaiV.orderID = model.order_id;
    _detaiV.personal_id = model.personal_id;
    
    _detaiV.isdone = model.Process;
    [_detaiV postgoBtnStatus];
    [_detaiV createUpdataBtn];
    
    [self addSubview:_detaiV];

    [_detaiV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 175;
    
}
@end
