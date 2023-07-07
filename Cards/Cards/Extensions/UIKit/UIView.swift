//
//  UIView.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

// MARK: - Properties
extension UIView {
    /// Sets the corner radius value to half the height value.
    @IBInspectable public var isRound: Bool {
        get { return self.cornerRadius == halfHeight }
        set { self.cornerRadius = halfHeight }
    }
    
    private var halfHeight: CGFloat { self.bounds.height * 0.5 }
    
    /// Sets and return the layer corner radius.
    @IBInspectable public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set {
            self.layer.masksToBounds = newValue != .zero
            self.layer.cornerRadius  = newValue
        }
    }
    
    /// Sets and return the layer border width
    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// Sets and return the layer border color
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor.init(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    /// Return subviews of superview, or arrangedSubviews if superview is UIStackView
    public var siblings: [UIView]? {
        if let stackView = superview as? UIStackView { return stackView.arrangedSubviews }
        
        return superview?.subviews
    }
    
    /// Return content size based on min and max x and y parameters of subviews
    public var viewContentSize: CGSize {
        guard !subviews.isEmpty,
              let minX = subviews.map({ $0.frame.minX }).min(),
              let maxX = subviews.map({ $0.frame.maxX }).max(),
              let minY = subviews.map({ $0.frame.minY }).min(),
              let maxY = subviews.map({ $0.frame.maxY }).max() else {
                  return self.bounds.size
              }
        
        return CGSize(width: maxX - minX, height: maxY - minY)
    }
}

// MARK: - Methods
public extension UIView {
    // MARK: Constraints
    /// Add subview and add centered x and y constraints
    func addSubviewWithCenterConstraints(_ view: UIView) {
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
        view.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
    }
    
    /// Add subview with top, bottom, left and right constraints.
    func addSubviewWithConstraints(_ view: UIView, insets: UIEdgeInsets = .zero) {
        addSubviewWithConstraints(
            view, top: insets.top, left: insets.left,
            bottom: insets.bottom, right: insets.right
        )
    }
    
    /// Add subview with needed constraints.
    func addSubviewWithConstraints(
        _ view: UIView, top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil,
        right: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil
    ) {
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            view.topAnchor
                .constraint(equalTo: self.topAnchor, constant: top)
                .isActive = true
        }
        
        if let left = left {
            view.leftAnchor
                .constraint(equalTo: self.leftAnchor, constant: left)
                .isActive = true
        }
        
        if let bottom = bottom {
            view.bottomAnchor
                .constraint(equalTo: self.bottomAnchor, constant: -bottom)
                .isActive = true
        }
        
        if let right = right {
            view.rightAnchor
                .constraint(equalTo: self.rightAnchor, constant: -right)
                .isActive = true
        }
        
        if let height = height {
            view.heightAnchor
                .constraint(equalToConstant: height)
                .isActive = true
        }
        
        if let width = width {
            view.widthAnchor
                .constraint(equalToConstant: width)
                .isActive = true
        }
    }
}
