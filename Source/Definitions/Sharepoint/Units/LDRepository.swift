//
//  LDRepository.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDRepository {
    
    public var exchangeFlow: LDExchangeFlow!
    public var persistentStorage: LDPersistentStorage!
    public var stateMachine: LDStateMachine!
    public var dataStorage: LDDataStorage!
    
    public required init() {
        
    }
    
}
