//
//  LDActivityView.swift
//  Loodos
//
//  Created by Can Özcan on 30.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDActivityView: UIActivityIndicatorView {
    
    // Virtuals
    
    open func onInit() {}
    open func onInjection() {}
    open func onConstruct() {}
    open func onConstrain() {}
    open var setTouchEvent: Action?
    
    public var onDraw: ActionWith<CGRect>!
    
    public required init() { super.init(frame: .zero); initialize() }
    public override init(frame: CGRect) { super.init(frame: frame); initialize() }
    public required init(coder: NSCoder) { super.init(coder: coder) }

    private func initialize() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        onInit()
        onInjection()
        onConstruct()
        onConstrain()
        
    }
    
    
    
    
    // Tap Implementation
    
    private var onTapDelegate: Action!
    public func onTap(delegate: Action!) {
        
        self.onTapDelegate = delegate
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(on_tap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
        
    }
    
    @objc
    private func on_tap() {
        onTapDelegate()
    }
    
    
    // Draw Implementation
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        onDraw?(rect)
    }
    
    
    // Constraining
    
    public func relayout() {
        self.layoutIfNeeded()
    }
    
    public func constrain(constraint: NSLayoutConstraint) {
        self.addConstraint(constraint)
    }
    
    public func release(constraint: NSLayoutConstraint) {
        self.removeConstraint(constraint)
    }
    
    public func shift(from: NSLayoutConstraint, to: NSLayoutConstraint) {
        self.release(constraint: from)
        self.constrain(constraint: to)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setTouchEvent?()
    }
    
}

