ToastSimple
===========
[![Version](http://img.shields.io/cocoapods/v/ToastSimple.svg?style=flat)](http://cocoapods.org/pods/ToastSimple) [![Platform](http://img.shields.io/cocoapods/p/ToastSimple.svg?style=flat)](http://cocoapods.org/pods/ToastSimple) [![License](http://img.shields.io/cocoapods/l/ToastSimple.svg?style=flat)](LICENSE)


Índice
------

* [Features][features].
* [Screen Shots][screenshots].
* [Prerequisites][prerequisites].
* [Installation][Installation].
* [How to Use][how_to_use].
    + [Example][how_to_use_example].
    + [API][how_to_use_api].
        + [Configuration][how_to_use_api_configuration].
    + [Personalize][how_to_use_personalize].
* [License][license].


Features
--------
* Simple
* UIView extension
* Personalizable


Screen Shots
------------
<p>
    <a href="https://github.com/comodinx/ToastSimple/blob/master/Screenshots/DemoExample.gif?raw=true" target="_blank">
        <img src="https://github.com/comodinx/ToastSimple/raw/master/Screenshots/DemoExample.gif?raw=true" alt="Demo Example" title="Demo Example" width="320" height="568">
    </a>
</p>


Prerequisites
-------------
* iOS 8+
* Xcode 7+
* Swift 3.0


Installation
------------
ToastSimple is available through CocoaPods. To install it, simply add the following line to your Podfile:
```
pod "ToastSimple"
```


How to Use
----------
Your use documentation.

#### Example
``` swift
view.showToast("This is a example toast notification")
// or
view.showToast("This is a example toast notification", title: "Information!")
// or
view.showToast(
    "This is a example toast notification",
    title: "Information!",
    image: UIImage(named: "yourimage")
)
// or
view.showToast(
    "This is a example toast notification",
    duration: 2.5, // Seconds
    title: "Information!",
    image: UIImage(named: "yourimage")
)
// or
view.showToast(
    "This is a example toast notification",
    duration: 2.5, // Seconds
    position: .Center, // .Top (default), .Center or .Bottom
    title: "Information!",
    image: UIImage(named: "yourimage")
)
// or
view.showToast(
    toast: UIView(), // Your custom view
    duration: 2.5, // Seconds
    position: .Center // .Top (default), .Center or .Bottom
)
// or
view.showToast(
    toast: UIView(), // Your custom view
    duration: 2.5, // Seconds
    position: .Center, // .Top (default), .Center or .Bottom
) {
    // your code to execute on toast completion hide
}
```

#### API

##### Configuration

Toast configuration.

```swift
// animation
ToastSimpleConfig.Duration: TimeInterval = 2.0
ToastSimpleConfig.AnimationDuration: TimeInterval = 0.2

// image size
ToastSimpleConfig.ImageViewWidth: CGFloat = 80.0
ToastSimpleConfig.ImageViewHeight: CGFloat = 80.0

// label setting
ToastSimpleConfig.MaxWidth: CGFloat = 0.8 // 80% of parent view width
ToastSimpleConfig.MaxHeight: CGFloat = 0.8
ToastSimpleConfig.MaxTitleLines = 0
ToastSimpleConfig.MaxMessageLines = 0
ToastSimpleConfig.TitleFontType: UIFont = UIFont.systemFont(ofSize: 16)
ToastSimpleConfig.TitleFontColor: UIColor = .black
ToastSimpleConfig.TitleAlign: NSTextAlignment = .center
ToastSimpleConfig.MessageFontType: UIFont = UIFont.systemFont(ofSize: 13)
ToastSimpleConfig.MessageFontColor: UIColor = .black
ToastSimpleConfig.MessageAlign: NSTextAlignment = .center

// shadow appearance
ToastSimpleConfig.ShadowOpacity: CGFloat = 0.8
ToastSimpleConfig.ShadowRadius: CGFloat = 6.0
ToastSimpleConfig.ShadowOffset: CGSize = CGSize(
    width: CGFloat(4.0),
    height: CGFloat(4.0)
)

ToastSimpleConfig.BackgroundColor: UIColor = .gray
ToastSimpleConfig.Position: ToastSimplePosition = .Top
ToastSimpleConfig.Opacity: CGFloat = 0.9
ToastSimpleConfig.CornerRadius: CGFloat = 10.0
ToastSimpleConfig.HorizontalMargin : CGFloat = 10.0
ToastSimpleConfig.VerticalMargin: CGFloat = 22.0

ToastSimpleConfig.HidesOnTap = true
ToastSimpleConfig.DisplayShadow = true
```

#### Personalize

```swift
import ToastSimple

// ...
class AppDelegate: UIResponder, UIApplicationDelegate {

    // ...

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Configure toast
        ToastSimpleConfig.BackgroundColor = .gray
        ToastSimpleConfig.TitleFontColor = .black
        ToastSimpleConfig.TitleFontType = UIFont.systemFont(ofSize: 17)
        ToastSimpleConfig.MessageFontColor = .black
        ToastSimpleConfig.MessageFontType = UIFont.systemFont(ofSize: 15)
        ToastSimpleConfig.Duration = 5
        ToastSimpleConfig.AnimationDuration = 0.75

        return true
    }

    // ...

}
```

License
-------
ToastSimple is available under the MIT license. See the LICENSE file for more info.

<!-- deep links -->
[features]: #features
[screenshots]: #screen-shots
[prerequisites]: #prerequisites
[installation]: #installation
[how_to_use]: #how-to-use
[how_to_use_example]: #example
[how_to_use_api]: #api
[how_to_use_api_configuration]: #configuration
[how_to_use_personalize]: #personalize
[license]: #license
