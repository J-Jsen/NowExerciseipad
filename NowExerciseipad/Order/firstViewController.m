//
//  firstViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/11/2.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "firstViewController.h"

#import "WenjuanModel.h"
#import "WenDaModel.h"
#import "XuanZeModel.h"

#import "BaseTableViewCell.h"
#import "LifeTableViewCell.h"
#import "EatTableViewCell.h"
#import "BordyTableViewCell.h"
#import "HealthTableViewCell.h"
#import "GuoDongTableViewCell.h"

@interface firstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) WenjuanModel * wenjuanmodel;

@property (nonatomic , strong) UITableView * tableV;

@end

@implementation firstViewController
{
    BOOL isOK;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
  
    _tableV = [[UITableView alloc]init];
    _tableV.dataSource = self;
    _tableV.delegate = self;
    
    _tableV.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableV];
    [self createUI];
    
    [_tableV registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"BASE"];
    [_tableV registerClass:[LifeTableViewCell class] forCellReuseIdentifier:@"LIFE"];
    [_tableV registerClass:[EatTableViewCell class] forCellReuseIdentifier:@"EAT"];
    [_tableV registerClass:[BordyTableViewCell class] forCellReuseIdentifier:@"BORDY"];
    [_tableV registerClass:[HealthTableViewCell class] forCellReuseIdentifier:@"HEALTH"];
    [_tableV registerClass:[GuoDongTableViewCell class] forCellReuseIdentifier:@"GUODONG"];
    
    [self reloadData];
    
}

- (void)createUI{
    
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.offset(0);
        
    }];
    
    
}

- (void)reloadData{
    
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=questions.questions&order_id=%@&que_type=2",TESTBASEURL,_order_id];
    NSLog(@"************************************************************%@",url);
    
   [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
           
        if (data && [data[@"rc"] integerValue] == 0) {
           NSDictionary * datadic = data[@"data"];
            _wenjuanmodel = [[WenjuanModel alloc]init];
            _wenjuanmodel.introduce = datadic[@"introduce"];
            _wenjuanmodel.title = datadic[@"title"];
            
            //分类问题
            NSDictionary * quesDic = datadic[@"all_ques"];
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

            NSDictionary * basedic = quesDic[@"1"];
            _wenjuanmodel.Base = [[NSMutableDictionary alloc]init];
            
            [self updata:basedic tomodeldic:_wenjuanmodel.Base andnumber:1 to:9 andothernumber:0];
            
            NSLog(@"基本资料%@",_wenjuanmodel.Base);
    
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

            NSDictionary * lifedic = quesDic[@"2"];
            NSLog(@"生活习惯%@",lifedic);
            _wenjuanmodel.Life = [[NSMutableDictionary alloc]init];
            
            [self updata:lifedic tomodeldic:_wenjuanmodel.Life andnumber:10 to:16 andothernumber:51];
            
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
            
            NSDictionary * eatdic = quesDic[@"3"];
            NSLog(@"饮食:%@",eatdic);
            _wenjuanmodel.Eat = [[NSMutableDictionary alloc]init];
            [self updata:eatdic tomodeldic:_wenjuanmodel.Eat andnumber:17 to:24 andothernumber:50];

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
            
            NSDictionary * bordydic = quesDic[@"4"];
            NSLog(@"健身经理%@",bordydic);
            _wenjuanmodel.Bordy = [[NSMutableDictionary alloc]init];
            [self updata:bordydic tomodeldic:_wenjuanmodel.Bordy andnumber:25 to:29 andothernumber:49];
            
            
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
            
            NSDictionary * healthdic = quesDic[@"5"];
            NSLog(@"健康状况%@",healthdic);
            _wenjuanmodel.Health = [[NSMutableDictionary alloc]init];
            [self updata:healthdic tomodeldic:_wenjuanmodel.Health andnumber:30 to:33 andothernumber:48];
            
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
            
            NSDictionary * guodongdic = quesDic[@"6"];
            NSLog(@"果动瑜伽%@",guodongdic);
            _wenjuanmodel.Guodong = [[NSMutableDictionary alloc]init];
            [self updata:guodongdic tomodeldic:_wenjuanmodel.Guodong andnumber:34 to:47 andothernumber:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isOK = YES;
                [_tableV reloadData];
                NSLog(@"刷新了");
                
            });
            
            
        }else{
            
            [HttpRequest showAlertCatController:self andmessage:@"数据异常"];
        
        }
    } andfailBlock:^(NSError *error) {
        
        [HttpRequest showAlertCatController:self andmessage:@"加载失败"];

        
    }];
    
    
    
}

#pragma mark 存model
- (void)updata:(NSDictionary *)datadic tomodeldic:(NSMutableDictionary *)dic andnumber:(int)a to:(int)b andothernumber:(int)other{
    
    NSLog(@"%@",[datadic valueForKey:@"name"]);
    
    [dic setValue:[datadic valueForKey:@"name"] forKey:@"name"];
    
    [dic setValue:[datadic valueForKey:@"model"] forKey:@"model"];

    for (int i = a; i < b + 1; i ++) {
        NSString * number = [NSString stringWithFormat:@"%d",i];
        NSDictionary * quesD = datadic[number];
        if (quesD[@"issur_type"]) {
            if ([quesD[@"issue_type"] integerValue] == 1) {
                XuanZeModel * model = [[XuanZeModel alloc]init];
                [model setValuesForKeysWithDictionary:quesD];
                [dic setValue:model forKey:number];
            }else{
                WenDaModel * model = [[WenDaModel alloc]init];
                [model setValuesForKeysWithDictionary:quesD];
                [dic setValue:model forKey:number];
            }
        }
        
    }
    
    if (other) {
        
        NSDictionary * dic51 = datadic[[NSString stringWithFormat:@"%d",other]];
        
        WenDaModel * model51 = [[WenDaModel alloc]init];
        
        [model51 setValuesForKeysWithDictionary:dic51];
        
        [dic setValue:model51 forKey:[NSString stringWithFormat:@"%d",other]];

    }
    
    
    
    
    
    
}
#pragma mark tablev协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_wenjuanmodel) {
        return 6;
        
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    
    if (_wenjuanmodel) {
        switch (indexPath.row) {
            case 0:
            {
                BaseTableViewCell * cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BASE"];
                [cell creatCellWithdata:_wenjuanmodel.Base];
                NSLog(@"刷新数据%@",_wenjuanmodel.Base);
                
                return cell;

            }
                break;
            case 1:
            {
                LifeTableViewCell * cell = [[LifeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LIFE"];
                
                return cell;
                
            }
                break;
            case 2:
            {
                EatTableViewCell * cell = [[EatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EAT"];
                
                return cell;
                
            }
                break;
            case 3:
            {
                BordyTableViewCell * cell = [[BordyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BORDY"];
                
                return cell;
            }
                break;
            case 4:
            {
                HealthTableViewCell * cell = [[HealthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HEALTH"];
                
                return cell;
                
            }
                break;
            case 5:
            {
                GuoDongTableViewCell * cell = [[GuoDongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GUODONG"];
                
                return cell;
                
            }
                break;
            default:
                
                break;
        }
        
        
    
    }
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 300.0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
//    
//}
//
//- (BOOL)shouldAutorotate{
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
