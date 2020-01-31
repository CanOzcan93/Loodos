//
//  Run.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class App: LDApplication {
    
    override func onRootViewController() -> UIViewController? {
        
        return Main.Module.getInstance().factory.sheetFactory.getSplashSheet()
        
    }
    
}
