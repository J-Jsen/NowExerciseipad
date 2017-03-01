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

@interface NotesView()<UITableViewDelegate,UITableViewDataSource,AddNotesCellDelegate>
{

    NSString * url;
    NSInteger studentID;
    
}
@property (nonatomic , strong) NSMutableArray * dataArr;
@property (nonatomic , strong) UITableView * tableV;
@end


@implementation NotesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWith{
    if (self = [super init]) {
        
    }
    return self;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(seturlWithInfo:) name:@"jiaolian" object:nil];

        _dataArr = [[NSMutableArray alloc]init];
        _tableV = [[UITableView alloc]init];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.backgroundColor = WINDOW_backgroundColor;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableV registerNib:[UINib nibWithNibName:@"AddNotesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ADD"];
        [_tableV registerNib:[UINib nibWithNibName:@"NotesCell" bundle:nil] forCellReuseIdentifier:@"NOTES"];

        
        [self addSubview:_tableV];
        [self createRect];
        studentID = 1001;
        [self seturlwithteacherID:1001];
        
    }
    return self;
}

- (void)seturlWithInfo:(NSNotification *)info{
    NSLog(@"收到了通知");
    NSInteger uid = [[info.userInfo valueForKey:@"uid"] integerValue];
    studentID = uid;
    
    [self seturlwithteacherID:uid];
}
- (void)createRect{
    
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.and.top.offset(0);
    }];
}

- (void)seturlwithteacherID:(NSInteger)teacherID{
    
    NSString * surl = [NSString stringWithFormat:@"%@pad/?method=train.search_recard&type=2&coach_id=%ld&filter_type=all&filter_id=0",BASEURL,(long)teacherID];
    
    url = surl;
    
    [self reloadData];

}

- (void)reloadData{
    //__weak __typeof__(self) weakSelf = self;

    [_dataArr removeAllObjects];

    NSString * Durl = [NSString stringWithFormat:@"%@pad/?method=train.framework",BASEURL];
    [HttpRequest PostHttpwithUrl:Durl andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            
            AddNotesModel * model1 = [[AddNotesModel alloc]init];
            
            model1.result = 0;
            model1.dataArr  = dic[@"data"];
            NSDictionary * dic = model1.dataArr[0];
            model1.classID = [dic[@"subtitel"][0][@"id"] integerValue];
            
            model1.jieduan = [dic valueForKey:@"name"];
            model1.dayL = [dic[@"subtitel"][0] valueForKey:@"name"];
            model1.name = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
            
            [_dataArr setObject:model1 atIndexedSubscript:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableV reloadData];
            });
            //NSLog(@"changdu : %ld",_dataArr.count);
        }else{
            NSLog(@"大纲加载失败");
        }
    } andfailBlock:^(NSError *error) {
        NSLog(@"服务器异常");
        
    }];
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue]== 0) {
            NSArray * datarr = dic[@"data"];
            for (NSDictionary * dic in datarr) {
                NotesModel * model = [[NotesModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"%ld",_dataArr.count);
                [_tableV reloadData];
                
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

    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    if (_dataArr.count > 0) {
   
        if (indexPath.row == 0) {
            AddNotesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ADD" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell createCellWithModel:_dataArr[indexPath.row]];
            cell.delegate = self;
            return cell;
    
    }else{
        NotesCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"NOTES"];
        NotesModel * model = _dataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell createCellWithModel:model];
        cell.userInteractionEnabled = NO;
        
    
        return cell;
    }
    }
       return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
    return 490;
    }
    return 400;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)AddBtnclick:(AddNotesModel *)model{
    
//    NSUserDefaults * defults = [NSUserDefaults standardUserDefaults];
//    NSString * username = [defults valueForKey:@"username"];
    

    
    if (![model.name isEqualToString:@""]) {
    NSString * username = model.name;
    //NSLog(@"username:%@",username);
    NSInteger interval = [[NSDate date] timeIntervalSince1970];
    
    username = [username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        
        NSString * beizhu;
        if ([model.beizhu isEqualToString:@""]) {
            beizhu = @"";
        }else{
            beizhu = [model.beizhu stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        }
        NSString * fankui;
        if ([model.fankui isEqualToString:@""]) {
            fankui = @"";
        }else{
        fankui = [model.fankui stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        }
        NSString * qingkuang;
        if ([model.qingkuang isEqualToString:@""]) {
            qingkuang = @"";
        }else{
            qingkuang = [model.qingkuang stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]];
        }
    NSString * updataurl = [NSString stringWithFormat:@"%@pad/?method=train.recard&content_id=%ld&coach_id=%ld&training_coach=%@&remark=%@&result=%ld&feedback=%@&progress=%@&time=%ld",BASEURL,(long)model.classID,(long)studentID,username,beizhu,(long)model.result,fankui,qingkuang,interval];
//    NSInteger  ina = time(NULL);
    
    [HttpRequest PostHttpwithUrl:updataurl andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"保存成功"];
            [self reloadData];
            
        }else{
            [HttpRequest showAlertCatController:self.window.rootViewController andmessage:dic[@"msg"]];
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"服务器开小差了,请稍后尝试..."];
        
    }];
    NSLog(@"%@\n %@\n %ld",model.fankui,model.beizhu,(long)model.classID);
    }else{
        [HttpRequest showAlertCatController:self.window.rootViewController andmessage:@"培训人不能为空"];
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"jiaolian" object:nil];
    
}



@end
