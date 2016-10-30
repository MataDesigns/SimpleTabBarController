<center>![logo](logo.png)</center>

[![CI Status](http://img.shields.io/travis/Nicholas Mata/SimpleTabBarController.svg?style=flat)](https://travis-ci.org/Nicholas Mata/SimpleTabBarController)
[![Version](https://img.shields.io/cocoapods/v/SimpleTabBarController.svg?style=flat)](http://cocoapods.org/pods/SimpleTabBarController)
[![License](https://img.shields.io/cocoapods/l/SimpleTabBarController.svg?style=flat)](http://cocoapods.org/pods/SimpleTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/SimpleTabBarController.svg?style=flat)](http://cocoapods.org/pods/SimpleTabBarController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 9.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

SimpleTabBarController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SimpleTabBarController"
```

## Features

- [x] Allows for custom item animations.
- [x] Supports storyboard.
- [x] Implement selected image for item.
- [x] Change icon selected and unselected color from storyboard.

## Usage

### Default appearance 

The default appearance is SimpleBounceAnimator which will make tabbar icon bounce when selected.

### Getting Started

1. Drag a UITabBarController onto your storyboard.
2. Change class to SimpleTabBarController or a subclass you created.
3. Change item classes from UITabBarItem to SimpleBarItem.

## Author

Nicholas Mata, NicholasMata94@gmail.com

## License

SimpleTabBarController is available under the MIT license. See the LICENSE file for more info.
