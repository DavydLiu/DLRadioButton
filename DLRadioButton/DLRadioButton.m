#import "DLRadioButton.h"

static CGFloat defaultSize = 30.0;
static CGFloat defaultMarginWidth = 5.0;
static CGFloat defaultIndicatorRadius = 5.0;
static CGFloat defaultCircleRadius = 11;
static CGFloat defaultStrokeWidh = 3.0;

@interface DLRadioButton ()

@end

@implementation DLRadioButton

#pragma mark - Helpers

- (void)drawButton {
    if (!self.icon) {
        self.icon = [self drawIconWithSelection:NO];
    }
    if (!self.iconSelected) {
        self.iconSelected = [self drawIconWithSelection:YES];
    }
    if (![self imageForState:UIControlStateNormal] || ![self imageForState:UIControlStateSelected]) {
        [self setImage:self.icon forState:UIControlStateNormal];
        [self setImage:self.iconSelected forState:UIControlStateSelected];
    }
    CGFloat marginWidth = self.marginWidth ? self.marginWidth : defaultMarginWidth;
    if (self.iconOnRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.icon.size.width, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.icon.size.width, 0, marginWidth + self.icon.size.width);
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0);
    }
    [self chainButtons];
    if (![[self allTargets] containsObject:self]) {
        [super addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    }
}

- (UIImage *)drawIconWithSelection:(BOOL)selected {
    UIColor *circleColor = self.circleColor ? self.circleColor : self.titleLabel.textColor;
    UIColor *indicatorColor = self.indicatorColor ? self.indicatorColor : self.titleLabel.textColor;
    CGFloat size = self.size ? self.size : defaultSize;
    CGFloat indicatorRadius = self.indicatorRadius ? self.indicatorRadius : defaultIndicatorRadius;
    CGFloat circleRadius = self.circleRadius ? self.circleRadius : defaultCircleRadius;
    CGFloat strokeWidth = self.circleStrokeWidth ? self.circleStrokeWidth : defaultStrokeWidh;
    
    CGRect rect = CGRectMake(0.0, 0.0, size, size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    if (selected) {
        // draw indicator
        UIBezierPath* indicatorPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(size/2 - indicatorRadius, size/2 - indicatorRadius, indicatorRadius*2, indicatorRadius*2)];
        [indicatorColor setFill];
        [indicatorPath fill];
        CGContextAddPath(context, indicatorPath.CGPath);
    }
    
    // draw circle
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(size/2 - circleRadius, size/2 - circleRadius, circleRadius*2, circleRadius*2)];
    [circleColor setStroke];
    circlePath.lineWidth = strokeWidth;
    [circlePath stroke];
    CGContextAddPath(context, circlePath.CGPath);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)chainButtons {
    if ([self.otherButtons count] > 0) {
        for (DLRadioButton *radioButton in self.otherButtons) {
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:self.otherButtons];
            [otherButtons addObject:self];
            [otherButtons removeObject:radioButton];
            [radioButton setOtherButtons:[otherButtons copy]];
        }
    }
}

- (void)touchDown {
    [self setSelected:YES];
}

- (void)prepareForInterfaceBuilder {
    [self drawButton];
}

#pragma mark - DLRadiobutton

- (void)deselectOtherButtons {
    if ([self.otherButtons count] > 0) {
        for (UIButton *button in self.otherButtons) {
            [button setSelected:NO];
        }
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

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawButton];
}

@end
