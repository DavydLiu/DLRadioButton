#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IconPosition) {
    IconPositionLeft    =0,
    IconPositionRight   =1,
    IconPositionTop     =2,
    IconPositionBottom  =3
};

/**
 * A hightly customizable Radio Button for iOS.
 */
IB_DESIGNABLE
NS_ASSUME_NONNULL_BEGIN
@interface DLRadioButton : UIButton

#pragma mark - Access buttons

/**
 * @brief Finds out selected button in same group.
 * @return Selected button.
 */
- (nullable DLRadioButton *)selectedButton;

/**
 * @brief Finds out selected buttons in same group, use it only if multiple selection is enabled.
 * @return Selected buttons.
 */
- (NSArray<DLRadioButton *> *)selectedButtons;

/**
 * @brief Container for holding other buttons in same group.
 */
@property (nonatomic) IBOutletCollection(DLRadioButton) NSArray<DLRadioButton *> *otherButtons;

/**
 * @brief Clears selection for other buttons in in same group.
 */
- (void)deselectOtherButtons;

#pragma mark - Customization

/**
 * @brief Size of icon, default is kDefaulIconSize.
 */
@property (nonatomic) IBInspectable CGFloat iconSize;

/**
 * @brief Color of icon, default is title color for current UIControlState.
 */
@property (nonatomic) IBInspectable UIColor *iconColor;

/**
 * @brief Stroke width of icon, default is iconSize / 9.
 */
@property (nonatomic) IBInspectable CGFloat iconStrokeWidth;

/**
 * @brief Size of selection indicator, default is iconSize * 0.5.
 */
@property (nonatomic) IBInspectable CGFloat indicatorSize;

/**
 * @brief Color of selection indicator, default is title color for current UIControlState.
 */
@property (nonatomic) IBInspectable UIColor *indicatorColor;

/**
 * @brief Margin width between icon and title, default is kDefaultMarginWidth.
 */
@property (nonatomic) IBInspectable CGFloat marginWidth;

/**
 * @brief Whether icon on the right side, default is NO.
 * @warning Please also set contentHorizontalAlignment to UIControlContentHorizontalAlignmentRight.
 */
@property (nonatomic, getter = isIconOnRight) IBInspectable BOOL iconOnRight;

/**
 * @brief Icon position: Left, Right, Top or Bottom, default to Left.
 * @warning If position is Right, please also set contentHorizontalAlignment to UIControlContentHorizontalAlignmentRight.
 * @warning If position is Top or Bottom, please also set contentVerticalAlignment to UIControlContentVerticalAlignmentTop.
 * @warning If position is Bottom, please also set contentVerticalAlignment to UIControlContentVerticalAlignmentBottom.
 */
@property (nonatomic) IBInspectable IconPosition iconPosition;

/**
 * @brief Whether use square icon, default is NO.
 */
@property (nonatomic, getter = isIconSquare) IBInspectable BOOL iconSquare;

/**
 * @brief Image for radio button icon (optional).
 */
@property (nonatomic) IBInspectable UIImage *icon;

/**
 * @brief Image for radio button icon when selected (optional).
 */
@property (nonatomic) IBInspectable UIImage *iconSelected;

/**
 * @brief Whether enable multiple selection, default is NO.
 */
@property (nonatomic, getter = isMultipleSelectionEnabled) BOOL multipleSelectionEnabled;

/**
 * @brief Duration of radio button icon animation in seconds. Set it to 0.0 to turn off animation, default is 0.3.
 */
@property (nonatomic) CFTimeInterval animationDuration;

@end
NS_ASSUME_NONNULL_END
