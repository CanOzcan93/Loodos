//
//  LDDemonstrator.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDDemonstrator {
    
    open var sheet: UIViewController!
    open var transition: CATransition!
    
    public required init() {
        
    }
    
    open var current: UIViewController!
    public func setCurrent(vc: UIViewController) {
        current = vc
    }
    
    open func present() {
        
        LDApplication.window.layer.add(transition, forKey: kCATransition)
        sheet.modalPresentationStyle = .fullScreen
        current.present(sheet, animated: false, completion: nil)
        
    }
    
    open func present(completion: @escaping () -> ()) {
        
        LDApplication.window.layer.add(transition, forKey: kCATransition)
        sheet.modalPresentationStyle = .fullScreen
        current.present(sheet, animated: false, completion: completion)
        
    }
    
    open func dismiss() {
        
        LDApplication.window.layer.add(transition, forKey: kCATransition)
        current.dismiss(animated: false, completion: nil)
        
    }
    
    open func dismiss(completion: @escaping () -> ()) {
        
        LDApplication.window.layer.add(transition, forKey: kCATransition)
        current.dismiss(animated: false, completion: completion)
        
    }
    
    open func dismissNotAnimated() {
        
        current.dismiss(animated: false, completion: nil)
        
    }
    
    open func dismissNotAnimated(completion: @escaping () -> ()) {
        
        current.dismiss(animated: false, completion: completion)
        
    }
    
    open func dismissViewControllers() {
        LDApplication.window.rootViewController?.dismiss(animated: false) {
        }
    }
    
    open func dismissViewControllers(completion: @escaping () -> ()) {
        LDApplication.window.rootViewController?.dismiss(animated: false) {
            completion()
        }
    }
        
}
