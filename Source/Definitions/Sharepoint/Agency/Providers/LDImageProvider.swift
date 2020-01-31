//
//  LDImageProvider.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDImageProvider {
    
    public required init() {
        
    }
    
    private var left_arrow: UIImage?
    public func getLeftArrow() -> UIImage {
        
        guard left_arrow != nil else {
            left_arrow = UIImage(named: "ic_left_arrow")
            return left_arrow!
        }
        
        return left_arrow!
        
    }
    
}
