//
//  OptionBtn.h
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface OptionBtn : UIButton


@property (nonatomic , strong) UIImageView * imageV;

@property (nonatomic , strong) UILabel * Classtitlelabel;



- (instancetype)initWithName:(NSString *)name andWithImageName:(NSString *)imageName;





@end
