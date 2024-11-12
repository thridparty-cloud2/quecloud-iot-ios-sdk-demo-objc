//
//  BleDeviceListTableViewCell.m
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 2023/6/14.
//

#import "BleDeviceListTableViewCell.h"

@implementation BleDeviceBindModel

@end

@interface BleDeviceListTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *bindButton;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) BleDeviceBindModel *bindModel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation BleDeviceListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self nameLabel];
        [self bindButton];
        [self subTitleLabel];
    }
    return self;
}

- (void)configureModel:(BleDeviceBindModel *)model indexPath:(NSIndexPath *)indexPath{
    self.bindModel = model;
    self.indexPath = indexPath;
    self.nameLabel.text = model.peripheral.deviceName;
    self.bindButton.hidden = YES;
    self.subTitleLabel.hidden = YES;
    switch (_bindModel.bindState) {
        case QuecWaitingBind:
            self.bindButton.hidden = NO;
            break;
        case QuecBinding:
            self.subTitleLabel.hidden = NO;
            self.subTitleLabel.text = @"绑定中..";
            break;
        case QuecBindingSucc:
            self.subTitleLabel.hidden = NO;
            self.subTitleLabel.text = @"绑定成功";
            break;
        case QuecBindingFail:
            self.subTitleLabel.hidden = NO;
            self.subTitleLabel.text = model.errorMsg ? : @"";
            break;
        default:
            break;
    }
}

- (void)startBinding{
    if (self.bindAction){
        self.bindAction(self.indexPath);
    }
}

- (UILabel *)nameLabel{
    if (!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self);
        }];
    }
    return _nameLabel;
}

- (UIButton *)bindButton{
    if (!_bindButton){
        _bindButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_bindButton setTitle:@"开始绑定" forState:(UIControlStateNormal)];
        [_bindButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        _bindButton.layer.borderWidth = 1.f;
        _bindButton.layer.borderColor = UIColor.blackColor.CGColor;
        _bindButton.layer.masksToBounds = YES;
        [_bindButton addTarget:self action:@selector(startBinding) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_bindButton];
        [_bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(self);
        }];
    }
    return _bindButton;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.hidden = YES;
        [self.contentView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(self);
            make.height.equalTo(@60);
        }];
    }
    return _subTitleLabel;
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
