//
//  OrderCell.m
//  NowExerciseipad
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()
{
    NSString * orderID;
    OrderModel * orderModel;
    
}
@end

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
        
        _imageV = [[UIImageView alloc]init];
        
        _nameLabel.font = [UIFont systemFontOfSize:32];
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
        [_backgroundV addSubview:_imageV];
        
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
        make.height.mas_equalTo(145);
        
    }];
    //名字
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(20);
        make.width.mas_equalTo(140);
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
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(20);
        make.left.offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
        
    }];
    //类型(上门)
    [_classtypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_StatusLabel.mas_bottom).offset(20);
        make.right.offset(-20.0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25.0);
        
    }];
    //地址
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phonenumberLabel.mas_bottom).offset(20);
        make.left.offset(20.0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(25);
        
    }];
    //上课时间
    [_onclasstimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_classtypeLabel.mas_bottom).offset(15);
        make.right.offset(-20.0);
        make.width.mas_equalTo(220.0);
        make.height.mas_equalTo(25);
        
    }];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.offset(0);
        make.width.and.height.mas_equalTo(30);
    }];
    
}
- (void)createCellWithmodel:(OrderModel *)model{
    _nameLabel.text = model.name;
    orderID = model.order_id;
    orderModel = model;
    
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
        
        [_doOrderBtn addTarget:self action:@selector(doOrderClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cantOrderBtn addTarget:self action:@selector(cantOrderClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [_doOrderBtn setTitle:@"接  单" forState:UIControlStateNormal];
        [_cantOrderBtn setTitle:@"拒  绝" forState:UIControlStateNormal];
        [_doOrderBtn setTitleColor:[UIColor colorWithRed:192 / 255.0f green:57 / 255.0f blue:43 / 255.0f alpha:1] forState:UIControlStateNormal];
        [_cantOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _doOrderBtn.layer.cornerRadius = 20;
        _doOrderBtn.layer.masksToBounds = YES;
        _doOrderBtn.layer.borderColor = [UIColor colorWithRed:192 / 255.0f green:57 / 255.0f blue:43 / 255.0f alpha:1].CGColor;
        _doOrderBtn.layer.borderWidth = 2;
        _doOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _cantOrderBtn.layer.cornerRadius = 20;
        _cantOrderBtn.layer.masksToBounds = YES;
        _cantOrderBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _cantOrderBtn.layer.borderWidth = 2;
        _cantOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;

        
        _StatusLabel.text = @"新订单";
        _StatusLabel.textColor = [UIColor colorWithRed:176 / 255.0f green:38 / 255.0f blue:33 / 255.0f alpha:1];
        _backgroundV.layer.borderColor = [UIColor colorWithRed:192 / 255.0f green:57 / 255.0f blue:43 / 255.0f alpha:1].CGColor;
        _imageV.image = [UIImage imageNamed:@"neworder.png"];
        
        
        [_doOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.right.offset(-20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
            
        }];
        [_cantOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-20);
            make.right.mas_equalTo(_doOrderBtn.mas_left).offset(-20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
            
        }];
        
    }else if(model.Process){
        _StatusLabel.text = @"已完成";
        _StatusLabel.textColor = [UIColor whiteColor];
        _backgroundV.layer.borderColor = [UIColor colorWithRed:198 / 255.0f green:195/255.0f blue:199/255.0f alpha:1].CGColor;

        _imageV.image = [UIImage imageNamed:@"doneorder.png"];

    }else{
        _StatusLabel.text = @"进行中...";
        _StatusLabel.textColor = [UIColor orangeColor];
        _backgroundV.layer.borderColor = [UIColor colorWithRed:211 / 255.0f green:84 / 255.0f blue:0 / 255.0f alpha:1].CGColor;
        _imageV.image = [UIImage imageNamed:@"onorder.png"];

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

- (void)doOrderClick:(UIButton *)btn{
    if (self.delegate) {
        [self.delegate OrderprocessingWithModel:orderModel andBool:YES];
    }
}
- (void)cantOrderClick:(UIButton *)btn{
    
    if (self.delegate) {
        [self.delegate OrderprocessingWithModel:orderModel andBool:NO];
    }
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
