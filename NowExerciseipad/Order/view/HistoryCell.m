//
//  HistoryCell.m
//  NowExerciseipad
//
//  Created by mac on 16/12/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "HistoryCell.h"

@interface HistoryCell()

@end

@implementation HistoryCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WINDOW_backgroundColor;
        
        self.dayLabel      = [[UILabel alloc]init];
        self.timeLabel     = [[UILabel alloc]init];
        self.touchLabel    = [[UILabel alloc]init];
        self.XinlvLabel    = [[UILabel alloc]init];
        self.BiaoxianLabel = [[UILabel alloc]init];
        self.ReqingLabel   = [[UILabel alloc]init];
        self.NeirongLabel  = [[UILabel alloc]init];

        
        self.dayLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.touchLabel.textColor = [UIColor whiteColor];
        self.XinlvLabel.textColor = [UIColor whiteColor];
        self.BiaoxianLabel.textColor = [UIColor whiteColor];
        self.ReqingLabel.textColor = [UIColor whiteColor];
        self.NeirongLabel.textColor = [UIColor whiteColor];
        
        
        
        [self addSubview:_dayLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_touchLabel];
        [self addSubview:_XinlvLabel];
        [self addSubview:_BiaoxianLabel];
        [self addSubview:_ReqingLabel];
        [self addSubview:_NeirongLabel];

        
        
        
    //需要自适应
        
        self.JibingLabel     = [[UILabel alloc]init];
        self.ManyibufenLabel = [[UILabel alloc]init];
        self.JinjiLabel      = [[UILabel alloc]init];
        self.JianyiLabel     = [[UILabel alloc]init];
        self.YinshiLabel     = [[UILabel alloc]init];
        self.NextZhuyiLabel  = [[UILabel alloc]init];
        self.DanyouLabel     = [[UILabel alloc]init];
        self.BianhuaLabel    = [[UILabel alloc]init];
        self.BeizhuLabel     = [[UILabel alloc]init];
        
        self.JibingLabel.numberOfLines = 0;
        self.ManyibufenLabel.numberOfLines = 0;
        self.JinjiLabel.numberOfLines = 0;
        self.JianyiLabel.numberOfLines = 0;
        self.YinshiLabel.numberOfLines = 0;
        self.NextZhuyiLabel.numberOfLines = 0;
        self.DanyouLabel.numberOfLines = 0;
        self.BianhuaLabel.numberOfLines = 0;
        self.BeizhuLabel.numberOfLines = 0;
        
        self.JibingLabel.textColor = [UIColor whiteColor];
        self.ManyibufenLabel.textColor = [UIColor whiteColor];
        self.JinjiLabel.textColor = [UIColor whiteColor];
        self.JianyiLabel.textColor = [UIColor whiteColor];
        self.YinshiLabel.textColor = [UIColor whiteColor];
        self.NextZhuyiLabel.textColor = [UIColor whiteColor];
        self.DanyouLabel.textColor = [UIColor whiteColor];
        self.BianhuaLabel.textColor = [UIColor whiteColor];
        self.BeizhuLabel.textColor = [UIColor whiteColor];
        
        
        
        [self addSubview:_JibingLabel];
        [self addSubview:_ManyibufenLabel];
        [self addSubview:_JinjiLabel];
        [self addSubview:_JianyiLabel];
        [self addSubview:_YinshiLabel];
        [self addSubview:_NextZhuyiLabel];
        [self addSubview:_DanyouLabel];
        [self addSubview:_BianhuaLabel];
        [self addSubview:_BeizhuLabel];
        
        

        
    }
    return self;
}
- (void)createCellWithModel:(HistoryModel *)model{
    
    NSDictionary * dic = model.base;
    //时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * timestr = dic[@"date"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestr integerValue]];
    NSString* dateString = [formatter stringFromDate:date];

    self.dayLabel.text = [NSString stringWithFormat:@"时间:%@",dateString];
    
    //上课时间
    self.timeLabel.text = [NSString stringWithFormat:@"上课时间:%@", dic[@"time"]];
    //教练
    self.touchLabel.text = dic[@"coach"];
    //最高心率
    self.XinlvLabel.text = [NSString stringWithFormat:@"最高心率为:%@",dic[@"heart_rate"]];
    //运动表现
    NSString * biaoxian = @"无";
    if ([dic[@"expression"] isEqualToString:@"0"]) {
        biaoxian = @"优秀";
    }else if([dic[@"expression"] isEqualToString:@"1"]){
        biaoxian = @"良好";
    }else if ([dic[@"expression"] isEqualToString:@"2"]){
        biaoxian = @"一般";
    }else{
        biaoxian = @"很差";
    }
    self.BiaoxianLabel.text = [NSString stringWithFormat:@"运动表现:%@",biaoxian];
    //会员热情
    NSString * reqing = @"无";
    if ([dic[@"enthusiasm"] isEqualToString:@"0"]) {
        biaoxian = @"优秀";
    }else if([dic[@"enthusiasm"] isEqualToString:@"1"]){
        biaoxian = @"良好";
    }else if ([dic[@"enthusiasm"] isEqualToString:@"2"]){
        biaoxian = @"一般";
    }else{
        biaoxian = @"很差";
    }
    self.ReqingLabel.text = [NSString stringWithFormat:@"会员热情度:%@",reqing];
    //内容
    self.NeirongLabel.text = [NSString stringWithFormat:@"内容:%@",dic[@"content"]];
    
    //自适应
    [self createUIWithModel:model];
    
}
- (void)createUIWithModel:(HistoryModel *)model{
   
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(40);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(200);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.centerX.offset(-20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
    }];
    
    [self.touchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.right.offset(-50);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
        
    }];
    
    [self.XinlvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.mas_equalTo(_dayLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
        
    }];
    [self.BiaoxianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(_timeLabel.mas_left);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
        
    }];
    
    [self.ReqingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.top.mas_equalTo(_touchLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
        
    }];
    
    [self.NeirongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.mas_equalTo(_XinlvLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
        
    }];
    
    //下面的label需要自适应
    __weak __typeof__(self) weakSelf = self;

    NSArray * arr = model.recard_remark;
    
    for (NSDictionary * dic in arr) {
        NSString * Str = [NSString stringWithFormat:@"%@:%@",dic[@"title"],dic[@"content"]];
        NSInteger title_id = [dic[@"title_id"] integerValue];
        
       
        switch (title_id) {
            case 1:
            {//疾病及伤痛注意事项
                _JibingLabel.text = Str;
                [_JibingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.NeirongLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.JibingL);
                }];
            }
                break;
            case 3:
            {//会员运动喜好及满意部分
                self.ManyibufenLabel.text = Str;
                [self.ManyibufenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.JibingLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.ManyibufenL);

                }];
            }
                break;
            case 4:
            {//运动禁忌
                self.JinjiLabel.text = Str;
                [self.JinjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.ManyibufenLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.JinjiL);

                }];
            }
                break;
            case 5:
            {//运动内容及强度建议
                self.JianyiLabel.text = Str;
                [self.JianyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.JinjiLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.JianyiL);

                }];
            }
                break;
            case 6:
            {//饮食建议
                self.YinshiLabel.text = Str;
                [self.YinshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.JianyiLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.YinshiL);

                }];
            }
                break;
            case 7:
            {//下位教练需注意
                self.NextZhuyiLabel.text = Str;
                [self.NextZhuyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.YinshiLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.NextZhuyiL);
 
                }];
            }
                break;
            case 8:
            {//会员担忧及问题
                self.DanyouLabel.text = Str;
                [self.DanyouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.NextZhuyiLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.DanyouL);

                }];
            }
                break;
            case 9:
            {//会员变化
                self.BianhuaLabel.text = Str;
                [self.BianhuaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.DanyouLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.BianhuaL);
 
                }];
            }
                break;
            case 10:
            {//备注
                self.BeizhuLabel.text = Str;
                [self.BeizhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(40);
                    make.top.mas_equalTo(weakSelf.BianhuaLabel.mas_bottom).offset(20);
                    make.right.offset(-50);
                    make.height.mas_equalTo(model.Beizhu);
 
                }];
            }
                break;
        
            default:
                break;
        }
  
        
        
        
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
