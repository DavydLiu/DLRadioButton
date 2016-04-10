#import <UIKit/UIKit.h>

/**
 *  A hightly customizable Radio Button for iOS.
 */
IB_DESIGNABLE
@interface DLRadioButton : UIButton

#pragma mark - Access buttons

/**
 *  Finds out selected button in same group.
 *
 *  @return Selected button.
 */
- (nullable DLRadioButton *)selectedButton;

/**
 *  Finds out selected buttons in same group, use it only if multiple selection is enabled.
 *
 *  @return Selected buttons.
 */
- (nonnull NSArray<DLRadioButton *> *)selectedButtons;

/**
 *  Container for holding other buttons in same group.
 */
@property (nonnull, nonatomic) IBOutletCollection(DLRadioButton) NSArray<DLRadioButton *> *otherButtons;

/**
 *  Clears selection for other buttons in in same group.
 */
- (void)deselectOtherButtons;

#pragma mark - Customization

NS_ASSUME_NONNULL_BEGIN
/**
 *  Size of icon, default is kDefaulIconSize.
 */
@property (nonatomic) IBInspectable CGFloat iconSize;

/**
 *  Color of icon, default is title color for current UIControlState.
 */
@property (nonatomic) IBInspectable UIColor *iconColor;

/**
 *  Stroke width of icon, default is iconSize / 9.
 */
@property (nonatomic) IBInspectable CGFloat iconStrokeWidth;

/**
 *  Size of selection indicator, default is iconSize * 0.5.
 */
@property (nonatomic) IBInspectable CGFloat indicatorSize;

/**
 *  Color of selection indicator, default is title color for current UIControlState.
 */
@property (nonatomic) IBInspectable UIColor *indicatorColor;

/**
 *  Margin width between icon and title, default is kDefaultMarginWidth.
 */
@property (nonatomic) IBInspectable CGFloat marginWidth;

/**
 *  Whether icon on the right side, default is NO.
 *  @warning Please also set contentHorizontalAlignment to UIControlContentHorizontalAlignmentRight.
 */
@property (nonatomic, getter = isIconOnRight) IBInspectable BOOL iconOnRight;

/**
 *  Whether use square icon, default is NO.
 */
@property (nonatomic, getter = isIconSquare) IBInspectable BOOL iconSquare;

/**
 *  Image for radio button icon (optional).
 */
@property (nonatomic) IBInspectable UIImage *icon;

/**
 *  Image for radio button icon when selected (optional).
 */
@property (nonatomic) IBInspectable UIImage *iconSelected;

/**
 *  Whether enable multiple selection, default is NO.
 */
@property (nonatomic, getter = isMultipleSelectionEnabled) BOOL multipleSelectionEnabled;
NS_ASSUME_NONNULL_END

@end
