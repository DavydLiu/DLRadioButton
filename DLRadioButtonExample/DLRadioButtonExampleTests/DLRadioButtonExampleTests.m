#import <XCTest/XCTest.h>
#import "DLRadioButton.h"

@interface DLRadioButtonExampleTests : XCTestCase

@property DLRadioButton *firstButton;
@property DLRadioButton *secondButton;
@property DLRadioButton *thirdButton;

@end

@implementation DLRadioButtonExampleTests

- (void)setUp {
    [super setUp];
    self.firstButton = [[DLRadioButton alloc] init];
    self.secondButton = [[DLRadioButton alloc] init];
    self.thirdButton = [[DLRadioButton alloc] init];
    self.firstButton.otherButtons = @[self.secondButton, self.thirdButton];
}

- (void)tearDown {
    self.firstButton = nil;
    self.secondButton = nil;
    self.thirdButton = nil;
    [super tearDown];
}

- (void)testButtonSelection {
    [self.firstButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.secondButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // selected button should be second button.
    XCTAssertEqualObjects([self.firstButton selectedButton], self.secondButton);
    XCTAssertEqualObjects([self.secondButton selectedButton], self.secondButton);
    XCTAssertEqualObjects([self.thirdButton selectedButton], self.secondButton);
    
    // selected button should be third button.
    [self.thirdButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertEqualObjects([self.secondButton selectedButton], self.thirdButton);
}

- (void)testButtonDeselection {
    [self.secondButton sendActionsForControlEvents:UIControlEventTouchDown];
    [self.firstButton deselectOtherButtons];
    XCTAssertNil([self.firstButton selectedButton]);
}

- (void)testMultipleButtonsSelection {
    self.firstButton.multipleSelectionEnabled = YES;
    [self.secondButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.thirdButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // selected button should return nil, once multiple selection enabled.
    XCTAssertNil([self.firstButton selectedButton]);
    XCTAssertNil([self.secondButton selectedButton]);
    XCTAssertNil([self.thirdButton selectedButton]);
    
    // second and third button should be selected.
    XCTAssertFalse([[self.firstButton selectedButtons] containsObject:self.firstButton]);
    XCTAssertTrue([[self.firstButton selectedButtons] containsObject:self.secondButton]);
    XCTAssertTrue([[self.firstButton selectedButtons] containsObject:self.thirdButton]);
    
    // first and second button should be selected.
    [self.firstButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.thirdButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertTrue([[self.secondButton selectedButtons] containsObject:self.firstButton]);
    XCTAssertTrue([[self.secondButton selectedButtons] containsObject:self.secondButton]);
    XCTAssertFalse([[self.secondButton selectedButtons] containsObject:self.thirdButton]);
}

@end
