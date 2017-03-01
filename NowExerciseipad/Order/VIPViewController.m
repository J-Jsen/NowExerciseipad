//
//  VIPViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "VIPViewController.h"

#import "WebViewJavascriptBridge.h"

#import "HistoryViewController.h"
@interface VIPViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIWebView * webV;
    NSString * url;
    
    UIView * navV;
    
    UILabel * titleLabel;
    UIButton * backBtn;
    
    WebViewJavascriptBridge * bridge;
    
    NSString * isdone;
    
}


@end

@implementation VIPViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setISdone];
    [self createUI];
    [self createRect];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setISdone{
    
    if (_isfinish) {
        isdone = @"true";
    }else{
        isdone = @"false";
    }
    
}
- (void)createUI{
    
    navV = [[UIView alloc]init];
    navV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
    [self.view addSubview:navV];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.text = _titleStr;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [navV addSubview:titleLabel];
    
    backBtn = [[UIButton alloc]init];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    UIImage * image = [UIImage imageNamed:@"fanhui.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setTintColor:[UIColor orangeColor]];
    [backBtn setImage:image forState:UIControlStateNormal];
    
    [navV addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [WebViewJavascriptBridge enableLogging];
    bridge = [WebViewJavascriptBridge bridgeForWebView:webV];
    
//    [self opencamero];
//    [self transportData];
    
    webV = [[UIWebView alloc]init];
    webV.backgroundColor = WINDOW_backgroundColor;
    
    [self.view addSubview:webV];
    [self setUrl];
    
}

- (void)transportData{
    
//    [bridge callHandler:@"transportData" data:@{@"orderID":_orderID}];
    
}
- (void)createRect{
    [navV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.offset(0);
        make.height.mas_equalTo(64);
        
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(20);
        make.bottom.offset(-5);
        make.width.mas_equalTo(80);
        
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.top.offset(20);
        
    }];
    [webV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.top.offset(64);
        
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateFocusIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}

- (void)setUrl{
    
    if ([_titleStr isEqualToString:@"首次问卷"]) {
        url = [NSString stringWithFormat:@"%@/static/pad/questionnaire.html?order_id=%@&isfinish=%@",BASEURL,_orderID,isdone];
    }else if ([_titleStr isEqualToString:@"身体测试"]){
        url = [NSString stringWithFormat:@"%@static/pad/bodytest.html?order_id=%@&isfinish=%@",BASEURL,_orderID,isdone];
    }else if ([_titleStr isEqualToString:@"私人订制"]){
        url = [NSString stringWithFormat:@"%@personal/%ld",BASEURL,(long)_personal_id];
    }else if ([_titleStr isEqualToString:@"教练交接"]){
        url = [NSString stringWithFormat:@"%@static/pad/transition_table.html?order_id=%@&isfinish=%@",BASEURL,_orderID,isdone];
        //历史交接记录
        [self createHistory];
        
    }
    NSLog(@"详情接口url:%@",url);

    NSURL * updataUrl = [NSURL URLWithString:url];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:updataUrl];
    [webV loadRequest:request];
    
}

- (void)createHistory{
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"历史记录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(HistoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor whiteColor]];
    
    [navV addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.mas_equalTo(80);
        make.bottom.offset(-5);
        
    }];
}
#pragma mark 历史记录
- (void)HistoryBtnClick:(UIButton *)btn{
    
    HistoryViewController * historyVC = [[HistoryViewController alloc]init];
    
    historyVC.orderID = self.orderID;
    
    [self.navigationController pushViewController:historyVC animated:YES];
    
    
}

- (void)backBtnClick:(UIButton *)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//
//- (void)opencamero{
//    __weak typeof (self) weakSelf = self;
//
//    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
//    [imagePicker setDelegate:self];
//    imagePicker.allowsEditing = YES;
//    
//    [bridge registerHandler:@"passValue" handler:^(id data, WVJBResponseCallback responseCallback) {
//        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择照片来源" preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                [weakSelf presentViewController:imagePicker animated:YES completion:nil];
//
//            }
//        }];
//        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//                [weakSelf presentViewController:imagePicker animated:YES completion:nil];
//                
//            }
//        }];
//        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alertVC addAction:action1];
//        [alertVC addAction:action2];
//        [alertVC addAction:action3];
//        NSLog(@"收到了HTML的通知");
//    }];
//    
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary ]) {
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//}
///*        代理方法                      */
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    //确定使用图片调用的方法
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
//    }
//    NSData * data = UIImagePNGRepresentation(image);
//    [bridge callHandler:@"imagedata" data:@{@"image":image}];
//    NSLog(@"info %@",info);
//    
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    NSLog(@"取消了");
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    //取消使用的代理方法
//}
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
