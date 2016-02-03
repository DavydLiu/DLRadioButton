#import <UIKit/UIKit.h>

#import "DLRadioGroup.h"

/**
 A hightly customizable Radio Button for iOS.
*/
IB_DESIGNABLE
@interface DLRadioButton : UIButton

@property (nonatomic, weak, readonly) DLRadioGroup *radioGroup;

/**
 Size of icon, default is kDefaulIconSize.
*/
@property (nonatomic) IBInspectable CGFloat iconSize;

/**
 Color of icon, default is title color for current UIControlState.
 */
@property (nonatomic) IBInspectable UIColor *iconColor;

/**
 Stroke width of icon, default is iconSize / 9.
 */
@property (nonatomic) IBInspectable CGFloat iconStrokeWidth;

/**
 Size of selection indicator, default is iconSize * 0.5.
 */
@property (nonatomic) IBInspectable CGFloat indicatorSize;

/**
 Color of selection indicator, default is title color for current UIControlState.
*/
@property (nonatomic) IBInspectable UIColor *indicatorColor;

/**
 Margin width between icon and title, default is kDefaultMarginWidth.
 */
@property (nonatomic) IBInspectable CGFloat marginWidth;

/**
 Whether icon on the right side, default is NO.
*/
@property (nonatomic, getter=isIconOnRight) IBInspectable BOOL iconOnRight;

/**
 Whether use square icon, default is NO.
*/
@property (nonatomic, getter=isIconSquare) IBInspectable BOOL iconSquare;

/**
 Image for radio button icon (optional).
 */
@property (nonatomic) IBInspectable UIImage *icon;

/**
 Image for radio button icon when selected (optional).
 */
@property (nonatomic) IBInspectable UIImage *iconSelected;

- (void)willAddToRadioGroup:(DLRadioGroup *)radioGroup;
- (void)didAddToRadioGroup:(DLRadioGroup *)radioGroup;
- (void)removeFromRadioGroup;
- (void)willRemoveFromRadioGroup:(DLRadioGroup *)radioGroup;
- (void)didRemoveFromRadioGroup:(DLRadioGroup *)radioGroup;

@end
