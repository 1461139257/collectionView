//
//  CustomTableViewCell.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "CustomTableViewCell.h"


@interface CustomTableViewCell ()

@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView  *backLineView;

@end

@implementation CustomTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        WS(ws);
        _nickNameLabel = [UILabel new];
        [self.contentView addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(10);
            make.top.equalTo(ws).offset(5);
            make.right.equalTo(ws).offset(-10);
            make.height.mas_offset(20);
        }];
        
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(10);
            make.top.equalTo(ws.nickNameLabel.mas_bottom).offset(5);
            make.right.equalTo(ws).offset(-10);
            make.bottom.equalTo(ws).offset(-5);
        }];
        
        _backLineView = [UIView new];
        _backLineView.backgroundColor = [Global convertHexToRGB:@"dcdcdc"];
        [self.contentView addSubview:_backLineView];
        [_backLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws).offset(0);
            make.height.mas_equalTo(@1);
        }];
        
    }
    return self;
}

-(void)setCustModel:(CustomModel *)custModel{
    
    _custModel = custModel;
    _nickNameLabel.text = _custModel.nickName;
    _contentLabel.text = _custModel.content;
    
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
