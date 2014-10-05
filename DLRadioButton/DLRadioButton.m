//
//  DLRadioButton.m
//  DLRadioButtonExample
//
//  Created by Liu, Xingruo on 8/22/14.
//

#import "DLRadioButton.h"

static CGFloat defaultButtonSideLength = 30.0;
static CGFloat defaultRightMarginWidth = 5.0;
static CGFloat defaultIndicatorRadius = 5.0;
static CGFloat defaultCircleRadius = 11;
static CGFloat defaultStrokeWidh = 3.0;

@interface DLRadioButton ()

@end

@implementation DLRadioButton

#pragma mark - Helpers

- (void)initilizeButton {
    if (!self.ButtonIcon) {
        self.ButtonIcon = [self drawIconWithSelection:NO];
    }
    if (!self.ButtonIconSelected) {
        self.ButtonIconSelected = [self drawIconWithSelection:YES];
    }
    if (![self imageForState:UIControlStateNormal] || ![self imageForState:UIControlStateSelected]) {
        [self setImage:self.ButtonIcon forState:UIControlStateNormal];
        [self setImage:self.ButtonIconSelected forState:UIControlStateSelected];
    }
    self.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightMarginWidth ? self.rightMarginWidth : defaultRightMarginWidth, 0, 0);
    [self chainButtons];
    if(![[self allTargets] containsObject:self]) {
        [super addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    }
}

- (UIImage*)drawIconWithSelection:(BOOL)selected
{
    UIColor *circleColor = self.circleColor ? self.circleColor : self.titleLabel.textColor;
    UIColor *indicatorColor = self.indicatorColor ? self.indicatorColor : self.titleLabel.textColor;
    CGFloat buttonSideLength = self.buttonSideLength ? self.buttonSideLength : defaultButtonSideLength;
    CGFloat indicatorRadius = self.indicatorRadius ? self.indicatorRadius : defaultIndicatorRadius;
    CGFloat circleRadius = self.circleRadius ? self.circleRadius : defaultCircleRadius;
    CGFloat strokeWidth = self.circleStrokeWidth ? self.circleStrokeWidth : defaultStrokeWidh;
    
    CGRect rect = CGRectMake(0.0, 0.0, buttonSideLength, buttonSideLength);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    if (selected) {
        // indicator Drawing
        UIBezierPath* indicatorPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(buttonSideLength/2 - indicatorRadius, buttonSideLength/2 - indicatorRadius, indicatorRadius*2, indicatorRadius*2)];
        [indicatorColor setFill];
        [indicatorPath fill];
        CGContextAddPath(context, indicatorPath.CGPath);
    }
    
    // circle Drawing
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(buttonSideLength/2 - circleRadius, buttonSideLength/2 - circleRadius, circleRadius*2, circleRadius*2)];
    [circleColor setStroke];
    circlePath.lineWidth = strokeWidth;
    [circlePath stroke];
    CGContextAddPath(context, circlePath.CGPath);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)chainButtons
{
    if ([self.otherButtons count] > 0) {
        for (DLRadioButton *radioButton in self.otherButtons) {
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:self.otherButtons];
            [otherButtons addObject:self];
            [otherButtons removeObject:radioButton];
            [radioButton setOtherButtons:[otherButtons copy]];
        }
    }
}

- (void)touchDown
{
    [self setSelected:YES];
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self initilizeButton];
}

#pragma mark - DLRadiobutton

- (void)deselectOtherButtons
{
    if ([self.otherButtons count] > 0) {
        for (UIButton *button in self.otherButtons) {
            [button setSelected:NO];
        }
    }
}

- (DLRadioButton *)selectedButton
{
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

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self deselectOtherButtons];
    }
}

@end
