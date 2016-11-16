//
//  TrainViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "TrainViewController.h"
#import "trainButton.h"
#import "leftdetailV.h"
#import "DetailView.h"
#import "NotesView.h"
@interface TrainViewController ()
@property (nonatomic , strong) UIView * backgroundV;

@property (nonatomic , strong) UIView * leftBtnV;
@property (nonatomic , strong) leftdetailV * leftdetailV;
@property (nonatomic , strong) UIView * rightV;

@property (nonatomic , strong) trainButton * detailBtn;
@property (nonatomic , strong) trainButton * notestrainBtn;
@property (nonatomic , strong) trainButton * checktrainBtn;

@property (nonatomic , strong) DetailView * detailV;
@property (nonatomic , strong) NotesView * notesV;
@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WINDOW_backgroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];
    [self createUI];
    [self createRect];
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    
    // Do any additional setup after loading the view.
}
- (void)createUI{
    _backgroundV = [[UIView alloc]init];
    _backgroundV.layer.borderWidth = 1;
    _backgroundV.layer.borderColor = LEFTBTNTEXT_BACKGROUNDCOLOR.CGColor;
    
    [self.view addSubview:_backgroundV];
    
    _leftBtnV = [[UIView alloc]init];
    _leftBtnV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
    [_backgroundV addSubview:_leftBtnV];
    
    _leftdetailV = [[leftdetailV alloc]init];
    [_backgroundV addSubview:_leftdetailV];
    _leftdetailV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
    _leftdetailV.hidden = YES;
    
    _detailBtn = [[trainButton alloc]initWithtitlename:@"培训内容" andimagename:@"36"];
    _detailBtn.selected = YES;
    [_detailBtn changeColorWithimagename:@"36"];
    
    _notestrainBtn = [[trainButton alloc]initWithtitlename:@"培训记录" andimagename:@"37"];
    _checktrainBtn = [[trainButton alloc]initWithtitlename:@"考核记录" andimagename:@"37"];
    
    _detailBtn.tag = 310;
    _notestrainBtn.tag = 320;
    _checktrainBtn.tag = 330;
    
    
    [_detailBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_notestrainBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_checktrainBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_leftBtnV addSubview:_detailBtn];
    [_leftBtnV addSubview:_notestrainBtn];
    [_leftBtnV addSubview:_checktrainBtn];
    
    _rightV = [[UIView alloc]init];
    [_backgroundV addSubview:_rightV];
    
    _detailV = [[DetailView alloc]init];
    [_rightV addSubview:_detailV];
    
    
}
#pragma mark Btn点击事件
- (void)btnclick:(trainButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        switch (btn.tag) {
            case 310://培训内容
            {
                if (_detailV) {
                    [_rightV bringSubviewToFront:_detailV];
                    _detailV.hidden = NO;
                    
                }
                _leftdetailV.hidden = YES;
                _notestrainBtn.selected = NO;
                _checktrainBtn.selected = NO;
                
            }
                break;
            case 320://培训记录
            {
                _leftdetailV.hidden = NO;
                _detailV.hidden = YES;
                if (_notesV) {
                    [_notesV removeFromSuperview];
                }
                    //新建
                    [_leftdetailV reloadtableview];
                    _notesV = [[NotesView alloc]init];
                
                    [_rightV addSubview:_notesV];
                    
                    [_notesV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.offset(0);
                    }];
                
                _detailBtn.selected = NO;
                _checktrainBtn.selected = NO;
                
                
            }
                break;
            case 330://考核记录
            {
                _leftdetailV.hidden = NO;
                _notestrainBtn.selected = NO;
                _detailBtn.selected = NO;
                

            }
                break;
                
            default:
                break;
        }
    }else{
        
        switch (btn.tag) {
            case 310://培训内容
            {
                
                
            }
                break;
            case 320://培训记录
            {
                
                
            }
                break;
            case 330://考核记录
            {
                
            }
                break;
                
            default:
                break;
        }
        
        
    }

    
}
- (void)createRect{
    if (ISSHUPING) {
        if (_islook) {
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
            }];
            
        }else{
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
            
        }else{
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
        }
        
    }
    [_leftBtnV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.offset(0);
        make.width.mas_equalTo(170.25/ 2.0);
        make.height.mas_equalTo(170.25 * 3 /2.0);
        
    }];
    
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(170.25 / 2.0);
        
    }];
    [_notestrainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.mas_equalTo(_detailBtn.mas_bottom);
        make.height.mas_equalTo(_detailBtn.mas_height);
        
    }];
    [_checktrainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.mas_equalTo(_notestrainBtn.mas_bottom);
        make.height.mas_equalTo(_detailBtn.mas_height);
        
    }];
    [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.bottom.offset(0);
        make.left.mas_equalTo(_leftBtnV.mas_right);
        
    }];
    
    [_detailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.offset(0);
        
    }];
    [_leftdetailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.offset(0);
        make.top.mas_equalTo(_leftBtnV.mas_bottom);
        make.width.mas_equalTo(_leftBtnV.mas_width);
    }];
    
}
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{

    if (ISSHUPING) {
        if (_islook) {
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
            }];
            
        }else{
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
            
        }else{
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
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

#pragma mark  移除观察者
- (void)dealloc{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanxiang" object:nil];
        
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
