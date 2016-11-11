//
//  NotesView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "NotesView.h"
#import "NotesModel.h"
#import "AddNotesModel.h"

#import "AddNotesCell.h"
#import "NotesCell.h"


@interface NotesView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    NSString * url;
}


@end


@implementation NotesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        dataArr = [NSMutableArray array];
        tableV = [[UITableView alloc]init];
        tableV.dataSource = self;
        tableV.delegate = self;
        [tableV registerNib:[UINib nibWithNibName:@"AddNotesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ADD"];
        [tableV registerNib:[UINib nibWithNibName:@"NotesCell" bundle:nil] forCellReuseIdentifier:@"NOTES"];
        
        [self addSubview:tableV];
        [self createRect];
        [self seturlwithtype:1 filtertype:@"all" teacherID:0 filterID:0];
        
    }
    return self;
}

- (void)createRect{
    
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.and.top.offset(0);
    }];
}

- (void)seturlwithtype:(NSInteger)type filtertype:(NSString *)filtertype teacherID:(NSInteger)teacherID filterID:(NSInteger)fileterID {
    
    NSString * surl = [NSString stringWithFormat:@"%@pad/?method=train.search_recard&type=%ld&coach_id=%ld&filter_type=%@&filter_id=%ld",TESTBASEURL,(long)type,(long)teacherID,filtertype,(long)fileterID];
    
    url = surl;
    [self reloadData];

}

- (void)reloadData{
    
    [dataArr removeAllObjects];
    AddNotesModel * model = [[AddNotesModel alloc]init];
    model.result = 0;
    [dataArr addObject:model];
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSLog(@"%@",data);
        if (data && [data[@"rc"] integerValue]== 0) {
            NSArray * datarr = data[@"data"];
            for (NSDictionary * dic in datarr) {
                NotesModel * model = [[NotesModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
                
            });
            
        }else{
            NSLog(@"数据异常");
        }
        
    } andfailBlock:^(NSError *error) {
        NSLog(@"加载失败");
    }];
    
}
#pragma mark tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",dataArr.count);
    
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    if (dataArr.count > 0) {
   
        if (indexPath.row == 0) {
            AddNotesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ADD"];
            cell.selectionStyle = UIAccessibilityTraitNone;
            [cell createCellWithModel:dataArr[indexPath.row]];
            return cell;
    
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"NOTES"];
          
    
        return cell;
    }
    }
       return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 460;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}







@end
