//
//  ToastSimple.swift
//  ToastSimple
//
//  Created by Nicolas Molina on 8/8/16.
//  Copyright © 2016 ToastSimple. All rights reserved.
//

import UIKit

// Infix overload method
fileprivate func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

// Keys for association
fileprivate var ToastSimpleView: UnsafePointer<UIView>? = nil

open class ToastSimple: NSObject
{

    @discardableResult open class func show(
        _ view: UIView,
        message: String,
        duration: TimeInterval = ToastSimpleConfig.Duration,
        position: ToastSimplePosition = .Top,
        title: String? = nil,
        image: UIImage? = nil,
        completion: (() -> Void)? = nil
    ) -> UIView
    {
        let toast = viewForMessage(view, message: message, title: title, image: image)

        return show(view, toast: toast!, duration: duration, position: position, completion: completion)
    }

    @discardableResult open class func show(
        _ view: UIView,
        toast: UIView,
        duration: TimeInterval = ToastSimpleConfig.Duration,
        position: ToastSimplePosition = .Top,
        completion: (() -> Void)? = nil
    ) -> UIView
    {
        let existToast = objc_getAssociatedObject(self, &ToastSimpleView) as! UIView?

        if existToast != nil {
            hide(view, toast: existToast!)
        }

        toast.center = centerPointForPosition(view, position: position, toast: toast)
        toast.alpha = 0.0

        view.addSubview(toast)
        objc_setAssociatedObject(view, &ToastSimpleView, toast, .OBJC_ASSOCIATION_RETAIN)

        UIView.animate(
            withDuration: ToastSimpleConfig.AnimationDuration,
            delay: 0.0,
            options: ([.curveEaseOut, .allowUserInteraction]),
            animations: {
                toast.alpha = 1.0
            },
            completion: { (finished: Bool) in
                DispatchQueue.main.asyncAfter(
                    deadline: DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
                    execute: {
                        hide(view, toast: toast, completion: completion)
                    }
                )
            }
        )

        return toast
    }

    open class func hide(
        _ view: UIView,
        toast: UIView,
        force: Bool = false,
        completion: (() -> Void)? = nil
    )
    {
        let completionHide = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            completion?()
        }

