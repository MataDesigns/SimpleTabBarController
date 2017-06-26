//
//  SimpleBarItemBadge.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import Foundation
import UIKit

public enum SimpleTabBarBadgeType {
    case `default`, number
}

open class SimpleTabBarBadge: UIView {
    
    /**
     The maximum size the badge can be.
     */
    open var maximumSize: CGSize = CGSize(width: 28.0, height: 16.0)
    /**
     The minimum size the badge can be.
     */
    open var minimumSize: CGSize = CGSize(width: 6.0, height: 6.0)
    /**
     The color of the badge.
     */
    open var badgeColor: UIColor = UIColor.red {
        didSet {
            self.backgroundColor = badgeColor
        }
    }
    
    /**
     The value that should be displayed in the badge.
     If you want to hide the badge set this to nil.
     */
    open var badgeValue: String? {
        didSet {
            guard let badgeValue = badgeValue else {
                self.isHidden = true
                return
            }
            self.isHidden = false
            badgeLabel.text = badgeValue
        }
    }
    
    fileprivate var badgeLabel: UILabel!
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = badgeColor
        badgeLabel = UILabel()
        badgeLabel.font = UIFont.systemFont(ofSize: 11.0)
        badgeLabel.textColor = UIColor.white
        badgeLabel.textAlignment = .center
        addSubview(badgeLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.badgeLabel.frame = self.bounds
        if layer.cornerRadius != self.bounds.size.height / 2.0 {
            layer.cornerRadius = self.bounds.size.height / 2.0
        }
    }
    
    open override func sizeToFit() {
        let size = self.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let center = self.center
        UIView.performWithoutAnimation {
            self.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            self.center = center
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var s = CGSize.zero
        guard let badgeValue = badgeValue else {
            return s
        }
        if badgeValue.characters.count > 0 {
            s = badgeLabel.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
            s.width = ceil(min(maximumSize.width, max(maximumSize.height, s.width + 6.0)))
            s.height = ceil(maximumSize.height)
        } else {
            s = self.minimumSize
        }
        return s
    }
    
}
