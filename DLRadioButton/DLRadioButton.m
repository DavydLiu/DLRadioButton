#import "DLRadioButton.h"

static const CGFloat defaulIconSize = 15.0;
static const CGFloat defaultMarginWidth = 5.0;

@interface DLRadioButton()
@property BOOL isChaining;
@end

@implementation DLRadioButton

- (void)setOtherButtons:(NSArray *)otherButtons {
    if (!self.isChaining) {
        _otherButtons = otherButtons;
        self.isChaining = YES;
        for (DLRadioButton *radioButton in self.otherButtons) {
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:self.otherButtons];
            [otherButtons addObject:self];
            [otherButtons removeObject:radioButton];
            [radioButton setOtherButtons:[otherButtons copy]];
        }
        self.isChaining = NO;
    }
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    [self setImage:self.icon forState:UIControlStateNormal];
}

- (void)setIconSelected:(UIImage *)iconSelected {
    _iconSelected = iconSelected;
    [self setImage:self.iconSelected forState:UIControlStateSelected];
    [self setImage:self.iconSelected forState:UIControlStateSelected | UIControlStateHighlighted];
}

#pragma mark - Helpers

- (void)drawButton {
    if (!self.icon) {
        self.icon = [self drawIconWithSelection:NO];
    }
    if (!self.iconSelected) {
        self.iconSelected = [self drawIconWithSelection:YES];
    }
    CGFloat marginWidth = self.marginWidth ? self.marginWidth : defaultMarginWidth;
    if (self.isIconOnRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.icon.size.width, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.icon.size.width, 0, marginWidth + self.icon.size.width);
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0);
    }
}

- (UIImage *)drawIconWithSelection:(BOOL)selected {
    UIColor *iconColor = self.iconColor ? self.iconColor : self.titleLabel.textColor;
    UIColor *indicatorColor = self.indicatorColor ? self.indicatorColor : self.titleLabel.textColor;
    CGFloat iconSize = self.iconSize ? self.iconSize : defaulIconSize;
    CGFloat iconStrokeWidth = self.iconStrokeWidth ? self.iconStrokeWidth : iconSize / 9;
    CGFloat indicatorSize = self.indicatorSize ? self.indicatorSize : iconSize * 0.5;
    
    CGRect rect = CGRectMake(0, 0, iconSize, iconSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // draw icon
    UIBezierPath* iconPath;
    CGRect iconRect = CGRectMake(iconStrokeWidth / 2, iconStrokeWidth / 2, iconSize - iconStrokeWidth, iconSize - iconStrokeWidth);
    if (self.isIconSquare) {
        iconPath = [UIBezierPath bezierPathWithRect:iconRect];
    } else {
        iconPath = [UIBezierPath bezierPathWithOvalInRect:iconRect];
    }
    [iconColor setStroke];
    iconPath.lineWidth = iconStrokeWidth;
    [iconPath stroke];
    CGContextAddPath(context, iconPath.CGPath);
    
    // draw indicator
    if (selected) {
        UIBezierPath* indicatorPath;
        CGRect indicatorRect = CGRectMake((iconSize - indicatorSize) / 2, (iconSize - indicatorSize) / 2, indicatorSize, indicatorSize);
        if (self.isIconSquare) {
            indicatorPath = [UIBezierPath bezierPathWithRect:indicatorRect];
        } else {
            indicatorPath = [UIBezierPath bezierPathWithOvalInRect:indicatorRect];
        }
        [indicatorColor setFill];
        [indicatorPath fill];
        CGContextAddPath(context, indicatorPath.CGPath);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)touchDown {
    [self setSelected:YES];
}

- (void)initRadioButton {
    [super addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
}

- (void)prepareForInterfaceBuilder {
    [self initRadioButton];
    [self drawButton];
}

#pragma mark - DLRadiobutton

- (void)deselectOtherButtons {
    for (UIButton *button in self.otherButtons) {
        [button setSelected:NO];
    }
}

- (DLRadioButton *)selectedButton {
    if (self.selected) {
        return self;
    } else {
        for (DLRadioButton *radioButton in self.otherButtons) {
            if (radioButton.selected) {
                return radioButton;
            }
        }
        return nil;
    }
}

#pragma mark - UIControl

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self deselectOtherButtons];
    }
}

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initRadioButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initRadioButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawButton];
}

@end
