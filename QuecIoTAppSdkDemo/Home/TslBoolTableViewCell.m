//
//  TslBoolTableViewCell.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import "TslBoolTableViewCell.h"
@interface TslBoolTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UISwitch *state;
@property (nonatomic, strong) QuecProductTSLPropertyModel *dataModel;
@property (nonatomic, assign) NSInteger index;

@end

@implementation TslBoolTableViewCell

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
        
        _state = [[UISwitch alloc] initWithFrame:CGRectMake(20, 80, 200, 40)];
        [_state addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_state];
        
    }
    return self;
}

- (void)stateChanged:(UISwitch *)state {
    NSLog(@"stateChanged: %ld",state.on);
    if (self.delegate && [self.delegate respondsToSelector:@selector(stateChanged:index:)]) {
        [self.delegate stateChanged:state.on ? (@"true") : (@"false") index:self.index];
    }
}

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model index:(NSInteger)index {
    self.dataModel = model;
    self.index = index;
    NSString *subType = @"读写";
    if ([QuecProductionTslSubTypeR isEqualToString:model.subType]) {
        subType = @"只读";
        _state.userInteractionEnabled = NO;
    }
    NSString *value = model.attributeValue;
    value = [NSString deletEmpty:value];
    for (int i = 0; i < model.formatSpecs.count; i ++) {
        QuecProductTSLSpecModel *specModel = model.formatSpecs[i];
        if ([specModel.value isEqualToString:value]) {
            self.valueLabel.text = specModel.name;
            break;
        }
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@布尔",subType];
    [_state setOn:[model.attributeValue boolValue]];
}

@end
