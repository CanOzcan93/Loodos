//
//  LDCompoundView.swift
//  Loodos
//
//  Created by Can Özcan on 30.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDCompoundView: NSObject {
    
    
    // Internal Fields
    
    private var set: [NSLayoutConstraint]!
    
    
    // Virtuals
    
    open func onInit() {}
//    open func onInjection() {}
    open func onConstruct(layout: LDLayout) {}
    open func onConstrain(set: inout [NSLayoutConstraint], layout: LDLayout) {}
    
    
    // Required Fields
    
    private var layout: LDLayout!
    
    
    // init
    
    public required init(layout: LDLayout) { super.init(); initialize(layout: layout) }
    private func initialize(layout: LDLayout) {
        
        self.layout = layout
        
        onInit()
        onInjection()
        
        self.set = [NSLayoutConstraint]()
        
        onConstruct(layout: self.layout)
        onConstrain(set: &self.set, layout: self.layout)
        
        if self.set.count != 0 {
            self.layout!.addConstraints(self.set)
            self.layout!.layoutIfNeeded()
        }
        
    }
    
    
    // Constraining
    
    public func relayout() {
        self.layout.layoutIfNeeded()
    }
    
    public func constrain(constraint: NSLayoutConstraint) {
        self.layout.addConstraint(constraint)
    }
    
    public func release(constraint: NSLayoutConstraint) {
        self.layout.removeConstraint(constraint)
    }
    
    public func shift(from: NSLayoutConstraint, to: NSLayoutConstraint) {
        self.release(constraint: from)
        self.constrain(constraint: to)
    }
    
    public func shift(from: [NSLayoutConstraint], to: [NSLayoutConstraint]) {
        self.layout.removeConstraints(from)
        self.layout.addConstraints(to)
    }
    
    
    // Methods
    
    public func packView(_ view: UIView) {
        self.layout.addSubview(view)
    }
    
    // Sharepoint
    
    private var sharepoint: LDSharepoint!
    
    private var agency: LDAgency!
    
    private var provider: LDProvider!
    
    open var fontProvider: LDFontProvider!
    open var colorProvider: LDColorProvider!
    open var imageProvider: LDImageProvider!
    
    open func onInjection() {
        
        sharepoint = LDSharepoint.getInstance()
        
        agency = sharepoint.agency
        
        provider = agency.provider
        
        fontProvider = provider.fontProvider
        colorProvider = provider.colorProvider
        imageProvider = provider.imageProvider
        
    }
    
}
