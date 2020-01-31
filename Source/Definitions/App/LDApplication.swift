//
//  LDApplication.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation
import FirebaseMessaging
import UIKit

open class LDApplication: UIResponder, UIApplicationDelegate {
    
    public static var instance: LDApplication!
    public static var window: UIWindow!
    public static var application: UIApplication!
    
    public static var receiveRemoteNotification: ActionWith<[AnyHashable : Any]>!
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LDApplication.instance = self
        LDApplication.window = UIWindow(frame: UIScreen.main.bounds)
        LDApplication.application = application
        
        LDApplication.window.rootViewController = onRootViewController()!
        LDApplication.window.makeKeyAndVisible()
        
        LDApplication.window.backgroundColor = UIColor.white
        
        return true
        
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        LDApplication.receiveRemoteNotification?(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        LDApplication.receiveRemoteNotification?(userInfo)
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    open func onRootViewController() -> UIViewController? {
        return nil
    }
    
}
