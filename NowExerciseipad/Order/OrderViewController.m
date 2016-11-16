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

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)  UITableView * OrdertableV;
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
    self.view.backgroundColor = [UIColor yellowColor];

    [self reloadUI];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)reloadUI{

    _OrdertableV = [[UITableView alloc]init];
    _OrdertableV.delegate = self;
    _OrdertableV.dataSource = self;
    
    [_OrdertableV registerClass:[OrderCell class] forCellReuseIdentifier:@"cellID"];
    
    _OrdertableV.backgroundColor = [UIColor redColor];
    _dataArr = [NSMutableArray array];
    _newdataArr = [NSMutableArray array];
    

    [self.view addSubview:_OrdertableV];
    
    [self createUI];
     [self loaddata];
    
    
}
#pragma mark 加载数据
- (void)loaddata{
    
    [_dataArr removeAllObjects];
    [_newdataArr removeAllObjects];
    
    
    NSString * url = [NSString stringWithFormat:@"%@%@",BASEURL,@"pad/?method=coach.order"];
    NSLog(@"%@",url);
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        if (data) {
                NSDictionary * dict = data;
            if ([dict[@"rc"] integerValue] == 0) {
                
                NSDictionary * datadic = dict[@"data"];
                //新订单字典
                NSDictionary * newdic = datadic[@"new_order"];
                
                //数据
                NSArray * neworderarr = newdic[@"orders"];
                for (NSDictionary * dic in neworderarr) {
                    OrderModel * model = [[OrderModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.newOrder = YES;
                    
                }
                
                NSArray * orderarr = datadic[@"order"];
                
                for (NSDictionary * dic in orderarr) {
                    OrderModel * model = [[OrderModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.newOrder = NO;
                    
                    [_dataArr addObject:model];
                   
                }
                [_OrdertableV reloadData];
                
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
        
        [_OrdertableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L / 3.0);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        
    }else{
        
        [_OrdertableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        

    }
    
    
    
}

#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    if (ISSHUPING) {
        if (_islook) {
            [_OrdertableV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
            
        }else{
            [_OrdertableV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [_OrdertableV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
            
            
        }else{
            [_OrdertableV mas_updateConstraints:^(MASConstraintMaker *make) {
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
    
    return 155;
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
        [self.view addSubview:_detailOrderVC.view];
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
