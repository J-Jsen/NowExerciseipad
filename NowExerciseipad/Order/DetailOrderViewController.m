//
//  DetailOrderViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "DetailOrderViewController.h"

#import "GoButton.h"
#import "firstViewController.h"

@interface DetailOrderViewController ()

@property (nonatomic , strong) UIView * backgroundV;
@property (nonatomic , strong) GoButton * GoBtn;
@property (nonatomic , strong) UILabel * statusLabel;

@property (nonatomic , strong) UIButton * firstBtn;
@property (nonatomic , strong) UILabel * firstLabel;

@property (nonatomic , strong) UIButton * bordytestBtn;
@property (nonatomic , strong) UILabel * bordytestLabel;

@property (nonatomic , strong) UIButton * personBtn;
@property (nonatomic , strong) UILabel * personLabel;

@property (nonatomic , strong) UIButton * trainBtn;
@property (nonatomic , strong) UILabel * trainLabel;

@property (nonatomic , strong) UIButton * chargebackBtn;

@property (nonatomic , strong) UIButton * updataBtn;

@property (nonatomic , assign) NSInteger  status;

@property (nonatomic , strong) NSString * method;

@property (nonatomic , strong) NSString * statusLabeltxt;
@end

@implementation DetailOrderViewController

-(instancetype)init{
    
    if (self = [super init]) {

        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];

    self.view.backgroundColor = [UIColor yellowColor];
   
    [self postgoBtnStatus];

    _backgroundV = [[UIView alloc]init];
    _backgroundV.backgroundColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
    
    [self.view addSubview:_backgroundV];
    self.view.backgroundColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
    
    _GoBtn = [[GoButton alloc]init];
    _statusLabel = [[UILabel alloc]init];
    
    _firstBtn = [[UIButton alloc]init];
    _firstLabel = [[UILabel alloc]init];
    
    _bordytestBtn = [[UIButton alloc]init];
    _bordytestLabel = [[UILabel alloc]init];
    
    _personBtn = [[UIButton alloc]init];
    _personLabel = [[UILabel alloc]init];
    
    _trainBtn = [[UIButton alloc]init];
    _trainLabel = [[UILabel alloc]init];
    
    _chargebackBtn = [[UIButton alloc]init];
    
    _updataBtn = [[UIButton alloc]init];
    
    [_backgroundV addSubview:_statusLabel];
    
    
    [_firstBtn addTarget:self action:@selector(questionnaireClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bordytestBtn addTarget:self action:@selector(BordyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_personBtn addTarget:self action:@selector(personBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_trainBtn addTarget:self action:@selector(trainBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [_backgroundV addSubview:_firstLabel];
    [_backgroundV addSubview:_firstBtn];
    [_backgroundV addSubview:_bordytestBtn];
    [_backgroundV addSubview:_bordytestLabel];
    [_backgroundV addSubview:_personBtn];
    [_backgroundV addSubview:_personLabel];
    [_backgroundV addSubview:_trainBtn];
    [_backgroundV addSubview:_trainLabel];
    [_backgroundV addSubview:_updataBtn];
    [_backgroundV addSubview:_chargebackBtn];

    [_firstBtn setImage:[UIImage imageNamed:@"16.png"] forState:UIControlStateNormal];
    _firstLabel.text = @"首次问卷";
    _firstLabel.textColor = [UIColor whiteColor];
    
    [_bordytestBtn setImage:[UIImage imageNamed:@"17.png"] forState:UIControlStateNormal];
    _bordytestLabel.text = @"身体测试";
    _bordytestLabel.textColor = [UIColor whiteColor];
    
    [_personBtn setImage:[UIImage imageNamed:@"18.png"] forState:UIControlStateNormal];
    _personLabel.text = @"私人订制";
    _personLabel.textColor = [UIColor whiteColor];
    
    [_trainBtn setImage:[UIImage imageNamed:@"19.png"] forState:UIControlStateNormal];
    _trainLabel.text = @"教练交接";
    _trainLabel.textColor = [UIColor whiteColor];
    
  
    [_updataBtn setTitle:@"上传" forState:UIControlStateNormal];
    _updataBtn.titleLabel.textColor = [UIColor orangeColor];
    _updataBtn.layer.cornerRadius = 20.0;
    _updataBtn.layer.masksToBounds = YES;
    

    _GoBtn.layer.cornerRadius = 130.0;
    _GoBtn.layer.masksToBounds = YES;

    [_GoBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
   
    _statusLabel.font = [UIFont systemFontOfSize:27];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    
    _statusLabel.textColor = [UIColor whiteColor];
    [_backgroundV addSubview:_GoBtn];
    

    [self createUI];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)postgoBtnStatus{
    NSString * method = [NSString stringWithFormat:@"pad/?method=coach.button&order_id=%@",_orderID];
    NSString * url = [NSString stringWithFormat:@"%@%@",TESTBASEURL,method];
    NSLog(@"%@",url);
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        if (data) {
            NSLog(@"%@",data);
           NSDictionary * datadic = data[@"data"];
            
            _status = [datadic[@"status"] integerValue];            
            NSDictionary * namedic = datadic[@"name"];
            _method = namedic[@"method"];
            _statusLabeltxt = namedic[@"name"];
            
            NSLog(@"%@",namedic[@"name"]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (_status == 0) {
                    _statusLabel.text = _statusLabeltxt;
                    
                }else if(_status == 2){
                    [_GoBtn doNew];
                    _statusLabel.text = _statusLabeltxt;
                    
                }else if(_status == 3){
                    
                    [_GoBtn didEnd];
                    _GoBtn.userInteractionEnabled = NO;
                    _statusLabel.text = _statusLabeltxt;
                    
                }

                
            });
            
        }else{
            UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:action];
            
            [self presentViewController:alertC animated:YES completion:nil];
    
        }
    } andfailBlock:^(NSError *error) {
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"加载失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:action];
        
        [self presentViewController:alertC animated:YES completion:nil];

    }];

}
- (void)createUI{
    if (_isopen) {
        if (ISSHUPING) {//竖屏
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.offset(0);
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L / 3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
        }else if(ISHENGPING){
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.offset(0);
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
        }

    }else{
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.offset(0);
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
  
    }
            //出发按钮
            [_GoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
                make.centerX.mas_equalTo(0);
                make.centerY.offset(-150.0);
                make.width.and.height.mas_equalTo(260);
            }];
            //状态按钮
            [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_GoBtn.mas_bottom).offset(10);
                make.centerX.offset(0);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(50);
                
            }];
             //首次问卷
    [_firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-240);
        make.centerY.offset(100);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        
    }];
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_firstBtn.mas_centerX);
        make.width.mas_equalTo(_firstBtn.mas_width);
        make.height.mas_equalTo(40);
        
    }];
    //身体测试
    [_bordytestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-80);
        make.centerY.mas_equalTo(_firstBtn.mas_centerY);
        make.width.equalTo(_firstBtn.mas_width);
        make.height.mas_equalTo(_firstBtn.mas_height);
        
    }];
    [_bordytestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bordytestBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_bordytestBtn.mas_centerX);
        make.width.mas_equalTo(_bordytestBtn.mas_width);
        make.height.mas_equalTo(40);
        
    }];
    //私人订制
    [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(80);
        make.centerY.mas_equalTo(_firstBtn.mas_centerY);
        make.width.equalTo(_firstBtn.mas_width);
        make.height.mas_equalTo(_firstBtn.mas_height);
        
    }];
    [_personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_personBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_personBtn.mas_centerX);
        make.width.mas_equalTo(_personBtn.mas_width);
        make.height.mas_equalTo(40);
        
    }];
