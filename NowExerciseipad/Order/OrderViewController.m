//
//  OrderViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderViewController.h"

#import "DetailOrderViewController.h"
#import "OrderModel.h"
#import "OrderCell.h"

#import "DetailOrderViewController.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,Orderdelegate>
{
    UIView * backgroundV;
    
}
@property (nonatomic , strong) NSMutableArray * newdataArr;
@property (nonatomic , strong) NSMutableArray * dataArr;



@property (nonatomic , assign) BOOL islook;

@property (nonatomic , strong) DetailOrderViewController * detailOrderVC;

@end

@implementation OrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 添加屏幕通知
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    _islook = YES;
    
    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailorderdismiss) name:@"detailorderdismiss" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushneworder:) name:@"neworder" object:nil];
    
    self.view.backgroundColor = WINDOW_backgroundColor;
    
    [self reloadUI];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)reloadUI{

    backgroundV = [[UIView alloc]init];
    
    backgroundV.backgroundColor = WINDOW_backgroundColor;
    [self.view addSubview:backgroundV];
    
    
    _OrdertableV = [[UITableView alloc]init];
    _OrdertableV.delegate = self;
    _OrdertableV.dataSource = self;
    _OrdertableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJRefreshStateHeader * header = [MJRefreshStateHeader headerWithRefreshingTarget:self  refreshingAction:@selector(refreshData)];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    _OrdertableV.mj_header = header;
    
    [_OrdertableV registerClass:[OrderCell class] forCellReuseIdentifier:@"cellID"];
    
    _OrdertableV.backgroundColor = WINDOW_backgroundColor;
    
    _dataArr = [NSMutableArray array];
    _newdataArr = [NSMutableArray array];
    
    [backgroundV addSubview:_OrdertableV];
    
    [self createUI];
    [self loaddata];
    
    
}
#pragma mark 刷新数据
- (void)refreshData{
    
    [self loaddata];
    
}
#pragma mark 加载数据
- (void)loaddata{
//    _dataArr = nil;
//    _newdataArr = ni
    [_dataArr removeAllObjects];
    [_newdataArr removeAllObjects];
    
    NSString * url = [NSString stringWithFormat:@"%@%@",BASEURL,@"pad/?method=coach.order"];
    NSLog(@"%@",url);
    
    [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id data) {
       // NSLog(@"订单数据:%@",data);
       // NSLog(@"%@",[data class]);
        
        if (data) {
                NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"rc"] integerValue] == 0) {
                
                NSDictionary * datadic = dict[@"data"];
                //新订单字典
                NSDictionary * newdic = datadic[@"new_order"];
                
                //数据
                NSArray * neworderarr = newdic[@"info"];
                
                for (NSDictionary * dic in neworderarr) {
                    OrderModel * model = [[OrderModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.newOrder = YES;
                    [_newdataArr addObject:model];
                }
                
                NSArray * orderarr = datadic[@"order"];
                
                for (NSDictionary * dic in orderarr) {
                    OrderModel * model = [[OrderModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.newOrder = NO;
                    
                    [_dataArr addObject:model];
                   
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_OrdertableV.mj_header endRefreshing];
                    [_OrdertableV reloadData];
                    
                    NSString * str = [NSString stringWithFormat:@"%ld",(unsigned long)_newdataArr.count];
                    NSLog(@"新订单数量为:%@",str);
                    NSString * leth = [NSString stringWithFormat:@"%@",newdic[@"length"]];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushmessage" object:nil userInfo:@{@"number":leth}];
                    [UIApplication sharedApplication].applicationIconBadgeNumber = _newdataArr.count;
                    
                });
                
            }else{
                
                UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"加载异常" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertC addAction:action];
                
                [self presentViewController:alertC animated:YES completion:nil];
   
            }
        }
        
        
    } andfailBlock:^(NSError *error) {
        
        [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
    }];
    
}
#pragma Mark masonry布局
- (void)createUI{
    
    if (ISSHUPING) {
        
        [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L / 3.0);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        
    }else{
        
        [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        

    }
    
    [_OrdertableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        
    }];
    
    
}

