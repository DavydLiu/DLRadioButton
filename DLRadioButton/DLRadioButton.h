#import <UIKit/UIKit.h>

/**
 A hightly customizable Radio Button for iOS
*/
IB_DESIGNABLE
@interface DLRadioButton : UIButton

/**@name Properties*/
/**
 Container for holding other buttons
*/
@property (nonatomic) IBOutletCollection(DLRadioButton) NSArray *otherButtons;
/**
 Image for radio button icon (optional)
*/
@property (nonatomic) IBInspectable UIImage *icon;
/**
 Image for radio button icon when selected (optional)
*/
@property (nonatomic) IBInspectable UIImage *iconSelected;
/**
 Size of icon
*/
@property (nonatomic) IBInspectable CGFloat iconSize;
/**
 Color of icon
 */
@property (nonatomic) IBInspectable UIColor *iconColor;
/**
 Stroke width of icon
 */
@property (nonatomic) IBInspectable CGFloat iconStrokeWidth;
/**
 Size of selection indicator
 */
@property (nonatomic) IBInspectable CGFloat indicatorSize;
/**
 Color of selection indicator
*/
@property (nonatomic) IBInspectable UIColor *indicatorColor;
/**
 Margin width between icon and title
 */
@property (nonatomic) IBInspectable CGFloat marginWidth;
/**
 Whether icon on the right side
*/
@property (nonatomic) IBInspectable BOOL isIconOnRight;
/**
 Whether use square icon
*/
@property (nonatomic) IBInspectable BOOL isIconSquare;

/**
 @return Current selected button
 */
- (DLRadioButton *)selectedButton;

/**
 Clear selection for other buttons
*/
- (void)deselectOtherButtons;

@end