//教练交接
    [_trainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(240);
        make.centerY.mas_equalTo(_firstBtn.mas_centerY);
        make.width.equalTo(_firstBtn.mas_width);
        make.height.mas_equalTo(_firstBtn.mas_height);
        
    }];
    [_trainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_trainBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_trainBtn.mas_centerX);
        make.width.mas_equalTo(_trainBtn.mas_width);
        make.height.mas_equalTo(40);
        
    }];
    if (_isdone) {
        
    }else{
        [_updataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(220);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(40);
        }];
    }
    
    
}
- (void)menunoti:(NSNotification *)noti{
    
    NSString * Info = [noti.userInfo valueForKey:@"1"];
    
    if ([Info isEqualToString:@"出现"]) {
        
        _isopen = YES;
        
        [self handleDeviceOrientationDidChanged:[[UIApplication sharedApplication] statusBarOrientation]];
        
    }else if([Info isEqualToString:@"消失"]){
        
        _isopen = NO;
        
        [self handleDeviceOrientationDidChanged:[[UIApplication sharedApplication] statusBarOrientation]];
        
    }
    
    
}
#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChanged:(UIInterfaceOrientation)interfaceOrientation{
    if (_isopen) {
        if (ISSHUPING) {//竖屏
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.offset(0);
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L / 3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
        }else if(ISHENGPING){
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.offset(0);
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
        }
        
    }else{
        [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.offset(0);
            make.width.mas_equalTo(UISCREEN_W);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        
    }

    
}

