//
//  leftdetailV.m
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "leftdetailV.h"
#import "TeacherModel.h"
#import "teacherCell.h"

//#import "NotesView.h"
@interface leftdetailV()<UITableViewDelegate,UITableViewDataSource>
{
//    teacherCell * lastcell;
    NSInteger lastinteger;
    
}
@property (nonatomic , strong) UITableView * tableV;

Arrayproperty(dataArr)


@end

@implementation leftdetailV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
        _dataArr = [NSMutableArray array];
        _tableV = [[UITableView alloc]init];
        _tableV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        [_tableV setSeparatorColor:[UIColor clearColor]];
        [_tableV registerClass:[teacherCell class] forCellReuseIdentifier:@"TEACHER"];
        lastinteger = 0;
        
        [self addSubview:_tableV];
        
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
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
                [_dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableV reloadData];
            });
            
        }else{
            NSLog(@"获取异常");
        }
    } andfailBlock:^(NSError *error) {
        NSLog(@"获取人员失败");
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    teacherCell * cell = [[teacherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TEACHER"];
    if (_dataArr.count > 1) {
        TeacherModel * model = _dataArr[indexPath.row];
        [cell createCellWithModel:model];
   
    }

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (lastinteger != indexPath.row) {
        teacherCell * lastcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastinteger inSection:0]];
        
        [lastcell disselectCellwithmodel:_dataArr[lastinteger]];
        TeacherModel * lastmodel = _dataArr[lastinteger];
        lastmodel.iselect = NO;
        teacherCell * cell = [_tableV cellForRowAtIndexPath:indexPath];
        lastinteger = indexPath.row;
        [cell selectCellwithmodel:_dataArr[indexPath.row]];
        NSArray * arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:lastinteger inSection:0],indexPath, nil];
        [tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        TeacherModel * model = _dataArr[indexPath.row];

        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        
        [center postNotificationName:@"jiaolian" object:nil userInfo:@{@"uid":model.uid}];
        
    }
    
   
}
- (void)reloadtableview{
    for (TeacherModel * model in _dataArr) {
        model.iselect = NO;
        
    }
    TeacherModel * model = _dataArr[0];
    model.iselect = YES;
    [_tableV reloadData];
    
}
@end
