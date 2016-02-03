#import <UIKit/UIKit.h>

@class DLRadioButton, DLRadioGroup;

@protocol DLRadioGroupDelegate <NSObject>

@optional
- (void)dlRadioGroup:(DLRadioGroup *)radioGroup didSelect:(DLRadioButton *)radioButton;

@end

@interface DLRadioGroup : NSObject

@property (nonatomic, copy) IBOutletCollection(DLRadioButton) NSMutableArray *radioButtons;
@property (nonatomic, weak) IBOutlet id<DLRadioGroupDelegate> delegate;

/**
 Whether enable multiple selection, default is NO.
 */
@property (nonatomic, getter=isMultipleSelectionEnabled) IBInspectable BOOL multipleSelectionEnabled;

/**
 @return Radio group with radio buttons
 */
- (id)initWithRadioButtons:(NSArray *)radioButtons;

/**
 Selects a radio button
 */
- (void)selectRadioButton:(DLRadioButton *)radioButton;

/**
 If multiple selection is disabled: clears current selection and selects button with given tag;
 If multiple selection is enabled: keeps the current selection and selects button or buttons with given tag.
 */
- (void)selectRadioButtonWithTag:(NSInteger)tag;

/**
 Deselects all radio buttons
 */
- (void)deselectAllRadioButtons;

/**
 Adds a radio button in the group
 */
- (void)addRadioButton:(DLRadioButton *)radioButton;

/**
 Removes a radio button from group
 */
- (void)removeRadioButton:(DLRadioButton *)radioButton;

/**
 @return Selected button in group
 */
- (DLRadioButton *)selectedRadioButton;

/**
 @return Selected buttons in group, use it only if multiple selection is enabled.
 */
- (NSArray *)selectedRadioButtons;

@end