        if force {
            completionHide(true)

        } else {
            UIView.animate(
                withDuration: ToastSimpleConfig.AnimationDuration,
                delay: 0.0,
                options: ([.curveEaseIn, .beginFromCurrentState]),
                animations: {
                    toast.alpha = 0.0
                },
                completion: completionHide
            )
        }
    }

    fileprivate class func centerPointForPosition(_ view: UIView, position: ToastSimplePosition, toast: UIView) -> CGPoint
    {
        let toastSize = toast.bounds.size
        let viewSize  = view.bounds.size

        switch position {
            case .Top:
                return CGPoint(x: viewSize.width / 2, y: toastSize.height / 2 + ToastSimpleConfig.VerticalMargin)

            case .Bottom:
                return CGPoint(x: viewSize.width / 2, y: viewSize.height - toastSize.height / 2 - ToastSimpleConfig.VerticalMargin)

            case .Center:
                return CGPoint(x: viewSize.width / 2, y: viewSize.height / 2)
        }
    }

    fileprivate class func viewForMessage(_ view: UIView, message: String?, title: String?, image: UIImage?) -> UIView?
    {
        if message == nil && title == nil && image == nil {
            return nil
        }

        var msgLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?

        let wrapperView = UIView()
        let color = ToastSimpleConfig.BackgroundColor

        wrapperView.autoresizingMask = ([.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        wrapperView.layer.cornerRadius = ToastSimpleConfig.CornerRadius
        wrapperView.backgroundColor = color.withAlphaComponent(ToastSimpleConfig.Opacity)

        if ToastSimpleConfig.DisplayShadow {
            wrapperView.layer.shadowColor = color.cgColor
            wrapperView.layer.shadowOpacity = Float(ToastSimpleConfig.ShadowOpacity)
            wrapperView.layer.shadowRadius = ToastSimpleConfig.ShadowRadius
            wrapperView.layer.shadowOffset = ToastSimpleConfig.ShadowOffset
        }

        if image != nil {
            imageView = UIImageView(image: image)
            imageView!.contentMode = .scaleAspectFit
            imageView!.frame = CGRect(
                x: ToastSimpleConfig.HorizontalMargin,
                y: ToastSimpleConfig.VerticalMargin,
                width: ToastSimpleConfig.ImageViewWidth,
                height: ToastSimpleConfig.ImageViewHeight
            )
        }

        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        var imageLeft: CGFloat = 0

        if imageView != nil {
            imageWidth = imageView!.bounds.size.width
            imageHeight = imageView!.bounds.size.height
            imageLeft = ToastSimpleConfig.HorizontalMargin
        }

        if title != nil {
            titleLabel = UILabel()
            titleLabel!.numberOfLines = ToastSimpleConfig.MaxTitleLines
            titleLabel!.font = ToastSimpleConfig.TitleFontType
            titleLabel!.textAlignment = ToastSimpleConfig.TitleAlign
            titleLabel!.lineBreakMode = .byWordWrapping
            titleLabel!.textColor = ToastSimpleConfig.TitleFontColor
            titleLabel!.backgroundColor = UIColor.clear
            titleLabel!.alpha = 1.0
            titleLabel!.text = title

            // size the title label according to the length of the text
            let maxSizeTitle = CGSize(
                width: (view.bounds.size.width * ToastSimpleConfig.MaxWidth) - imageWidth,
                height: view.bounds.size.height * ToastSimpleConfig.MaxHeight
            )
            let expectedHeight = stringHeightWithFontSize(
                title!,
                font: ToastSimpleConfig.TitleFontType,
                width: maxSizeTitle.width
            )
            titleLabel!.frame = CGRect(x: 0.0, y: 0.0, width: maxSizeTitle.width, height: expectedHeight)
        }

        if message != nil {
            msgLabel = UILabel()
            msgLabel!.numberOfLines = ToastSimpleConfig.MaxMessageLines
            msgLabel!.font = ToastSimpleConfig.MessageFontType
            msgLabel!.lineBreakMode = .byWordWrapping
            msgLabel!.textAlignment = ToastSimpleConfig.MessageAlign
            msgLabel!.textColor = ToastSimpleConfig.MessageFontColor
            msgLabel!.backgroundColor = UIColor.clear
            msgLabel!.alpha = 1.0
            msgLabel!.text = message

            let maxSizeMessage = CGSize(
                width: (view.bounds.size.width * ToastSimpleConfig.MaxWidth) - imageWidth,
                height: view.bounds.size.height * ToastSimpleConfig.MaxHeight
            )
            let expectedHeight = stringHeightWithFontSize(
                message!,
                font: ToastSimpleConfig.MessageFontType,
                width: maxSizeMessage.width
            )
            msgLabel!.frame = CGRect(x: 0.0, y: 0.0, width: maxSizeMessage.width, height: expectedHeight)
        }

        var titleWidth: CGFloat = 0.0
        var titleHeight: CGFloat = 0.0
        var titleTop: CGFloat = 0.0
        var titleLeft: CGFloat = 0.0

        if titleLabel != nil {
            titleWidth = titleLabel!.bounds.size.width
            titleHeight = titleLabel!.bounds.size.height
            titleTop = ToastSimpleConfig.VerticalMargin
            titleLeft = imageLeft + imageWidth + ToastSimpleConfig.HorizontalMargin
        }

        var msgWidth: CGFloat = 0.0
        var msgHeight: CGFloat = 0.0
        var msgTop: CGFloat = 0.0
        var msgLeft: CGFloat = 0.0

        if msgLabel != nil {
            msgWidth = msgLabel!.bounds.size.width
            msgHeight = msgLabel!.bounds.size.height
            msgTop = titleTop + titleHeight + ToastSimpleConfig.VerticalMargin
            msgLeft = imageLeft + imageWidth + ToastSimpleConfig.HorizontalMargin
        }

        let largerWidth = max(titleWidth, msgWidth)
        let largerLeft  = max(titleLeft, msgLeft)

        // set wrapper view's frame
        let wrapperWidth  = max(
            imageWidth + ToastSimpleConfig.HorizontalMargin * 2,
            largerLeft + largerWidth + ToastSimpleConfig.HorizontalMargin
        )
        let wrapperHeight = max(
            msgTop + msgHeight + ToastSimpleConfig.VerticalMargin,
            imageHeight + ToastSimpleConfig.VerticalMargin * 2
        )
        wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)
        
        // add subviews
        if titleLabel != nil {
            titleLabel!.frame = CGRect(x: titleLeft, y: titleTop, width: titleWidth, height: titleHeight)
            wrapperView.addSubview(titleLabel!)
        }
        if msgLabel != nil {
            msgLabel!.frame = CGRect(x: msgLeft, y: msgTop, width: msgWidth, height: msgHeight)
            wrapperView.addSubview(msgLabel!)
        }
        if imageView != nil {
            wrapperView.addSubview(imageView!)
        }
        
        return wrapperView
    }
    
    fileprivate class func stringHeightWithFontSize(
        _ str: String,
        font: UIFont,
        width: CGFloat
    ) -> CGFloat
    {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy()]
        let rect = str.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return rect.size.height
    }

}
