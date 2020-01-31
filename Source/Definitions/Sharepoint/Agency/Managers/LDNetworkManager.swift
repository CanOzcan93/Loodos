//
//  LDNetworkManager.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDNetworkManager: NSObject {
    
    /*
    -
    -
    // MARK: Sharepoint
    -
    -
    */
    
    private var sharepoint: LDSharepoint!
    
    private var agency: LDAgency!
    private var repository: LDRepository!
    
    private var manager: LDManager!
    
    private var eventManager: LDEventManager!
    private var networkManager: LDNetworkManager!
    
    private var dataStorage: LDDataStorage!
    private var persistentStorage: LDPersistentStorage!
    private var exchangeFlow: LDExchangeFlow!
    private var stateMachine: LDStateMachine!
    
    public func injectDependencies() {

        sharepoint = LDSharepoint.getInstance()
        agency = sharepoint.agency
        repository = sharepoint.repository
        manager =  agency.manager
        
        eventManager = manager.eventManager!
        networkManager = manager.networkManager!
        
        dataStorage = repository.dataStorage
        persistentStorage = repository.persistentStorage
        exchangeFlow = repository.exchangeFlow
        stateMachine = repository.stateMachine
        
    }
}