#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    if (ISSHUPING) {
        if (_islook) {
            [backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
            
        }else{
            [backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
            
            
        }else{
            [backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
            
        }
     
    }
 
}
- (void)menunoti:(NSNotification *)noti{
    
    NSString * Info = [noti.userInfo valueForKey:@"1"];
    
    if ([Info isEqualToString:@"出现"]) {
        
        _islook = YES;
        
        [self handleDeviceOrientationDidChange:[[UIApplication sharedApplication] statusBarOrientation]];
        
    }else if([Info isEqualToString:@"消失"]){
        
        _islook = NO;
        
        [self handleDeviceOrientationDidChange:[[UIApplication sharedApplication] statusBarOrientation]];
    
    }
    
    
}

#pragma mark 新订单通知
- (void)pushneworder:(NSNotification *)noti{
    
    [self loaddata];
}

#pragma mark tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _newdataArr.count;
    }else
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell * cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (_newdataArr.count != 0) {
            OrderModel * model = _newdataArr[indexPath.row];
            [cell createCellWithmodel:model];
            cell.delegate = self;
            
        }
    }else{
    
    if (_dataArr.count != 0) {
        OrderModel * model = _dataArr[indexPath.row];
        
        [cell createCellWithmodel:model];
    }
    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 250;
    }
    return 175;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else{
        
        OrderModel * model = _dataArr[indexPath.row];
        _detailOrderVC = [[DetailOrderViewController alloc]init];
        
        _detailOrderVC.orderID = model.order_id;
        _detailOrderVC.isopen = _islook;

        _detailOrderVC.isdone = model.Process;
        
        [_detailOrderVC createview];
        [_detailOrderVC postgoBtnStatus];
        [_detailOrderVC createUpdataBtn];
        [_detailOrderVC ispersonal];
//        if (model.personal_id) {
//            _detailOrderVC.personal_id = model.personal_id;
//        }else{
//            [_detailOrderVC nothavepersonal];
//
//        }
        [backgroundV addSubview:_detailOrderVC];
        [_detailOrderVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        _detailOrderVC.detailBlock = ^(void){
            model.Process = YES;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        };
    
    }
    
}

#pragma mark 订单处理代理方法
- (void)OrderprocessingWithModel:(OrderModel *)model andBool:(BOOL)Can{
    __weak typeof (self) weakSelf = self;

    if (Can) {
        NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.accept_order&order_id=%@",BASEURL,model.order_id];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            if (data && [dic[@"rc"] integerValue] == 0) {
                
                [HttpRequest showAlertCatController:self andmessage:@"接单成功"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf loaddata];
                    
                    _detailOrderVC = [[DetailOrderViewController alloc]init];
                    
                    _detailOrderVC.orderID = model.order_id;
                    _detailOrderVC.isopen = _islook;
                    
                    _detailOrderVC.isdone = model.Process;
                    [_detailOrderVC createview];
                    [_detailOrderVC postgoBtnStatus];
                    [_detailOrderVC createUpdataBtn];

                    [backgroundV addSubview:_detailOrderVC];
                    [_detailOrderVC mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.offset(0);
                    }];
                });
                
            }else{
                [HttpRequest showAlertCatController:self andmessage:dic[@"msg"]];
                
            }
        } andfailBlock:^(NSError *error) {
            [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];

        }];
        
        
    }else{
        NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.refused_order&order_id=%@",BASEURL,model.order_id];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            if (data && [dic[@"rc"] integerValue] == 0) {
                
                [HttpRequest showAlertCatController:self andmessage:@"拒单成功"];
                [self loaddata];
            }else{
                [HttpRequest showAlertCatController:self andmessage:dic[@"msg"]];
            }
        } andfailBlock:^(NSError *error) {
            [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
        }];
    }
}


#pragma mark 移除订单详情
- (void)detailorderdismiss{
    if (_detailOrderVC){
    [_detailOrderVC removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanxiang" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"detailorderdismiss" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"neworder" object:nil];
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
