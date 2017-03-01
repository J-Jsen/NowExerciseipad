//
//  leftTrainerView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "leftTrainerView.h"

#import "teacherCell.h"
#import "TeacherModel.h"
@interface leftTrainerView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    
    NSInteger lastinteger;

}

@end


@implementation leftTrainerView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
        
        dataArr = [NSMutableArray array];
        tableV = [[UITableView alloc]init];
        tableV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
        tableV.separatorColor = [UIColor clearColor];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.bounces = NO;
        [tableV registerClass:[teacherCell class] forCellReuseIdentifier:@"teachCELL"];
        
        [self addSubview:tableV];
//tablv布局
        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        [self updata];
    }
    return self;
}

- (void)updata{
    
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=train.allcoach",BASEURL];
    NSLog(@"%@",url);
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        //        NSLog(@"%@",data);
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            NSArray * datarr = dic[@"data"];
            for (NSDictionary * dic in datarr) {
                TeacherModel * model = [[TeacherModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
                TeacherModel * model = dataArr[0];
                model.iselect = YES;
                
                NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"teach" object:nil userInfo:@{@"uid":model.uid}];
                
            });
            
        }else{
            NSLog(@"获取异常");
        }
    } andfailBlock:^(NSError *error) {
        NSLog(@"获取人员失败");
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    teacherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"teachCELL"];
    if (dataArr.count > 1) {
        TeacherModel * model = dataArr[indexPath.row];
        [cell createCellWithModel:model];

    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (lastinteger != indexPath.row) {
        teacherCell * lastcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastinteger inSection:0]];
        
        [lastcell disselectCellwithmodel:dataArr[lastinteger]];
        TeacherModel * lastmodel = dataArr[lastinteger];
        lastmodel.iselect = NO;
        
        teacherCell * cell = [tableV cellForRowAtIndexPath:indexPath];
        lastinteger = indexPath.row;
        [cell selectCellwithmodel:dataArr[indexPath.row]];
        NSArray * arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:lastinteger inSection:0],indexPath, nil];
        [tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        TeacherModel * model = dataArr[indexPath.row];
        
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"teach" object:nil userInfo:@{@"uid":model.uid}];
        
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
