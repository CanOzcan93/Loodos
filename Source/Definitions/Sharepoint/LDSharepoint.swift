//
//  LDSharepoint.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDSharepoint {
    
    public var agency: LDAgency!
    public var repository: LDRepository!
    
    private static var instance: LDSharepoint?
    
    public required init() {
        
    }
    
    public static func getInstance() -> LDSharepoint {
        
        guard instance != nil else {
            
            instance = LDSharepoint()
            
            instance!.agency = LDAgency()
            instance!.agency!.manager = LDManager()
            instance!.agency!.manager!.apiManager = LDApiManager()
            instance!.agency!.manager!.eventManager = LDEventManager()
            instance!.agency!.manager!.networkManager = LDNetworkManager()
            instance!.agency!.manager!.mediaManager = LDMediaManager()
            instance!.agency!.provider = LDProvider()
            instance!.agency!.provider!.colorProvider = LDColorProvider()
            instance!.agency!.provider!.fontProvider = LDFontProvider()
            instance!.agency!.provider!.imageProvider = LDImageProvider()
            
            instance!.repository = LDRepository()
            instance!.repository!.dataStorage = LDDataStorage()
            instance!.repository!.exchangeFlow = LDExchangeFlow()
            instance!.repository!.persistentStorage = LDPersistentStorage()
            instance!.repository!.stateMachine = LDStateMachine()
            
            instance!.agency!.manager!.apiManager!.injectDependencies()
            instance!.agency!.manager!.networkManager!.injectDependencies()
            
            return instance!
            
        }
        
        return instance!
        
    }
    
    public static func resetSharepoint() {
        instance = nil
        
    }
    
    
}
