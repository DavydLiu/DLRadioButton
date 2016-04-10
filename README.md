# DLRadioButton 

[![Version](https://img.shields.io/cocoapods/v/DLRadioButton.svg?style=flat)](http://cocoadocs.org/docsets/DLRadioButton)
[![License](https://img.shields.io/cocoapods/l/DLRadioButton.svg?style=flat)](http://cocoadocs.org/docsets/DLRaidoButton)
[![Platform](https://img.shields.io/cocoapods/p/DLRadioButton.svg?style=flat)](http://cocoadocs.org/docsets/DLRadioButton)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`DLRadioButton` is an easy to use and highly customizable radio buttons control for iOS. It's a subclass of `UIButton`, and works smoothly with both `Objective-C` and `Swift`.

Since release, it has became the most popular radio buttons control for iOS🎉. Thank you for great feedbacks and making it better for all of us👏.

## Preview

![screenshot1](Images/DLRadioButton_screenshot1.png)

## Usage

####To install:
*	Option 1: simply put `DLRadioButton.h` and `DLRadiobutton.m` in your project.
*	Option 2: add `pod 'DLRadioButton', '~> 1.4'` to your `Podfile`.
*	Option 3: add `github "DavydLiu/DLRadioButton" ~> 1.4` to your `Cartfile`.

####To add radio buttons in interface builder:

1.  Put some UIButtons onto a View and change the UIButtons' type to "custom".

	![change UIButton Type](Images/change_UIButton_type.png)

2.  Set the UIButtons' class to "DLRadioButton".

	![change UIButton Class](Images/change_UIButton_class.png)

3.	Set "otherButtons" outlet.

	![set otherButtons outlet](Images/set_otherButtons_outlet.png)

####To customize DLRadiobutton:

*	Simply set properties directly in Interface Builder.

	![design DLButton](Images/design_DLRadioButton.png)

*	Property reference:
	
	![DLRadioButton](Images/DLRadioButton.png)
	
####To add raido buttons programmatically, please refer to example project.

## Requirements

ARC, iOS 6.0

## Author

David Liu. For help or any questions, feel free to [open an issue](https://github.com/DavydLiu/DLRadioButton/issues/new).

## License

DLRadioButton is available under the MIT license.
