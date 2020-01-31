//
//  LDModule.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDModule<FactoryType: LDFactory<SheetFactoryType,TransitionFactoryType>,SheetFactoryType: LDSheetFactory,TransitionFactoryType: LDTransitionFactory, DemonstratorType: LDDemonstrator> {
    
    public var factory: FactoryType!
    public var demonstrator: DemonstratorType!
    
    public required init() {
        
    }
    
}
