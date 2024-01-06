//
//  Tab1ViewController.swift
//  CustomizedTabBar
//
//  Created by Duc Canh on 24/12/2023.
//

import UIKit

class Tab1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setGradientBackground()
    }

    func setGradientBackground() {
        let colorTop =  UIColor(red: 240.0/255.0, green: 155.0/255.0, blue: 92.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 150.0/255.0, green: 186.0/255.0, blue: 249.0/255.0, alpha: 1.0).cgColor //#96BAF9

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
