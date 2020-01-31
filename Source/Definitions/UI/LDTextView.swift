//
//  LDTextView.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDTextView: UILabel {
    
    // Virtuals
    
    open func onInit() {}
    open func onInjection() {}
    open func onConstruct() {}
    open func onConstrain() {}
    
    public var onDraw: ActionWith<CGRect>!
    
    // init
    
    public required init() { super.init(frame: .zero); self.initialize() }
    public required init?(coder decoder: NSCoder) { super.init(coder: decoder) }
    private func initialize() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        onInit()
        onInjection()
        onConstruct()
        onConstrain()
        
    }
    
    
    // Draw Implementation
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        onDraw?(rect)
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
    
}
