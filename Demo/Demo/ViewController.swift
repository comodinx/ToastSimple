//
//  ViewController.swift
//  Demo
//
//  Created by Nicolas Molina on 10/5/16.
//  Copyright © 2016 Base pod. All rights reserved.
//

import UIKit
import ToastSimple
import SimpleLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ToastSimpleConfig.BackgroundColor = .gray
        ToastSimpleConfig.TitleFontColor = .black
        ToastSimpleConfig.TitleFontType = UIFont.systemFont(ofSize: 17)
        ToastSimpleConfig.MessageFontColor = .black
        ToastSimpleConfig.MessageFontType = UIFont.systemFont(ofSize: 15)
        ToastSimpleConfig.Duration = 2
        ToastSimpleConfig.AnimationDuration = 0.75

        delay(1) {
            self.view.showToast(
                "This is a demo toast (Default position is Top)",
                title: "Congratulation!"
            )
        }

        delay(4) {
            self.view.showToast(
                "This is a demo Center toast with image",
                position: .Center,
                title: "Congratulation!",
                image: UIImage(named: "toast")
            )
        }

        delay(7) {
            self.view.showToast(
                toast: self.createCustomToast(),
                position: .Bottom
            )
        }
    }

    fileprivate func delay(_ delay: Double, callback: @escaping () -> Void)
    {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: callback
        )
    }

    fileprivate func createCustomToast() -> UIView
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 100))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 40))

        view.autoresizingMask = ([.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        view.backgroundColor = ToastSimpleConfig.BackgroundColor.withAlphaComponent(ToastSimpleConfig.Opacity)

        label.numberOfLines = ToastSimpleConfig.MaxMessageLines
        label.lineBreakMode = .byWordWrapping
        label.font = ToastSimpleConfig.MessageFontType
        label.text = "This is a demo Bottom toast with custom toast view"

        view.addSubview(label)
        label.sl_addCenter(view)
        label.sl_addMarginLeft(view, constant: 10, relatedBy: .greaterThanOrEqual)
        label.sl_addMarginRight(view, constant: 10, relatedBy: .greaterThanOrEqual)

        return view
    }

}
