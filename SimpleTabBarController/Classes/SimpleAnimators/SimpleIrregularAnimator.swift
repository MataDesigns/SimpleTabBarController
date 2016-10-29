//
//  SimpleIrregularAnimator.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import UIKit

open class SimpleIrregularAnimator: SimpleTabBarItemAnimator {
    
    open override var content: UIView? {
        didSet {
            if let content = content as? SimpleTabBarItemContent {
                content.imageView.backgroundColor = UIColor(red: 23/255.0, green: 149/255.0, blue: 158/255.0, alpha: 1.0)
                content.imageView.layer.borderWidth = 3.0
                content.imageView.layer.borderColor = UIColor(white: 235 / 255.0, alpha: 1.0).cgColor
                content.imageView.layer.cornerRadius = 35
                content.insets = UIEdgeInsetsMake(-32, 0, 0, 0)
                let transform = CGAffineTransform.identity
                content.imageView.transform = transform
                content.superview?.bringSubview(toFront: content)
            }
        }
    }
    
    public override init() {
        super.init()
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backgroundColor = UIColor.clear
        highlightBackgroundColor = UIColor.clear
    }
    
    open override func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(content: content, animated: animated, completion: completion)
    }

    open override func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.reselectAnimation(content: content, animated: animated, completion: completion)
    }

    open override func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(content: content, animated: animated, completion: completion)

    }

    open override func highlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.highlightAnimation(content: content, animated: animated, completion: completion)

    }

    open override func dehighlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.dehighlightAnimation(content: content, animated: animated, completion: completion)

    }
    
}

