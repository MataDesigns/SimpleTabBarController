//
//  SimpleTabBarController.swift
//  SimpleTabBarController
//
//  Created by Nicholas Mata on 10/24/2016.
//  Copyright (c) 2016 Nicholas Mata. All rights reserved.
//

import Foundation
import UIKit

public typealias SimpleTabBarShouldHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Bool))

public typealias SimpleTabBarHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Void))

@IBDesignable
open class SimpleTabBarController: UITabBarController {
    
    /// Array for containers of all the customize tabbars.
    /// SimpleTabBarController will auto-create SimpleTabBarContiner object as container.
    /// The SimpleTabBarContiner object can handle all touch events to impletement customize tabbar.
    fileprivate var containers = [String: AnyObject]()
    
    /// Whether to ignore animate.
    /// Default is true because system will autoset selectedIndex = 0 at begining.
    fileprivate var ignoreNextAnimation = true
    
    /// Whether it has been initialized.
    /// This is a flag used to mark the current initialization state.
    /// Usually, we can set UITabBarControler's viewControllers before viewDidLoad()
    fileprivate var initialized = false
    
    /// Whether to hijack select action.
    open var shouldHijackHandler: SimpleTabBarShouldHijackHandler?
    /// Hijack select action.
    open var hijackHandler: SimpleTabBarHijackHandler?
    
    /// Auto reload when did set.
    open override var viewControllers: [UIViewController]? {
        didSet {
            self.initialized = true
            self.reload()
        }
    }
    
    /// Setting selectedIndex by manual.
    open override var selectedIndex: Int {
        willSet {
            guard ignoreNextAnimation == false else {
                return
            }
            guard let items = tabBar.items else {
                reportEmptyItems()
                return
            }
            let oldValue = selectedIndex
            if oldValue < items.count, let deselectItem = items[oldValue] as? SimpleBarItem {
                deselectItem.deselect(animated: true, completion: nil)
            }
            if newValue < items.count, let animationItem = items[newValue] as? SimpleBarItem {
                animationItem.select(animated: true, completion: nil)
            }
        }
    }
    
    /// This view controller is the one whose custom view is currently displayed by the tab bar interface. The specified view controller must be in the viewControllers array. Assigning a new view controller to this property changes the currently displayed view and also selects an appropriate tab in the tab bar. Changing the view controller also updates the selectedIndex property accordingly. The default value of this property is nil.
    /// UIMoreNavigationController don't need container or any customize.
    open override var selectedViewController: UIViewController? {
        willSet {
            guard let items = tabBar.items else {
                reportEmptyItems()
                return
            }
            if newValue == self.moreNavigationController {
                if selectedIndex < items.count, let deselectItem = items[selectedIndex] as? SimpleBarItem {
                    deselectItem.deselect(animated: true, completion: nil)
                }
            }
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.setValue(true, forKey: "_hidesShadow")
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = tabBar.frame.size.width
        let height = tabBar.frame.size.height
        let count = tabBar.items?.count ?? 0

        for index in 0..<count {
            if let container = containers["container\(index)"] as? SimpleTabBarContainer {
                let x = width / CGFloat(count) * CGFloat(index) //+ 2
                let width = width / CGFloat(count) //- 2
                container.frame = CGRect(x: x, y: 0.0, width: width, height: height)
                for view in container.subviews {
                    if let contentView = view as? SimpleBarItemContent {
                        let insets = contentView.insets
                        
                        if insets != .zero {
                            container.frame.origin.y += insets.top
                            container.frame.size.height -= insets.top - insets.bottom
                        }
                        if container.frame.height > 49 {
                            container.removeFromSuperview()
                            container.frame.origin.y = tabBar.frame.origin.y + insets.top
                            self.view.addSubview(container)
                            self.view.bringSubviewToFront(container)
                        }
                        let rect = container.bounds
                        contentView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
                    }
                }
            }
        }
    }
    
    // The system calls this method when the iOS interface environment changes. Implement this method in view controllers and views, according to your app’s needs, to respond to such changes. For example, you might adjust the layout of the subviews of a view controller when an iPhone is rotated from portrait to landscape orientation. The default implementation of this method is empty.
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass ||
            self.traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            self.reload()
        }
    }
    
}

