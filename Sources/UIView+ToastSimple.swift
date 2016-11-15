//
//  UIView+ToastSimple.swift
//  Pods
//
//  Created by Nicolas Molina on 11/15/16.
//
//

import UIKit

public extension UIView
{

    @discardableResult func showToast(
        _ message: String,
        duration: TimeInterval = ToastSimpleConfig.Duration,
        position: ToastSimplePosition = .Top,
        title: String? = nil,
        image: UIImage? = nil,
        completion: (() -> Void)? = nil
    ) -> UIView
    {
        let toast = ToastSimple.show(
            self,
            message: message,
            duration: duration,
            position: position,
            title: title,
            image: image,
            completion: completion
        )

        attachHandleToastTapIfNecesary(toast)
        return toast
    }

    @discardableResult func showToast(
        toast: UIView,
        duration: TimeInterval = ToastSimpleConfig.Duration,
        position: ToastSimplePosition = .Top,
        completion: (() -> Void)? = nil
    ) -> UIView
    {
        let toast = ToastSimple.show(
            self,
            toast: toast,
            duration: duration,
            position: position,
            completion: completion
        )

        attachHandleToastTapIfNecesary(toast)
        return toast
    }

    func toastTapped(sender: UITapGestureRecognizer)
    {
        ToastSimple.hide(self, toast: sender.view!)
    }

    fileprivate func attachHandleToastTapIfNecesary(_ toast: UIView)
    {
        if ToastSimpleConfig.HidesOnTap {
            let recognizer = UITapGestureRecognizer(target: toast, action: #selector(toastTapped))

            toast.addGestureRecognizer(recognizer)
            toast.isUserInteractionEnabled = true
            toast.isExclusiveTouch = true
        }
    }
    
}
