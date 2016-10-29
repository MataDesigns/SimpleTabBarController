//
//  SimpleTabBarItem.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import Foundation
import UIKit

open class SimpleTabBarItem: UITabBarItem {
    
    open weak var tabBarController: SimpleTabBarController?
    open var index: Int = 0
    open var content: SimpleTabBarItemContent?
    open var badge: SimpleTabBarBadge?
    
    open override var image: UIImage? {
        set {
            self.content?.image = newValue
            super.image = nil
        }
        get { return super.image }
    }
    open override var selectedImage: UIImage? {
//        set {
//            self.content?.selectedImage = newValue
//            super.selectedImage = nil
//        }
//        get { return super.selectedImage }
        didSet {
            self.content?.selectedImage = selectedImage
        }
    }
    open override var title: String? {
        set { self.content?.title = newValue }
        get { return nil }
    }
    
    override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let content = SimpleTabBarItemContent(animator: SimpleBounceAnimator())
        content.item = self
        self.content = content
        self.content?.deselect(animated: false, completion: nil)
    }
    
    public convenience init(animator: SimpleTabBarItemAnimatorProtocol) {
        self.init()
        let content = SimpleTabBarItemContent.init(animator: animator)
        content.item = self
        self.content = content
        self.content?.deselect(animated: false, completion: nil)
    }
    
    public convenience init(content: SimpleTabBarItemContent?) {
        self.init()
        self.content = content
        self.content?.item = self
        self.content?.deselect(animated: false, completion: nil)
    }
    
    open func select(animated: Bool, completion: (() -> ())?){
        content?.select(animated: animated, completion: completion)
    }
    
    open func reselect(animated: Bool, completion: (() -> ())?){
        content?.reselect(animated: animated, completion: completion)
    }
    
    open func deselect(animated: Bool, completion: (() -> ())?){
        content?.deselect(animated: animated, completion: completion)
    }
    
    open func highlight(highlight: Bool, animated: Bool, completion: (() -> ())?){
        content?.highlight(highlight: highlight, animated: animated, completion: completion)
    }
    
    
}

// MARK: - Badge Extensions
extension SimpleTabBarItem {
    
    override open var badgeValue: String? {
        get {
            return badge?.badgeValue ?? nil
        }
        set(newValue) {
            self.content?.badgeValue = newValue
        }
    }
    
}

private var kSelectEnabledAssociateKey: String = ""
extension UITabBarItem {
    var selectEnabled: Bool? {
        get {
            let obj = (objc_getAssociatedObject(self, &kSelectEnabledAssociateKey) as? NSNumber)
            return obj?.boolValue
        }
        set(newValue) {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &kSelectEnabledAssociateKey, NSNumber.init(value: newValue as Bool), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

extension NSObjectProtocol where Self: UITabBarControllerDelegate {
    func tabBarController(_ tabBarcontroller: UITabBarController?, shouldSelectViewController viewController: UIViewController) -> Bool {
        return viewController.tabBarItem.selectEnabled ?? true
    }
}
