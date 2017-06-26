//
//  SimpleBarItemContent.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import Foundation
import UIKit

open class SimpleBarItemContent: UIView {
    
    open weak var item: UITabBarItem!
    open var appearance: SimpleBarItemAppearance!
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var highlighted: Bool = false
    open var highlightEnabled: Bool = true
    
    // Badge
    open var badgeView: SimpleTabBarBadge!
    open var badgeOffset: UIOffset = UIOffset.init(horizontal: 12.0, vertical: -21.0)
    open var badgeValue: String? {
        didSet {
            badgeView.badgeValue = badgeValue
            setNeedsLayout()
            appearance.badgeChangedAnimation(content: self, completion: nil)
        }
    }
    
    open var selected: Bool = false {
        didSet {
            if selected == true && selectedImage != nil {
                imageView.image = selectedImage
            } else {
                imageView.image = image
            }
        }
    }
    open var image: UIImage? {
        didSet {
            if selected == false || selectedImage == nil {
                imageView.image = image
                appearance.deselectAnimation(content: self, animated: false, completion: nil)
                setNeedsLayout()
            }
        }
    }
    open var selectedImage: UIImage? {
        didSet {
            if selected == true {
                imageView.image = selectedImage
                appearance.selectAnimation(content: self, animated: false, completion: nil)
                setNeedsLayout()
            }
        }
    }
    open var title: String? {
        didSet {
            titleLabel.text = title
            setNeedsLayout()
        }
    }
    
    open var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    open var titleLabel: UILabel = {
        let titleLabel = UILabel.init(frame: CGRect.zero)
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 9.0)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        appearance = SimpleBarItemAppearance()
        appearance.content = self
        badgeView = SimpleTabBarBadge()
        badgeView?.isHidden = true
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(badgeView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(appearance anim: SimpleBarItemAppearance) {
        self.init()
        isUserInteractionEnabled = false
        appearance = anim
        anim.content = self
        badgeView = SimpleTabBarBadge()
        badgeView?.isHidden = true
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(badgeView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        imageView.isHidden = (imageView.image != nil) ? false : true
        titleLabel.isHidden = (titleLabel.text != nil) ? false : true
        if imageView.image != nil && titleLabel.text != nil {
            titleLabel.sizeToFit()
            imageView.sizeToFit()
            titleLabel.frame = CGRect.init(x: (w - titleLabel.bounds.size.width) / 2.0, y: h - titleLabel.bounds.size.height - 1.0, width: titleLabel.bounds.size.width, height: titleLabel.bounds.size.height)
            imageView.frame = CGRect.init(x: (w - imageView.bounds.size.width) / 2.0, y: (h - imageView.bounds.size.height) / 2.0, width: imageView.bounds.size.width, height: imageView.bounds.size.height)
        } else if imageView.image != nil {
            imageView.sizeToFit()
            imageView.center = CGPoint.init(x: w / 2.0, y: h / 2.0)
        } else if titleLabel.text != nil {
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint.init(x: w / 2.0, y: h / 2.0)
        }
        
        if let badgeView = badgeView {
            let size = badgeView.sizeThatFits(self.frame.size)
            badgeView.frame = CGRect.init(origin: CGPoint.init(x: w / 2.0 + badgeOffset.horizontal, y: h / 2.0 + badgeOffset.vertical), size: size)
        }
        
    }
    
    open func select(animated: Bool, completion: (() -> ())?){
        selected = true
        if highlightEnabled == true && highlighted == true {
            highlighted = false
            appearance.dehighlightAnimation(content: self, animated: animated, completion: {
                self.appearance.selectAnimation(content: self, animated: animated, completion: completion)
            })
        } else {
            appearance.selectAnimation(content: self, animated: animated, completion: completion)
        }
    }
    
    open func reselect(animated: Bool, completion: (() -> ())?){
        selected = true
        appearance.reselectAnimation(content: self, animated: animated, completion: completion)
    }
    
    open func deselect(animated: Bool, completion: (() -> ())?){
        selected = false
        appearance.deselectAnimation(content: self, animated: animated, completion: completion)
    }
    
    open func highlight(highlight: Bool, animated: Bool, completion: (() -> ())?){
        if highlightEnabled == true && highlighted != highlight {
            highlighted = highlight
            if highlighted == true {
                appearance.highlightAnimation(content: self, animated: animated, completion: completion)
            } else {
                appearance.dehighlightAnimation(content: self, animated: animated, completion: {
                    if self.selected == true {
                        self.appearance.selectAnimation(content: self, animated: false, completion: completion)
                    } else {
                        self.appearance.deselectAnimation(content: self, animated: false, completion: completion)
                    }
                })
            }
        }
    }
    
}
