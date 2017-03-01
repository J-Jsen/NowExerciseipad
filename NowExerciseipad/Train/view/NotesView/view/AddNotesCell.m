//
//  NotesCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "AddNotesCell.h"
#import "jieduanView.h"
#import "dayView.h"



@interface AddNotesCell()<jieduanDelegate,daydelegate,UITextFieldDelegate>
{
    AddNotesModel * Addmodel;
    
    jieduanView * jieduanV;
    dayView * dayV;
    
    NSMutableArray * jieduanArr;
    NSMutableArray * dayArr;
    
    
    
    
}
@end

@implementation AddNotesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)createCellWithModel:(AddNotesModel *)model{
    //NSLog(@"model%ld",model.result);
    
    self.backgroundColor = WINDOW_backgroundColor;
    Addmodel = model;
    _nameTF.text = Addmodel.name;
    _fankuiTF.text = Addmodel.fankui;
    _qingkuangTF.text = Addmodel.qingkuang;
    _beizhuTF.text = Addmodel.beizhu;
    
    _nameTF.delegate =self;
    _fankuiTF.delegate = self;
    _qingkuangTF.delegate = self;
    _beizhuTF.delegate = self;
    
    
    [_resultSeg setSelectedSegmentIndex:Addmodel.result];
   // NSLog(@"%ld",Addmodel.result);
    _saveBtn.layer.cornerRadius = 5;
    _saveBtn.layer.masksToBounds = YES;
    
    _jieduanBtn.layer.cornerRadius = 5;
    _jieduanBtn.layer.borderWidth = 2;
    _jieduanBtn.layer.borderColor = WENDA_COLOR.CGColor;

    _dayBtn.layer.cornerRadius = 5;
    _dayBtn.layer.borderWidth = 2;
    _dayBtn.layer.borderColor = WENDA_COLOR.CGColor;
    
    _jieduanL.text = Addmodel.jieduan;
    _dayL.text = Addmodel.dayL;
    
    jieduanArr = [NSMutableArray array];
    for (NSDictionary * dic in Addmodel.dataArr) {
        NSDictionary * dict = @{@"name":dic[@"name"],@"framework_id":dic[@"framework_id"]};
        
        [jieduanArr addObject:dict];
        
    }
    NSMutableArray * arr = Addmodel.dataArr[0][@"subtitel"];
    dayArr = [NSMutableArray arrayWithArray:arr];
    
    _nameTF.text = Addmodel.name;
    
    
}
- (IBAction)selectnumber:(id)sender {
    
    UISegmentedControl * seg = (UISegmentedControl *)sender;
    NSInteger selectI = seg.selectedSegmentIndex;
  //  NSLog(@"选中了:%ld",selectI);
    Addmodel.result = selectI;
    
    
}
#pragma mark 文本框结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _nameTF) {
        Addmodel.name = textField.text;
    }else if (textField == _fankuiTF){
        Addmodel.fankui = _fankuiTF.text;
        
    }else if (textField == _qingkuangTF){
        Addmodel.qingkuang = _qingkuangTF.text;
        
    }else if(textField == _beizhuTF){
        Addmodel.beizhu = _beizhuTF.text;
    }
    
    
    
}
- (IBAction)jieduanCbtnClick:(id)sender {
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
            make.height.mas_equalTo(200);
            
        }];
    }else if(jieduanV){
        [self jieduandismiss];
    }
    if (dayV){
        _dayBtn.selected = NO;
        [self daydismiss];
        
    }

    

}
- (IBAction)dayBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        dayV = [[dayView alloc]initWithArray:dayArr];
        dayV.delegate = self;
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
        [self addSubview:dayV];
        [dayV.layer addAnimation:transition forKey:@"animation"];
        
        [dayV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dayBtn.mas_bottom);
            make.centerX.mas_equalTo(_dayBtn.mas_centerX);
            make.width.mas_equalTo(_dayBtn.mas_width);
            make.height.mas_equalTo(200);
            
        }];
        
    }else if(dayV){
        
        [self daydismiss];
    }
    if(jieduanV){
        _jieduanBtn.selected = NO;
        [self jieduandismiss];
    }

}

- (IBAction)jieduanBtnclick:(id)sender {
    
    [self.delegate AddBtnclick:Addmodel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark 阶段代理方法
- (void)selectjieduanNumber:(NSInteger)row andjieduanStr:(NSString *)str{
    dayArr = nil;
    _jieduanL.text = str;
    
    _jieduanBtn.selected = NO;
    NSDictionary * dic = Addmodel.dataArr[row];
    dayArr = dic[@"subtitel"];
    _dayL.text = [dayArr[0] valueForKey:@"name"];
    Addmodel.classID = [[dayArr[0] valueForKey:@"id"] integerValue];
    
    [jieduanV removeFromSuperview];
    
}
#pragma mark 天数代理
- (void)dayselectNumber:(NSInteger)classID anddayL:(NSString *)daystr{
    Addmodel.classID = classID;
    Addmodel.dayL = daystr;
    _dayL.text = daystr;
    if (dayV) {
        [dayV removeFromSuperview];
        _dayBtn.selected = NO;
        
    }
}
#pragma mark 阶段消失
- (void)jieduandismiss{
    [jieduanV removeFromSuperview];
}
#pragma mark 天数消失
- (void)daydismiss{
    [dayV removeFromSuperview];

}
@end