// MARK: - SimpleTabBarController+Containers
extension SimpleTabBarController /* Containers */ {
    
    fileprivate func removeAll() {
        for (_, view) in containers {
            view.removeFromSuperview()
        }
        containers.removeAll()
    }
    
    fileprivate func reload() {
        /// Remove all containers before create.
        /// It is very light weight because all of tabbar content are managed by tabbar item.
        removeAll()
        
        guard let items = tabBar.items else {
            /// Maybe there have a bug.
            reportEmptyItems()
            return
        }
        
        /// Create containers, If the current viewControllers more than 5, only add four container. (PS: Because the 5th is UIMoreNavigationController)
        let count = (moreNavigationController.parent != nil) ? items.count - 1 : items.count
        for index in 0..<count {
            let container = SimpleTabBarContainer()
            container.tag = index
            /// We need handle both select and highlight actions.
            container.addTarget(self, action: #selector(SimpleTabBarController.selectAction(_:)), for: .touchUpInside)
            container.addTarget(self, action: #selector(SimpleTabBarController.highlightAction(_:)), for: .touchDown)
            container.addTarget(self, action: #selector(SimpleTabBarController.highlightAction(_:)), for: .touchDragEnter)
            container.addTarget(self, action: #selector(SimpleTabBarController.dehighlightAction(_:)), for: .touchDragExit)
            
            tabBar.addSubview(container)
            containers["container\(index)"] = container
            
            /// Add the item to the container appearance
            if let item = items[index] as? SimpleBarItem {
                item.index = index
                item.tabBarController = self
                if let content = item.content {
                    container.addSubview(content)
                }
                if index == selectedIndex {
                    item.select(animated: false, completion: nil)
                } else {
                    item.deselect(animated: false, completion: nil)
                }
            }
        }
        
        /// Update containers layout
        self.view.setNeedsLayout()
    }
    
    @objc internal func highlightAction(_ sender: AnyObject?) {
        guard let items = tabBar.items else {
            reportEmptyItems()
            return
        }
        guard let container = sender as? UIView else {
            reportInvalidContainer()
            return
        }
        
        let targetIndex = container.tag
        guard targetIndex < viewControllers?.count ?? 0 else {
            reportInvalidIndex(targetIndex)
            return
        }
        
        guard let vc = viewControllers?[targetIndex] else {
            return
        }
        
        /// Selectability check
        if vc.tabBarItem.isEnabled == false {
            return
        }
        if vc.tabBarItem.selectEnabled == false {
            return
        }
        
        // Check should select
        if let delegate = delegate {
            let shouldSelect = delegate.tabBarController?(self, shouldSelect: vc) ?? true
            if shouldSelect == false {
                return
            }
        }
        
        // Check should hijack
        if let shouldHijackHandler = shouldHijackHandler {
            let shouldHijack = shouldHijackHandler(self, vc, targetIndex)
            if shouldHijack == true {
                // Do animate when hijack
                if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
                    animationItem.highlight(highlight: true, animated: true, completion: {
                        
                    })
                }
                return
            }
        }
        
        /// Do
        if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
            animationItem.highlight(highlight: true, animated: true, completion: nil)
        }
    }
    
    @objc internal func dehighlightAction(_ sender: AnyObject?) {
        guard let items = tabBar.items else {
            reportEmptyItems()
            return
        }
        guard let container = sender as? UIView else {
            reportInvalidContainer()
            return
        }
        
        let targetIndex = container.tag
        guard targetIndex < viewControllers?.count ?? 0 else {
            reportInvalidIndex(targetIndex)
            return
        }
        
        guard let vc = viewControllers?[targetIndex] else {
            return
        }
        
        /// Selectability check
        if vc.tabBarItem.isEnabled == false {
            return
        }
        if vc.tabBarItem.selectEnabled == false {
            return
        }
        
        // Check should select
        if let delegate = delegate {
            let shouldSelect = delegate.tabBarController?(self, shouldSelect: vc) ?? true
            if shouldSelect == false {
                return
            }
        }
        
        // Check should hijack
        if let shouldHijackHandler = shouldHijackHandler {
            let shouldHijack = shouldHijackHandler(self, vc, targetIndex)
            if shouldHijack == true {
                // Do animate when hijack
                if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
                    animationItem.highlight(highlight: false, animated: true, completion: {
                        
                    })
                }
                return
            }
        }
        
        /// Do
        if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
            animationItem.highlight(highlight: false, animated: true, completion: nil)
        }
    }
    
