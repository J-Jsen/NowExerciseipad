//
//  moveView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "moveView.h"
#import "trainModel.h"
#import "moveCell.h"
#import "HeaderView.h"
@interface moveView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView * tableV;
Arrayproperty(dataArr)
@end

@implementation moveView


- (instancetype)init{
    if (self = [super init]) {
        _dataArr = [NSMutableArray array];
        _tableV = [[UITableView alloc]init];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.backgroundColor = WINDOW_backgroundColor;
        [_tableV registerClass:[moveCell class] forCellReuseIdentifier:@"MOVEID"];
//        [_tableV registerClass:[HeaderView class] forCellReuseIdentifier:@"MOVEHEAD"];
//        [_tableV registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:@"MOVEHEAD"];
        [self addSubview:_tableV];
        [_tableV setSeparatorColor:[UIColor clearColor]];
        _tableV.bounces = NO;
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        [self updata];
        
    }
    return self;
}

- (void)updata{
    
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=train.framework",TESTBASEURL];
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        if (data && [data[@"rc"] integerValue] == 0) {
            NSArray * datarr = data[@"data"];
            for (NSDictionary * dic in datarr) {
                trainModel * model = [[trainModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
            }
            [_tableV reloadData];
            
        }else{
            [_delegate showAlertWithString:@"加载数据失败"];
        }
    } andfailBlock:^(NSError *error) {
        [_delegate showAlertWithString:@"服务器开小差了"];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    trainModel * model = _dataArr[section];
    NSArray * arr = model.subtitel;
    return arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    moveCell * cell = [[moveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MOVEID"];
    if (_dataArr.count > 0) {
    trainModel * model = _dataArr[indexPath.section];
    NSArray * arr = model.subtitel;
    NSDictionary * dic = arr[indexPath.row];

    [cell CreateCellWithString:dic[@"name"]];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate moveCellToplace:indexPath];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderView * view = [[HeaderView alloc]init];
    trainModel * model = _dataArr[section];
    [view CreateHeaderViewWithString:model.name];
    
    return view;
}
@end
