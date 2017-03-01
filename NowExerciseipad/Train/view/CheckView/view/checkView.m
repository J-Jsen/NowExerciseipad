//
//  checkView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "checkView.h"
#import "checkCell.h"
#import "AddcheckCell.h"
#import "checkModel.h"


@interface checkView()<UITableViewDelegate , UITableViewDataSource,AddcheckDelegate>
{
    NSMutableArray * dataArr;
    UITableView * tableV;
    
    NSString * coachID;
    NSString * url;
    
    
}


@end

@implementation checkView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = WINDOW_backgroundColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(seturlWithInfo:) name:@"jiaolian" object:nil];

        dataArr = [NSMutableArray array];
        tableV = [[UITableView alloc]init];
        [tableV registerNib:[UINib nibWithNibName:@"AddcheckCell" bundle:nil] forCellReuseIdentifier:@"AddcheckCELL"];
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
        [tableV registerNib:[UINib nibWithNibName:@"checkCell" bundle:nil] forCellReuseIdentifier:@"checkCELL"];
        tableV.dataSource = self;
        tableV.delegate = self;
        tableV.backgroundColor = WINDOW_backgroundColor;
        
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableV];
        
        [self createUI];
        coachID = @"1001";
        [self setUrlWithcoachID:coachID];
        
    }
    return self;
}
#pragma mark 加载数据
- (void)loaddata{
    [dataArr removeAllObjects];
    
    NSString * Durl = [NSString stringWithFormat:@"%@pad/?method=train.framework",BASEURL];
    [HttpRequest PostHttpwithUrl:Durl andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSLog(@"数据为:%@",data);
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            
            checkModel * model1 = [[checkModel alloc]init];
            model1.leiixng = @"1";
            model1.result = @"优";
            model1.leiixng = @"入职";
            NSDate * date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateStr = [dateFormatter stringFromDate: date];
            model1.time = currentDateStr;
            
            model1.dataArr  = dic[@"data"];
        
            model1.classID = [model1.dataArr[0] valueForKey:@"framework_id"];
            model1.jieduan = [model1.dataArr[0] valueForKey:@"name"];
            
            [dataArr setObject:model1 atIndexedSubscript:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            //NSLog(@"changdu : %ld",dataArr.count);
        }else{
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:dic[@"msg"]];
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"服务器开小差了"];
    }];
    
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            NSArray * arr = dic[@"data"];
            for (NSDictionary * dic in arr) {
                checkModel * model = [[checkModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            
        }else{
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:dic[@"msg"]];

        }
    } andfailBlock:^(NSError *error) {
        
        [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"服务器开小差了"];

        
    }];
    
    
}
#pragma mark 接收到了通知
- (void)seturlWithInfo:(NSNotification *)info{
    NSLog(@"收到了通知");
    coachID = [info.userInfo valueForKey:@"uid"];
    [self setUrlWithcoachID:coachID];
}
#pragma mark 保存代理方法
- (void)savedataWithModel:(checkModel *)model{
    //课程id
    NSString * classID = model.classID;
    NSString * beizhu;
    if (model.remark) {
        //备注
        beizhu = [model.remark stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        
    }else{
        beizhu = @"";
        
    }

    //结果
    NSString * result;
    if ([model.result isEqualToString:@"优"]) {
        result = @"1";
    }else if ([model.result isEqualToString:@"良"]){
        result = @"2";
    }else if ([model.result isEqualToString:@"中"]){
        result = @"3";
    }else if ([model.result isEqualToString:@"差"]){
        result = @"4";
    }
    //监考人
    NSString * teacher = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    teacher = [teacher stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
    //时间
    NSString * time;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * date = [formatter dateFromString:model.time];
    time = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    
    //类型
    NSString * type;
    if ([model.leiixng isEqualToString:@"入职"]) {
        type = @"1";
    }else{
        type = @"2";
    }
    
    NSString * saveurl = [NSString stringWithFormat:@"%@pad/?method=train.examine&framework_id=%@&coach_id=%@&remark=%@&result=%@&invigilation=%@&time=%@&types=%@",BASEURL,classID,coachID,beizhu,result,teacher,time,type];
    NSLog(@"保存的url:%@",saveurl);
    
    __weak typeof (self) weakSelf = self;

    [HttpRequest PostHttpwithUrl:saveurl andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"data"] integerValue] == 0) {
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"保存成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf loaddata];
            });
        }else{
            
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:dic[@"msg"]];
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"服务器开小差了"];
    }];
    
}

#pragma mark 设置url
- (void)setUrlWithcoachID:(NSString *)coachid{
    
    url = [NSString stringWithFormat:@"%@pad/?method=train.examine_recard&type=2&coach_id=%@&filter_type=all&filter_id=1",BASEURL,coachid];
    [self loaddata];
    
}
- (void)createUI{
    
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        
    }];
    
}
#pragma mark tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (dataArr.count > 0) {
        if (indexPath.row == 0) {
            AddcheckCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddcheckCELL"];
            cell.delegate = self;
            [cell createCellWithModel:dataArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            checkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"checkCELL"];
            
            [cell createCellWithModel:dataArr[indexPath.row]];
            cell.userInteractionEnabled = NO;
            return cell;
        }
        
        
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
    return 315;
    }
    return 230;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
