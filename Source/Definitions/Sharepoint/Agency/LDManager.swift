//
//  LDManager.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

open class LDManager {
    
    public var apiManager: LDApiManager?
    public var eventManager: LDEventManager?
    public var networkManager: LDNetworkManager?
    public var mediaManager: LDMediaManager?
    
    public required init() {
        
    }
    
}