    @objc internal func selectAction(_ sender: AnyObject?) {
        guard let items = tabBar.items else {
            reportEmptyItems()
            return
        }
        guard let container = sender as? UIView else {
            reportInvalidContainer()
            return
        }
        
        let targetIndex = container.tag
        let currentIndex = selectedIndex
        guard targetIndex < viewControllers?.count ?? 0 else {
            reportInvalidIndex(targetIndex)
            return
        }
        
        guard let vc = viewControllers?[targetIndex] else {
            return
        }
        
        /// Selectability check
        if vc.tabBarItem.isEnabled == false {
            return
        }
        if vc.tabBarItem.selectEnabled == false {
            return
        }
        
        // Check should select
        if let delegate = delegate {
            let shouldSelect = delegate.tabBarController?(self, shouldSelect: vc) ?? true
            if shouldSelect == false {
                return
            }
        }
        
        // Check should hijack
        if let shouldHijackHandler = shouldHijackHandler {
            let shouldHijack = shouldHijackHandler(self, vc, targetIndex)
            if shouldHijack == true {
                self.hijackHandler?(self, vc, targetIndex)
                // Do animate when hijack
                if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
                    animationItem.select(animated: true, completion: {
                        animationItem.deselect(animated: false, completion: {
                            
                        })
                    })
                }
                return
            }
        }
        
        /// Do
        if currentIndex != targetIndex {
            if currentIndex < items.count, let deselectItem = items[currentIndex] as? SimpleBarItem {
                deselectItem.deselect(animated: true, completion: nil)
            }
            if targetIndex < items.count, let animationItem = items[targetIndex] as? SimpleBarItem {
                animationItem.select(animated: true, completion: nil)
            }
            ignoreNextAnimation = true
            selectedIndex = targetIndex
            // Delegate
            delegate?.tabBarController?(self, didSelect: self)
            
        } else if currentIndex == targetIndex {
            /// Click the same again tab may require animation, so have the following:
            if currentIndex < items.count, let animationItem = items[currentIndex] as? SimpleBarItem {
                animationItem.reselect(animated: true, completion: nil)
            }
            if let navVC = viewControllers![selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
    }
    
}

extension SimpleTabBarController {
    open var transparentShadowBar: Bool {
        get {
            return self.tabBar.shadowImage == UIImage(named: "transparent")
        }
        set {
            if newValue {
                self.tabBar.shadowImage = UIImage(named: "transparent")
            } else {
                self.tabBar.shadowImage = nil
            }
        }
    }
}

extension SimpleTabBarController /* Error Report */ {
    fileprivate func reportEmptyItems() {
        print("SimpleTabBarController emtpy items")
    }
    
    fileprivate func reportInvalidIndex(_ index: Int) {
        print("SimpleTabBarController index \(index) invalid")
    }
    
    fileprivate func reportInvalidContainer() {
        print("SimpleTabBarController container invalid")
    }
}

internal class SimpleTabBarContainer: UIControl {
    
}
