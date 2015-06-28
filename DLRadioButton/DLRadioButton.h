#import <UIKit/UIKit.h>

/**
 A hightly customizable Radio Button for iOS
*/
IB_DESIGNABLE
@interface DLRadioButton : UIButton

/**@name Properties*/
/**
 Container for holding other related radio buttons
*/
@property (nonatomic) IBOutletCollection(DLRadioButton) NSArray *otherButtons;
/**
 Image for radio button (optional)
*/
@property (nonatomic) IBInspectable UIImage *icon;
/**
 Image for radio button when selected (optional)
*/
@property (nonatomic) IBInspectable UIImage *iconSelected;
/**
 Size of the radio button
*/
@property (nonatomic) IBInspectable CGFloat size;
/**
 Margin width between button icon and button title
 */
@property (nonatomic) IBInspectable CGFloat marginWidth;
/**
 Color of the circle button icon
*/
@property (nonatomic) IBInspectable UIColor *circleColor;
/**
 Radius of the circle button icon
*/
@property (nonatomic) IBInspectable CGFloat circleRadius;
/**
 Stroke width of circle button icon
 */
@property (nonatomic) IBInspectable CGFloat circleStrokeWidth;
/**
 Color of selection indicator
*/
@property (nonatomic) IBInspectable UIColor *indicatorColor;
/**
 Radius of selection indicator
*/
@property (nonatomic) IBInspectable CGFloat indicatorRadius;
/**
 Whether icon on the right side
*/
@property (nonatomic) IBInspectable BOOL iconOnRight;

/**
 Clear selection for all the buttons
*/
- (void)deselectOtherButtons;

/**
 @return Current selected button
*/
- (DLRadioButton *)selectedButton;

@end
