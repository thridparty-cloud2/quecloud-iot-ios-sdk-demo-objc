//
//  TslEnumAndDateTableViewCell.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import "TslEnumAndDateTableViewCell.h"

@interface TslEnumAndDateTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) QuecProductTSLPropertyModel *dataModel;


@end

@implementation TslEnumAndDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 20)];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"6666";
        [self.contentView addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 20)];
        _valueLabel.text = @"123";
        _valueLabel.textColor = [UIColor lightGrayColor];
        _valueLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_valueLabel];
        
    }
    return self;
}

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model {
    self.dataModel = model;
    NSString *subType = @"读写";
    NSString *dataType = @"";
    NSString *value = [NSString deletEmpty:model.attributeValue];
    if ([QuecProductionTslSubTypeR isEqualToString:model.subType]) {
        subType = @"只读";
    }
    if ([QuecProductionTslDataTypeENUM isEqualToString:model.dataType] ) {
        dataType = @"枚举";
        for (int i = 0; i < model.formatSpecs.count; i ++) {
            QuecProductTSLSpecModel *specModel = model.formatSpecs[i];
            if ([specModel.value isEqualToString:value]) {
                self.valueLabel.text = specModel.name;
                break;
            }
        }
    }
    else {
        dataType = @"日期";
        self.valueLabel.text = model.attributeValue;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",subType,dataType];
   
}

@end
