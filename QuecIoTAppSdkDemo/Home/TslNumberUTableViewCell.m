//
//  TslUTableViewCell.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/3.
//

#import "TslNumberUTableViewCell.h"

@interface TslNumberUTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) QuecProductTSLPropertyModel *dataModel;
@property (nonatomic, assign) NSInteger index;

@end

@implementation TslNumberUTableViewCell

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
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 20)];
        _slider.minimumTrackTintColor = [UIColor orangeColor];
        _slider.maximumTrackTintColor = [UIColor lightGrayColor];
        _slider.continuous = NO;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_slider];
    }
    return self;
}

- (void)sliderValueChanged:(UISlider *)slider {
    NSLog(@"sliderValueChanged: %f",slider.value);
    QuecProductTSLSpecModel *specModel = self.dataModel.formatSpecs[0];
    if ([QuecProductionTslDataTypeINT isEqualToString:self.dataModel.dataType] ) {
        NSInteger value = slider.value;
        NSInteger step = [specModel.step integerValue];
        if (value % step) {
            value = step * (value / step);
        }
        self->_valueLabel.text = [NSString stringWithFormat:@"%ld",(long)value];
    }
    else if ([QuecProductionTslDataTypeFLOAT isEqualToString:self.dataModel.dataType] ) {
        self->_valueLabel.text = [NSString stringWithFormat:@"%f",slider.value];
       
    }
    else {
        self->_valueLabel.text = [NSString stringWithFormat:@"%lf",slider.value];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(valueChanged:index:)]) {
        [self.delegate valueChanged:self->_valueLabel.text index:self.index];
    }
}

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model index:(NSInteger)index {
    self.dataModel = model;
    self.index = index;
    NSString *subType = @"读写";
    NSString *dataType = @"";
    if ([QuecProductionTslSubTypeR isEqualToString:model.subType]) {
        subType = @"只读";
        _slider.userInteractionEnabled = NO;
    }
    
    NSString *value = model.attributeValue;
    value = [NSString deletEmpty:value];
    self.valueLabel.text = value.length ? (value) : (@"0");
    QuecProductTSLSpecModel *specModel = model.formatSpecs[0];
    _slider.maximumValue = specModel.max.integerValue;
    _slider.minimumValue = specModel.min.integerValue;
    
    if ([QuecProductionTslDataTypeINT isEqualToString:model.dataType] ) {
        dataType = @"整型";
        [_slider setValue:value.integerValue];
    }
    else if ([QuecProductionTslDataTypeFLOAT isEqualToString:model.dataType] ) {
        dataType = @"单精度浮点型";
        [_slider setValue:value.floatValue];
    }
    else {
        dataType = @"双精度浮点型";
        [_slider setValue:value.doubleValue];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",subType,dataType];
    
   
}

@end
