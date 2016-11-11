//
//  DetailView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "DetailView.h"
#import "trainModel.h"
#import "detailModel.h"
#import "detailCell.h"
@interface DetailView()<UITableViewDelegate,UITableViewDataSource,movedelegate>

Arrayproperty(dataArr)


@end

@implementation DetailView


-(instancetype)init{
    if (self = [super init]) {
        _dataArr = [NSMutableArray array];
        
        _tableV = [[UITableView alloc]init];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.backgroundColor = WINDOW_backgroundColor;
        [_tableV setSeparatorColor:[UIColor clearColor]];
        
        [_tableV registerClass:[detailCell class] forCellReuseIdentifier:@"detailID"];
        
        _moveV = [[moveView alloc]init];
        _moveV.delegate = self;
        
        [self addSubview:_tableV];
        [self addSubview:_moveV];
        
        [self updata];
        
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.bottom.offset(0);
            make.right.offset(-100);
            
        }];
        [_moveV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.top.and.bottom.offset(0);
            make.width.mas_equalTo(100);
            
        }];
    }
    return self;
}
- (void)updata{
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=train.all_content",TESTBASEURL];
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        if (data && [data[@"rc"] integerValue] == 0) {
            NSArray * datarr = data[@"data"];
//            NSLog(@"%@",data);
            for (NSDictionary * dic in datarr) {
                NSMutableArray * subtitleArr = [NSMutableArray array];

                NSArray * subArr = dic[@"subtitel"];
                for (NSDictionary * dic in subArr) {
                    detailModel * model = [[detailModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    CGRect r = [model.content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"ArialUnicodeMS" size:17.1]} context:nil];
                    model.label_heiht = r.size.height + 46;

                    [subtitleArr addObject:model];
                    
                }
                trainModel * t_model = [[trainModel alloc]init];
                t_model.framework_id = [dic[@"framework_id"] integerValue];
                t_model.name = dic[@"name"];
                t_model.subtitel = subtitleArr;
                t_model.Description = dic[@"description"];
                
                [_dataArr addObject:t_model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableV reloadData];

            });
            
        }else{
            [_delegate showAlertWithmessage:@"加载失败"];
            
        }
    } andfailBlock:^(NSError *error) {
        [_delegate showAlertWithmessage:@"网络开小差了"];
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    trainModel * model = _dataArr[section];
    
    return model.subtitel.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detailCell * cell = [[detailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailID"];
    if (_dataArr) {
    
    trainModel * t_model = _dataArr[indexPath.section];
    detailModel * model = t_model.subtitel[indexPath.row];
    
    [cell createCellWithModel:model andTitle:t_model.name];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    trainModel * tmodel = _dataArr[indexPath.section];
    NSArray * arr = tmodel.subtitel;
    detailModel * model = arr[indexPath.row];
    
    return model.label_heiht;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)showAlertWithString:(NSString *)str{
    
    [self.delegate showAlertWithmessage:str];
    
}
- (void)moveCellToplace:(NSIndexPath *)indexpath{
    CGRect rectInTableView = [_tableV rectForRowAtIndexPath:indexpath];
    [_tableV setContentOffset:CGPointMake(0, rectInTableView.origin.y ) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
