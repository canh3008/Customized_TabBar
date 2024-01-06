//
//  TabBarController.swift
//  CustomizedTabBar
//
//  Created by Duc Canh on 24/12/2023.
//

import UIKit

public extension UIApplication {
    class func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window

    }

    class func topViewController(controller: UIViewController? = currentUIWindow()?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

class TabBarController: UITabBarController {
    private var customizedLayer: CALayer?
    private var widthCenterItem: CGFloat = 30

    private var heightCenterItem: CGFloat  {
        return 40
    }
    private var heightArea: CGFloat {
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupTabBar() {
        let tab1ViewController = UINavigationController(rootViewController: Tab1ViewController())
        tab1ViewController.tabBarItem.image = UIImage(systemName: "house")
        let tab2ViewController = UINavigationController(rootViewController: Tab2ViewController())
        tab2ViewController.tabBarItem.image = UIImage(systemName: "trash")
        self.tabBar.itemWidth = 60
        self.tabBar.itemSpacing = UIScreen.main.bounds.width - 60 * 2
        self.tabBar.itemPositioning = .centered
        viewControllers = [tab1ViewController, tab2ViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setFrameTabBar()
        addShape()
    }

    private func setFrameTabBar() {
        var newFrame = self.tabBar.frame
        newFrame.size.height = self.tabBar.frame.height + heightArea
        self.tabBar.frame = newFrame

        self.tabBar.items?.forEach({ item in
            item.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0)
        })
    }

    func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor =  UIColor(red: 150.0/255.0, green: 186.0/255.0, blue: 249.0/255.0, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.strokeColor = UIColor.gray.cgColor

        if let oldShapeLayer = customizedLayer {
            self.tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.customizedLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let centerWidth: CGFloat = UIScreen.main.bounds.width / 2
        let path = UIBezierPath()
        let widthTest: CGFloat = widthCenterItem * 2
        let endLeftLine: CGFloat = centerWidth - widthTest
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: endLeftLine,
                                 y: 0))

        path.addCurve(to: CGPoint(x: centerWidth, y: heightCenterItem),
                      controlPoint1: CGPoint(x: endLeftLine + 0.7 * widthTest, y: 0 * heightCenterItem),
                      controlPoint2: CGPoint(x: endLeftLine + 0.3 * widthTest, y: 1 * heightCenterItem))

        path.addCurve(to: CGPoint(x: centerWidth + widthTest, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 0.7 * widthTest, y: 1 * heightCenterItem),
                      controlPoint2: CGPoint(x: centerWidth + 0.3 * widthTest, y: 0 * heightCenterItem))

        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: self.tabBar.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.tabBar.frame.height))
        path.close()
        return path.cgPath
    }
}
