#import "DLRadioGroup.h"

#import "DLRadioButton.h"

@implementation DLRadioGroup

- (id)init
{
    self = [super init];
    
    if (self) {
        if (self.radioButtons == nil) {
            _radioButtons = [NSSet new];
        } else {
            for (DLRadioButton *radioButton in self.radioButtons) {
                [self addRadioButton:radioButton];
            }
        }
    }
    
    return self;
}

- (id)initWithRadioButtons:(NSArray *)radioButtons
{
    self = [super init];
    
    if (self) {
        for (DLRadioButton *radioButton in radioButtons) {
            [self addRadioButton:radioButton];
        }
    }
    
    return self;
}

- (void)selectRadioButton:(DLRadioButton *)radioButton
{
    if (radioButton.radioGroup != self) {
#ifdef DEBUG
        NSLog(@"Trying to select a radio button that is in another radio group. Ignored.");
#endif
        return;
    }
    
    if (self.multipleSelectionEnabled) {
        radioButton.selected = YES;
        
    } else {
        [self deselectAllRadioButtons];
        radioButton.selected = YES;
    }
    
    [self fireDidSelectDelegateWithRadioButton:radioButton];
}

- (void)selectRadioButtonWithTag:(NSInteger)tag
{
    if (self.multipleSelectionEnabled) {
        for (DLRadioButton *radioButton in self.radioButtons) {
            if (radioButton.tag == tag) {
                radioButton.selected = YES;
                [self fireDidSelectDelegateWithRadioButton:radioButton];
            }
        }
    } else {
        [self deselectAllRadioButtons];
        for (DLRadioButton *radioButton in self.radioButtons) {
            if (radioButton.tag == tag) {
                radioButton.selected = YES;
                [self fireDidSelectDelegateWithRadioButton:radioButton];
                break;
            }
        }
    }
}

- (void)fireDidSelectDelegateWithRadioButton:(DLRadioButton *)radioButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dlRadioGroup:didSelect:)]) {
        [self.delegate dlRadioGroup:self didSelect:radioButton];
    }
}

- (void)deselectAllRadioButtons
{
    for (DLRadioButton *radioButton in self.radioButtons) {
        radioButton.selected = NO;
    }
}

- (void)addRadioButton:(DLRadioButton *)radioButton
{
    if (radioButton.radioGroup != self) {
        NSMutableSet *newSet = [NSMutableSet setWithSet:self.radioButtons];
        [newSet addObject:radioButton];
        [radioButton willAddToRadioGroup:self];
        self.radioButtons = newSet;
        [radioButton didAddToRadioGroup:self];
    }
}

- (void)removeRadioButton:(DLRadioButton *)radioButton
{
    if (radioButton.radioGroup == self) {
        NSMutableSet *newSet = [NSMutableSet setWithSet:self.radioButtons];
        [newSet removeObject:radioButton];
        [radioButton willRemoveFromRadioGroup:self];
        self.radioButtons = newSet;
        [radioButton didRemoveFromRadioGroup:self];
    }
}

- (DLRadioButton *)selectedRadioButton
{
    if (!self.isMultipleSelectionEnabled) {
        for (DLRadioButton *radioButton in self.radioButtons) {
            if (radioButton.selected) {
                return radioButton;
            }
        }
    }
    return nil;
}

- (NSArray *)selectedRadioButtons
{
    NSMutableArray *selectedButtons = [[NSMutableArray alloc] init];
    for (DLRadioButton *radioButton in self.radioButtons) {
        if (radioButton.selected) {
            [selectedButtons addObject:radioButton];
        }
    }
    return selectedButtons;
}

@end
