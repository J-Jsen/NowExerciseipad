//
//  teacherCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "teacherCell.h"
@interface teacherCell()
{
    BOOL iselect;
}
@property (nonatomic , strong) UILabel * label;
@property (nonatomic , strong) UILabel * line;


@end

@implementation teacherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        _label = [[UILabel alloc]init];
        _line = [[UILabel alloc]init];
        self.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
        
        _label.textColor = WENDA_COLOR;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        [self addSubview:_line];

        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.offset(0);
            make.top.offset(5);
            make.bottom.offset(-5);
            
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.bottom.offset(-5);
            make.height.mas_equalTo(2);
            
        }];
    }
    return self;
    
}

- (void)createCellWithModel:(TeacherModel *)model{
    if (model.iselect) {
        [self selectCellwithmodel:model];
    }else{
        [self disselectCellwithmodel:model];
    }
    _label.text = model.username;
    
}
- (void)selectCellwithmodel:(TeacherModel *)model{
    _line.backgroundColor = [UIColor orangeColor];
    _label.textColor = [UIColor orangeColor];
    model.iselect = YES;
}
- (void)disselectCellwithmodel:(TeacherModel *)model{
    _line.backgroundColor = [UIColor clearColor];
    _label.textColor = WENDA_COLOR;
    model.iselect = NO;
}
@end
