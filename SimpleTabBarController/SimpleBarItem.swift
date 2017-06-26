//
//  SimpleBarItem.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import Foundation
import UIKit

@IBDesignable
open class SimpleBarItem: UITabBarItem {
    
    @IBInspectable
    open var selectedColor: UIColor = .red {
        didSet {
            content?.appearance.highlightIconColor = selectedColor
        }
    }
    
    @IBInspectable
    open var unselectedColor: UIColor = UIColor(white: 146.0 / 255.0, alpha: 1.0) {
        didSet {
            content?.appearance.iconColor = unselectedColor
        }
    }
    
    open weak var tabBarController: SimpleTabBarController?
    /**
     The index position in the tabbar where the item is.
     */
    open var index: Int = 0
    /**
     The item content for the tabbaritem.
     */
    open var content: SimpleBarItemContent?
    /**
     The badge for this tabbaritem.
     */
    open var badge: SimpleTabBarBadge? {
        get {
            return content?.badgeView
        }
    }
    
    /**
     The image used to represent the item.
     If selectedImage is nil then this will also be the 
     image displayed when the tabbaritem is selected.
     */
    open override var image: UIImage? {
        set {
            self.content?.image = newValue
            // Must set the super to nil because we don't want UITabbar 
            // displaying the image we will handle it.
            super.image = nil
        }
        get {
            // Get should only return the super because 
            // we need to get the initial value from storyboard.
            return super.image
        }
    }
    
    /**
     The image used to represent the item when selected.
     */
    open override var selectedImage: UIImage? {
        didSet {
            self.content?.selectedImage = selectedImage
        }
    }
    
    /**
     The title that will be displayed on the item.
     If nil the no title will be displayed.
     */
    open override var title: String? {
        set { self.content?.title = newValue }
        get { return nil }
    }
    
    override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let content = SimpleBarItemContent(appearance: SimpleBounceAppearance())
        content.item = self
        content.selectedImage = selectedImage
        if image != nil {
            content.image = image
            super.image = nil
        }
        self.content = content
        self.content?.deselect(animated: false, completion: nil)
    }
    
    public convenience init(appearance: SimpleBarItemAppearance) {
        self.init()
        let content = SimpleBarItemContent(appearance: appearance)
        content.item = self
        self.content = content
        self.content?.deselect(animated: false, completion: nil)
    }
    
    public convenience init(content: SimpleBarItemContent?) {
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
extension SimpleBarItem {
    
    /**
     The value of the badge if nil the badge will not be displayed.
     */
    open override var badgeValue: String? {
        get {
            return badge?.badgeValue ?? nil
        }
        set(newValue) {
            self.content?.badgeValue = newValue
        }
    }
    
    /**
     The color of the badge the default is red.
     */
    open override var badgeColor: UIColor? {
        get {
            return badge?.badgeColor ?? nil
        }
        set(newValue) {
            if newValue == nil {
                self.badge?.badgeColor = .red
            } else {
                self.badge?.badgeColor = newValue!
            }
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
