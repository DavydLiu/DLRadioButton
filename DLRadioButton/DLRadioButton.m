#import "DLRadioButton.h"

static const CGFloat kDefaulIconSize = 15.0;
static const CGFloat kDefaultMarginWidth = 5.0;
static NSString *const kGeneratedIconName = @"Generated Icon";

@implementation DLRadioButton

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    [self setImage:self.icon forState:UIControlStateNormal];
}

- (void)setIconSelected:(UIImage *)iconSelected
{
    _iconSelected = iconSelected;
    [self setImage:self.iconSelected forState:UIControlStateSelected];
    [self setImage:self.iconSelected forState:UIControlStateSelected | UIControlStateHighlighted];
}

#pragma mark - Helpers

- (void)drawButton
{
    if (!self.icon || [self.icon.accessibilityIdentifier isEqualToString:kGeneratedIconName]) {
        self.icon = [self drawIconWithSelection:NO];
    }
    if (!self.iconSelected || [self.iconSelected.accessibilityIdentifier isEqualToString:kGeneratedIconName]) {
        self.iconSelected = [self drawIconWithSelection:YES];
    }
    CGFloat marginWidth = self.marginWidth ? self.marginWidth : kDefaultMarginWidth;
    if (self.isIconOnRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.icon.size.width, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.icon.size.width, 0, marginWidth + self.icon.size.width);
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0);
    }
}

- (UIImage *)drawIconWithSelection:(BOOL)selected
{
    UIColor *defaulColor = selected ? [self titleColorForState:UIControlStateSelected | UIControlStateHighlighted] : [self titleColorForState:UIControlStateNormal];
    UIColor *iconColor = self.iconColor ? self.iconColor : defaulColor;
    UIColor *indicatorColor = self.indicatorColor ? self.indicatorColor : defaulColor;
    CGFloat iconSize = self.iconSize ? self.iconSize : kDefaulIconSize;
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
    
    image.accessibilityIdentifier = kGeneratedIconName;
    return image;
}

- (void)touchDown
{
    NSAssert(self.radioGroup != nil, @"Radio button has to be in a radio group");
    
    [self.radioGroup selectRadioButton:self];
}

- (void)initRadioButton
{
    [super addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForInterfaceBuilder
{
    [self initRadioButton];
    [self drawButton];
}

#pragma mark - UIButton

- (UIColor *)titleColorForState:(UIControlState)state
{
    UIColor *normalColor = [super titleColorForState:UIControlStateNormal];
    if (state == (UIControlStateSelected | UIControlStateHighlighted)) {
        UIColor *selectedOrHighlightedColor = [super titleColorForState:UIControlStateSelected | UIControlStateHighlighted];
        if (selectedOrHighlightedColor == normalColor || selectedOrHighlightedColor == nil) {
            selectedOrHighlightedColor = [super titleColorForState:UIControlStateSelected];
        }
        if (selectedOrHighlightedColor == normalColor || selectedOrHighlightedColor == nil) {
            selectedOrHighlightedColor = [super titleColorForState:UIControlStateHighlighted];
        }
        [self setTitleColor:selectedOrHighlightedColor forState:UIControlStateSelected | UIControlStateHighlighted];
    }
    
    return [super titleColorForState:state];
}

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initRadioButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initRadioButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawButton];
}

- (void)willAddToRadioGroup:(DLRadioGroup *)radioGroup
{
    if (self.radioGroup != nil) {
        [self.radioGroup removeRadioButton:self];
    }
}

- (void)didAddToRadioGroup:(DLRadioGroup *)radioGroup
{
    _radioGroup = radioGroup;
}

- (void)removeFromRadioGroup
{
    if (self.radioGroup != nil) {
        [self.radioGroup removeRadioButton:self];
    }
}

- (void)willRemoveFromRadioGroup:(DLRadioGroup *)radioGroup
{
}

- (void)didRemoveFromRadioGroup:(DLRadioGroup *)radioGroup
{
    _radioGroup = nil;
}

@end