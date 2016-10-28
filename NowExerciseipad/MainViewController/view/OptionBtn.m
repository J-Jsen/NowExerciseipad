//
//  OptionBtn.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OptionBtn.h"
@class MainViewController;

@implementation OptionBtn


- (instancetype)initWithName:(NSString *)name andWithImageName:(NSString *)imageName{
    
    if (self = [super init]) {
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleDeviceOrientationDidChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil
         ];
        
        
        _imageV = [[UIImageView alloc]init];
        _Classtitlelabel = [[UILabel alloc]init];
        
        _Classtitlelabel.text = name;
        _Classtitlelabel.textAlignment = NSTextAlignmentCenter;
        _Classtitlelabel.font = [UIFont systemFontOfSize:17];
        _Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        
        
        _imageV.image = [UIImage imageNamed:imageName];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        
        [self addSubview:_Classtitlelabel];
        [self addSubview:_imageV];
        
        [self createUI];
        
        
     
    }
    return self;
}

- (void)createUI{
    
    
    __weak typeof (self) weakSelf = self;
    
    [_Classtitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(5);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
        make.top.mas_equalTo(_imageV.mas_bottom).offset(5);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-5);
        
        
    }];

    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown) {
        _Classtitlelabel.hidden = YES;
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weakSelf.mas_top).offset(100);
            make.left.mas_equalTo(weakSelf.mas_left).offset(10.0*120.0/111.0);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-10.0*120.0/111.0);
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-100);
            
            
        }];

        
        
    
    }else{
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weakSelf.mas_top).offset(50);
            make.left.mas_equalTo(weakSelf.mas_left).offset(50.0*120.0/111.0);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-50.0*120.0/111.0);
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-50);
            
            
        }];
        

    }
    
}

#pragma MARK 代理方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{

    UIDevice *device = [UIDevice currentDevice];
    __weak typeof (self) weakSelf = self;

switch (device.orientation) {
    case UIDeviceOrientationFaceUp:
        NSLog(@"屏幕朝上平躺");
        
        
        break;
        
    case UIDeviceOrientationFaceDown:
        NSLog(@"屏幕朝下平躺");
        break;
        
        //系統無法判斷目前Device的方向，有可能是斜置
    case UIDeviceOrientationUnknown:
        NSLog(@"未知方向");
        break;
        
    case UIDeviceOrientationLandscapeLeft://屏幕向左横置
    case UIDeviceOrientationLandscapeRight://屏幕向右橫置
        
        
        
        
        
        
    {
        self.Classtitlelabel.hidden = NO;

        [_imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weakSelf.mas_top).offset(50);
            make.left.mas_equalTo(weakSelf.mas_left).offset(50.0*120.0/111.0);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-50.0*120.0/111.0);
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-50);
            
            
        }];
        
        
        
    }
        break;
        
    case UIDeviceOrientationPortrait://屏幕直立
    case UIDeviceOrientationPortraitUpsideDown://屏幕直立，上下顛倒
    {
        self.Classtitlelabel.hidden = YES;

        [_imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weakSelf.mas_top).offset(100);
            make.left.mas_equalTo(weakSelf.mas_left).offset(10.0*120.0/111.0);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-10.0*120.0/111.0);
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-100);
            
            
        }];
 
        
        
        
    }
        
        break;
        
    default:
        NSLog(@"无法辨识");
        break;
}

}




@end
