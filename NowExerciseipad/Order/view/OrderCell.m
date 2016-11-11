//
//  OrderCell.m
//  NowExerciseipad
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel alloc]init];
        _sexLabel = [[UILabel alloc]init];
        _classnameLabel = [[UILabel alloc]init];
        _placeLabel = [[UILabel alloc]init];
        _onclasstimeLabel = [[UILabel alloc]init];
        _phonenumberLabel  = [[UILabel alloc]init];
        _StatusLabel = [[UILabel alloc]init];
        _classtypeLabel = [[UILabel alloc]init];
        _backgroundV = [[UIView alloc]init];
        
        _nameLabel.font = [UIFont systemFontOfSize:20.0];
        _backgroundV.layer.borderWidth = 3.0;
        _backgroundV.layer.cornerRadius = 6.0;
        _backgroundV.layer.borderColor = [UIColor whiteColor].CGColor;
        _backgroundV.layer.masksToBounds = YES;
        
        _nameLabel.textColor = [UIColor whiteColor];
        _sexLabel.textColor = [UIColor whiteColor];
        _classnameLabel.textColor = [UIColor whiteColor];
        _placeLabel.textColor = [UIColor whiteColor];
        _onclasstimeLabel.textColor = [UIColor whiteColor];
        _classtypeLabel.textColor = [UIColor whiteColor];
        _phonenumberLabel.textColor = [UIColor whiteColor];
        
        _StatusLabel.textAlignment = NSTextAlignmentRight;
        _classtypeLabel.textAlignment = NSTextAlignmentRight;
        _onclasstimeLabel.textAlignment = NSTextAlignmentRight;
        
   
        [self addSubview:_backgroundV];
        [_backgroundV addSubview:_nameLabel];
        [_backgroundV addSubview:_sexLabel];
        [_backgroundV addSubview:_classnameLabel];
        [_backgroundV addSubview:_placeLabel];
        [_backgroundV addSubview:_onclasstimeLabel];
        [_backgroundV addSubview:_phonenumberLabel];
        [_backgroundV addSubview:_StatusLabel];
        [_backgroundV addSubview:_classtypeLabel];
        self.backgroundColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        
   
        [self createUI];
        

        
        
    }
    return self;
    
}
- (void)createUI{
    //背景
    [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(20.0);
        make.right.mas_equalTo(-20.0);
        
        make.height.mas_equalTo(125.0);
        
    }];
    //名字
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(20);
        make.width.mas_equalTo(80.0);
        make.height.mas_equalTo(30.0);
        
        
    }];
    //性别
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(_nameLabel.mas_right).offset(5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        
    }];
    
    //课程名字
    [_classnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.centerX.offset(0);
        make.width.mas_equalTo(180.0);
        make.height.mas_equalTo(25.0);
        
    }];
    //订单状态
    [_StatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
        
    }];
    //电话
    [_phonenumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(10.0);
        make.left.offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
        
    }];
    //类型(上门)
    [_classtypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_StatusLabel.mas_bottom).offset(10.0);
        make.right.offset(-20.0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25.0);
        
    }];
    //地址
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phonenumberLabel.mas_bottom).offset(10.0);
        make.left.offset(20.0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(25);
        
    }];
    //上课时间
    [_onclasstimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_classtypeLabel.mas_bottom).offset(10.0);
        make.right.offset(-20.0);
        make.width.mas_equalTo(220.0);
        make.height.mas_equalTo(25);
        
    }];
    
}
- (void)createCellWithmodel:(OrderModel *)model{
    _nameLabel.text = model.name;
    if ([model.gender integerValue] == 2) {
        _sexLabel.text = @"男";
    }else{
        _sexLabel.text = @"女";
    }
    _classnameLabel.text = [NSString stringWithFormat:@"%@%@",@"课程:",model.course];

    
    if (model.newOrder) {
        _doOrderBtn = [[UIButton alloc]init];
        _cantOrderBtn = [[UIButton alloc]init];
        
        [self addSubview:_doOrderBtn];
        [self addSubview:_cantOrderBtn];
        
        _StatusLabel.text = @"新订单";
        _StatusLabel.textColor = [UIColor orangeColor];
        _backgroundV.layer.borderColor = [UIColor orangeColor].CGColor;
        
        
        [_doOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.offset(20);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(25);
            
        }];
        [_cantOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.right.mas_equalTo(_doOrderBtn.mas_left).offset(20);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(25);
            
        }];
        
    }else if(model.Process){
        _StatusLabel.text = @"已完成";
        _StatusLabel.textColor = [UIColor whiteColor];
        
    }else{
        _StatusLabel.text = @"进行中...";
        _StatusLabel.textColor = [UIColor orangeColor];
        _backgroundV.layer.borderColor = [UIColor orangeColor].CGColor;
        
    }
    _placeLabel.text = [NSString stringWithFormat:@"%@%@",@"地址:",model.place];
    _classtypeLabel.text = [NSString stringWithFormat:@"%@%@",@"类型:",model.order_type];
    // 时间戳转时间的方法:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日  HH时"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.pre_time integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _onclasstimeLabel.text = [NSString stringWithFormat:@"上课时间：%@",confromTimespStr];
    _phonenumberLabel.text = [NSString stringWithFormat:@"%@%@",@"电话:",model.number];


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}













- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