- (void)createview{

    _GoBtn.imageV.image = [UIImage imageNamed:@"14"];

}
#pragma mark 出发点击按钮响应事件
- (void)Btnclick:(GoButton *)btn{
    
   if (_status == 0) {
       UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要出发吗?" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

           NSString * url = [NSString stringWithFormat:@"%@%@",TESTBASEURL,_method];
           NSLog(@"%@",url);
           
           [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id data) {
               if (data && [data[@"rc"] integerValue] == 0) {
                   NSLog(@"%@",data);
                   [_GoBtn doNew];
                   _statusLabel.text = _statusLabeltxt;
                   _status = 3;
                   
                   [self postgoBtnStatus];
                   
               }else{
                   UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络错误" preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                   [alertC addAction:action];
                   
                   [self presentViewController:alertC animated:YES completion:nil];
    
               }
               
           } andfailBlock:^(NSError *error) {
               UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"加载失败" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
               [alertC addAction:action];
               
               [self presentViewController:alertC animated:YES completion:nil];
               
               
           }];
           
           
       }];
       UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
       [alertC addAction:action];
       [alertC addAction:action1];
       
       [self presentViewController:alertC animated:YES completion:nil];

    
    }else if(_status == 3){
        
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要下课吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            NSString * url = [NSString stringWithFormat:@"%@%@",TESTBASEURL,_method];
            
            [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id data) {
                if (data && [data[@"rc"] integerValue] == 0) {
                    NSLog(@"%@",data);
                    [_GoBtn didEnd];
                    _GoBtn.userInteractionEnabled = NO;
                    _statusLabel.text = @"已下课";
                
                }else{
                    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络错误" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertC addAction:action];
                    
                    [self presentViewController:alertC animated:YES completion:nil];
       
                    
                }
            } andfailBlock:^(NSError *error) {
                UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"加载失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertC addAction:action];
                
                [self presentViewController:alertC animated:YES completion:nil];
       
            }];

        }];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:action];
        [alertC addAction:action1];
        
        [self presentViewController:alertC animated:YES completion:nil];
        

    }
  
   
 
}
#pragma mark 点击事件的实现
//首次问卷
- (void)questionnaireClick:(UIButton *)btn{
    firstViewController * firstVC = [[firstViewController alloc]init];
    
    firstVC.isover = self.isdone;
    firstVC.order_id = self.orderID;
    
    [self presentViewController:firstVC animated:YES completion:nil];
    
    
    
}
//身体测试
- (void)BordyClick:(UIButton *)btn{
    
    
    
}
//私人订制
- (void)personBtnclick:(UIButton *)btn{
    
    
    
}
//教练交接
- (void)trainBtnclick:(UIButton *)btn{
    
    
    
    
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
