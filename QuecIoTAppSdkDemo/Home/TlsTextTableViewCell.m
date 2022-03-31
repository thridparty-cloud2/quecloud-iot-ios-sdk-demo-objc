//
//  TlsTextTableViewCell.m
//  QuecDeviceKitExample
//
//  Created by quectel.steven on 2021/11/4.
//

#import "TlsTextTableViewCell.h"
@interface TlsTextTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *content;
@property (nonatomic, strong) QuecProductTSLPropertyModel *dataModel;

@end
@implementation TlsTextTableViewCell

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
        
        _content = [[UITextView alloc] initWithFrame:CGRectMake(20, 40, [UIScreen mainScreen].bounds.size.width - 40, 70)];
        _content.textColor = [UIColor lightGrayColor];
        _content.font = [UIFont systemFontOfSize:12];
        _content.text = @"666666666666666";
        _content.userInteractionEnabled = NO;
        [self.contentView addSubview:_content];
    }
    return self;
}

- (void)refreshCellWithModel:(QuecProductTSLPropertyModel *)model {
    self.dataModel = model;
    NSString *subType = @"读写";
    if ([QuecProductionTslSubTypeR isEqualToString:model.subType]) {
        subType = @"只读";
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@文本",subType];
    _content.text = [NSString deletEmpty:model.attributeValue];
}

@end
