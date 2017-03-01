//
//  AddcheckCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "AddcheckCell.h"
#import "jieduanView.h"
#import "leixingView.h"
@interface AddcheckCell()<UITextFieldDelegate,jieduanDelegate,leixingViewDelegate>
{
    checkModel * checkmodel;
    jieduanView * jieduanV;
    NSMutableArray * jieduanArr;
    leixingView * leixingV;
    
}

@end

@implementation AddcheckCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)createCellWithModel:(checkModel *)model{
    
    _jieduanBtn.layer.borderColor = WENDA_COLOR.CGColor;
    _jieduanBtn.layer.borderWidth = 2;
    _jieduanBtn.layer.cornerRadius = 5;
    _jieduanBtn.layer.masksToBounds = YES;
    
    _leixingBtn.layer.borderWidth = 2;
    _leixingBtn.layer.borderColor = WENDA_COLOR.CGColor;
    _leixingBtn.layer.cornerRadius = 5;
    _leixingBtn.layer.masksToBounds = YES;
    
    _saveBtn.layer.borderColor = WENDA_COLOR.CGColor;
    _saveBtn.layer.borderWidth = 2;
    _saveBtn.layer.cornerRadius = 5;
    _saveBtn.layer.masksToBounds = YES;
    
    jieduanArr = [NSMutableArray arrayWithArray:model.dataArr];
    checkmodel = model;
    
    _timeTF.text = model.time;
    _timeTF.delegate = self;
    [_timeTF addTarget:self action:@selector(timeTFchange:) forControlEvents:UIControlEventEditingChanged];
    
    _beizhuTF.text = model.remark;
    _beizhuTF.delegate = self;
    
    if ([model.result isEqualToString:@"优"]) {
        _segControl.selectedSegmentIndex = 0;
        
    }else if ([model.result isEqualToString:@"良"]){
        _segControl.selectedSegmentIndex = 1;
        
    }else if ([model.result isEqualToString:@"中"]){
        _segControl.selectedSegmentIndex = 2;
        
    }else{
        _segControl.selectedSegmentIndex = 3;
        
    }
    _jieduanL.text = model.jieduan;
    _leixingL.text = @"入职";
    
    
}

- (void)timeTFchange:(UITextField *)tf{
    NSMutableString * str = [NSMutableString stringWithString:tf.text];
    
    switch (tf.text.length) {
        case 5:
        {
            if ([str characterAtIndex:4] == '-') {
                
            }else{
            [str insertString:@"-" atIndex:4];
            }
        }
            break;
        case 8:
        {
            if ([str characterAtIndex:7] == '-') {
            
        }else{
            [str insertString:@"-" atIndex:7];
        }
        }
            break;

        default:
            break;
    }
    
    if (tf.text.length > 10) {
        str = (NSMutableString *)[str substringToIndex:10];
    }
    
    tf.text = str;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    NSLog(@"%ld",range.length);
//    NSLog(@"%@",string);
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _timeTF) {
        checkmodel.time = textField.text;
    }else if (textField == _beizhuTF){
        checkmodel.remark = textField.text;
    }
    
    
}
- (IBAction)leixingBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        leixingV = [[leixingView alloc]init];
        leixingV.delegate = self;
        
        [self addSubview:leixingV];
        [leixingV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_leixingBtn.mas_bottom);
            make.centerX.mas_equalTo(_leixingBtn.mas_centerX);
            make.width.mas_equalTo(_jieduanBtn.mas_width);
            make.height.mas_equalTo(88);
        }];
        
    
    }else if(leixingV){
        [self leixingVdismiss];
    }
    if (jieduanV){
        _jieduanBtn.selected = NO;
        [self jieduandismiss];
        
    }
    
}
- (IBAction)jieduanBtnclick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        jieduanV = [[jieduanView alloc]initWithArray:jieduanArr];
        jieduanV.delegate = self;
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
        [self addSubview:jieduanV];
        [jieduanV.layer addAnimation:transition forKey:@"animation"];
        
        
        [jieduanV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_jieduanBtn.mas_bottom);
            make.centerX.mas_equalTo(_jieduanBtn.mas_centerX);
            make.width.mas_equalTo(_jieduanBtn.mas_width);
            make.height.mas_equalTo(176);
            
        }];
    }else if(jieduanV){
        [self jieduandismiss];
    }
    if (leixingV){
        _leixingBtn.selected = NO;
        [self leixingVdismiss];
        
    }

    
    
}
- (IBAction)segSelectIndex:(id)sender {
    UISegmentedControl * seg = sender;
    checkmodel.result = [NSString stringWithFormat:@"%ld",(long)seg.selectedSegmentIndex];
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.delegate) {
        [self.delegate savedataWithModel:checkmodel];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark 阶段代理方法
- (void)selectjieduanNumber:(NSInteger)row andjieduanStr:(NSString *)str{
    checkmodel.classID = jieduanArr[row][@"framwork_id"];
    checkmodel.jieduan = jieduanArr[row][@"name"];
    _jieduanL.text = checkmodel.jieduan;
    
    [jieduanV removeFromSuperview];
    
}
#pragma mark 类型代理方法
- (void)backleixingStr:(NSString *)str{
    if ([str isEqualToString:@"入职"]) {
        _jieduanBtn.userInteractionEnabled = YES;
        
    }else{
        _jieduanBtn.userInteractionEnabled = NO;
        
    }
    _leixingL.text = str;
    checkmodel.leiixng = str;
    [self leixingVdismiss];
}
#pragma mark 阶段消失
- (void)jieduandismiss{
    [jieduanV removeFromSuperview];
}
#pragma mark 天数消失
- (void)leixingVdismiss{
    [leixingV removeFromSuperview];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    
}
@end
