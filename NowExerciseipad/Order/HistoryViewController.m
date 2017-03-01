//
//  HistoryViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/12/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryModel.h"
#import "HistoryCell.h"
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableV;
    NSMutableArray * dataArr;
    
    
}
@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = LEFTBTN_BACKGROUNDCOLOR;
    //取消透明色
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"历史记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    dataArr = [NSMutableArray array];
    
    tableV = [[UITableView alloc]init];
    tableV.separatorColor = [UIColor orangeColor];
    tableV.backgroundColor = WINDOW_backgroundColor;
    
    //[tableV registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"HistoryCell"];
    [tableV registerClass:[HistoryCell class] forCellReuseIdentifier:@"HistoryCell"];
    tableV.dataSource = self;
    tableV.delegate = self;
    [self.view addSubview:tableV];
    
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self loadData];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)loadData{
    
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.recard_list&order_id=%@",BASEURL,_orderID];
    //NSLog(@"历史记录:%@",url);
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id data) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"rc"] integerValue] == 0) {
           // NSLog(@"历史记录:%@",dict);
            CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width - 90;
            UIFont * font = [UIFont systemFontOfSize:17];
            
            NSArray * arr = dict[@"data"];
            for (NSDictionary * dic in arr) {
                HistoryModel * model = [[HistoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                CGFloat AllHight = 143;
                
                NSArray * array = dic[@"recard_remark"];
                for (NSDictionary * dic in array) {
                    NSInteger title_id = [dic[@"title_id"] integerValue];
                    NSString * Str = [NSString stringWithFormat:@"%@:%@",dic[@"title"],dic[@"content"]];
                    
                    switch (title_id) {
                        case 1:
                        {//疾病及伤痛注意事项
                            model.JibingL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height + 5;
                            AllHight = AllHight + model.JibingL + 20;
                        }
                            break;
                        case 3:
                        {//会员运动喜好及满意部分
                            model.ManyibufenL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.ManyibufenL + 20;

                        }
                            break;
                        case 4:
                        {//运动禁忌
                            model.JinjiL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.JinjiL + 20;

                        }
                            break;
                        case 5:
                        {//运动内容及强度建议
                            model.JianyiL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.JianyiL + 20;

                        }
                            break;
                        case 6:
                        {//饮食建议
                            model.YinshiL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.JibingL + 20;

                        }
                            break;
                        case 7:
                        {//下位教练需注意
                            model.NextZhuyiL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.NextZhuyiL + 20;

                        }
                            break;
                        case 8:
                        {//会员担忧及问题
                            model.DanyouL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.DanyouL + 20;

                        }
                            break;
                        case 9:
                        {//会员变化
                            model.BianhuaL = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.BianhuaL + 20;

                        }
                            break;
                        case 10:
                        {//备注
                            model.Beizhu = [HttpRequest sizeWithText:Str font:font maxWidth:viewWidth].height+ 5;
                            AllHight = AllHight + model.Beizhu + 20;

                        }
                            break;
           
                        default:
                            break;
                    }
                }
                model.AllHeight = AllHight;
                
                [dataArr addObject:model];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
                
            });
            
            
        }else{
            
            [HttpRequest showAlertCatController:self andmessage:dict[@"msg"]];
        }
        
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
        
    }];
}

#pragma mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",dataArr.count);
    
    return dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell * cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
    cell.userInteractionEnabled = NO;
    if (dataArr.count > 0) {
        HistoryModel * model = dataArr[indexPath.row];
        [cell createCellWithModel:model];
    }
    
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryModel * model = dataArr[indexPath.row];
    
    return model.AllHeight;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
