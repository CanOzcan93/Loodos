//
//  LDFactory.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDFactory<SheetFactoryType: LDSheetFactory, TransitionFactoryType: LDTransitionFactory>{
    
    public var sheetFactory: SheetFactoryType!
    public var transitionFactory: TransitionFactoryType!
    
    public required init() {
        
    }
    
}
