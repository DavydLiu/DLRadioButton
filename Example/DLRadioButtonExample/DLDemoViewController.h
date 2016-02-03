#import <UIKit/UIKit.h>
#import "DLRadioButton.h"

@interface DLDemoViewController : UIViewController <DLRadioGroupDelegate>

@property (nonatomic, weak) IBOutlet DLRadioGroup *circularRadioGroup;
@property (nonatomic, weak) IBOutlet DLRadioGroup *squareRadioGroup;
@property (nonatomic, weak) IBOutlet DLRadioGroup *customImageRadioGroup;

@end
