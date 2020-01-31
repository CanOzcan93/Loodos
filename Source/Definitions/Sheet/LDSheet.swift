//
//  LDSheet.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

import UIKit

open class LDSheet<LayoutType: LDLayout>: UIViewController {
    
    /*
     -
     -
     // MARK: Basic Definitions
     -
     -
     */
    
    private var initialized: Bool = false
    
    private var layout: LayoutType!
    
    open func onInit() {}
    open func onLayoutReady(layout: LayoutType) {}
    open func onLayoutAppear(layout: LayoutType) {}
    open func onLayoutFirstAppear(layout: LayoutType) {}
    open func onLayoutReappear(layout: LayoutType) {}
    open func onLayoutDisappear(layout: LayoutType) {}
    
    open func onDismiss() {}
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        onInjection()
        
        onInit()
        
        layout = LayoutType.init()
        
        self.view = layout
        
        onLayoutReady(layout: layout)
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if (initialized) {
            onLayoutReappear(layout: layout)
        }
        else {
            onLayoutFirstAppear(layout: layout)
        }
        onLayoutAppear(layout: layout)
        
        self.initialized = true
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        onLayoutDisappear(layout: layout)
        
        super.viewDidDisappear(animated)
        
        
    }
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        onDismiss()
        
        super.dismiss(animated: flag, completion: completion)
        
    }
    
    /*
     -
     -
     // MARK: Sharepoint Definitions
     -
     -
     */
    
    private var sharepoint: LDSharepoint!
    
    private var agency: LDAgency!
    private var repository: LDRepository!
    
    private var manager: LDManager!
    private var provider: LDProvider!
    
    open var apiManager: LDApiManager!
    open var eventManager: LDEventManager!
    open var networkManager: LDNetworkManager!
    open var mediaManager: LDMediaManager!
    
    open var fontProvider: LDFontProvider!
    open var colorProvider: LDColorProvider!
    open var imageProvider: LDImageProvider!
    
    open var dataStorage: LDDataStorage!
    open var exchangeFlow: LDExchangeFlow!
    open var persistentStorage: LDPersistentStorage!
    open var stateMachine: LDStateMachine!
    
    open func onInjection() {
        
        sharepoint = LDSharepoint.getInstance()
        
        agency = sharepoint.agency
        repository = sharepoint.repository
        
        manager = agency.manager
        provider = agency.provider
        
        apiManager = manager.apiManager
        eventManager = manager.eventManager
        networkManager = manager.networkManager
        mediaManager = manager.mediaManager
        
        colorProvider = provider.colorProvider
        fontProvider = provider.fontProvider
        imageProvider = provider.imageProvider
        
        dataStorage = repository.dataStorage
        exchangeFlow = repository.exchangeFlow
        persistentStorage = repository.persistentStorage
        stateMachine = repository.stateMachine
        
    }
    
}
