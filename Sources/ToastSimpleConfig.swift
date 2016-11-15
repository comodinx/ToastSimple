//
//  ToastSimpleConfig.swift
//  Pods
//
//  Created by Nicolas Molina on 11/15/16.
//
//

import UIKit

open class ToastSimpleConfig: NSObject
{

    // animation
    open static var Duration: TimeInterval = 2.0
    open static var AnimationDuration: TimeInterval = 0.2

    // image size
    open static var ImageViewWidth: CGFloat = 80.0
    open static var ImageViewHeight: CGFloat = 80.0

    // label setting
    open static var MaxWidth: CGFloat = 0.8 // 80% of parent view width
    open static var MaxHeight: CGFloat = 0.8
    open static var MaxTitleLines = 0
    open static var MaxMessageLines = 0
    open static var TitleFontType: UIFont = UIFont.systemFont(ofSize: 16)
    open static var TitleFontColor: UIColor = .black
    open static var TitleAlign: NSTextAlignment = .center
    open static var MessageFontType: UIFont = UIFont.systemFont(ofSize: 13)
    open static var MessageFontColor: UIColor = .black
    open static var MessageAlign: NSTextAlignment = .center

    // shadow appearance
    open static var ShadowOpacity: CGFloat = 0.8
    open static var ShadowRadius: CGFloat = 6.0
    open static var ShadowOffset: CGSize = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))

    open static var BackgroundColor: UIColor = .gray
    open static var Position: ToastSimplePosition = .Top
    open static var Opacity: CGFloat = 0.9
    open static var CornerRadius: CGFloat = 10.0
    open static var HorizontalMargin : CGFloat = 10.0
    open static var VerticalMargin: CGFloat = 22.0

    open static var HidesOnTap = true
    open static var DisplayShadow = true
    
}
