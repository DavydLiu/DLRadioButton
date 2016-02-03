#import "DLRadioGroup.h"

#import "DLRadioButton.h"

@implementation DLRadioGroup

- (id)init
{
    self = [super init];
    
    if (self) {
        self.radioButtons = [NSMutableArray new];
    }
    
    return self;
}

- (id)initWithRadioButtons:(NSArray *)radioButtons
{
    self = [super init];
    
    if (self) {
        self.radioButtons = [radioButtons mutableCopy];
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
        NSInteger index = [self.radioButtons indexOfObject:radioButton];
        
        if (index == NSNotFound) {
            [radioButton willAddToRadioGroup:self];
            [self.radioButtons addObject:radioButton];
            [radioButton didAddToRadioGroup:self];
        }
    }
}

- (void)removeRadioButton:(DLRadioButton *)radioButton
{
    if (radioButton.radioGroup == self) {
        [radioButton willRemoveFromRadioGroup:self];
        [self.radioButtons removeObject:radioButton];
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

#pragma mark Getters and setters

- (void)setRadioButtons:(NSMutableSet *)radioButtons
{
    _radioButtons = [NSMutableArray new];
    
    for (DLRadioButton *radioButton in radioButtons) {
        [self addRadioButton:radioButton];
    }
}

@end
