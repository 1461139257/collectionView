//
//  CustomCollectionViewCell.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (strong, nonatomic) UIImageView *topImage;

@property (strong, nonatomic) UILabel *botlabel;

@end


@implementation CustomCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PhotoWith, PhotoWith+20)];
        _topImage.contentMode =  UIViewContentModeScaleAspectFill ;
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.frame.size.height, PhotoWith, 30)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [Global convertHexToRGB:@"434343"];
        _botlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

-(void)setCustomModel:(CustomCollectModel *)customModel{
    
    _customModel = customModel;
    [_topImage sd_setImageWithURL:[NSURL URLWithString:_customModel.imageUrl] placeholderImage:[UIImage imageNamed:@"photo.jpg"]];
    _botlabel.text = _customModel.name;
}

@end
