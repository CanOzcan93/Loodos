//
//  SplashSheet-Main.swift
//  Loodos
//
//  Created by Can Özcan on 28.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Firebase


extension Main {
    
    public class SplashSheet: Sheet<SplashLayout>,UNUserNotificationCenterDelegate,MessagingDelegate {
        
        public override func onLayoutReady(layout: SplashLayout) {
            
            apiManager.checkConnection().then { (str) -> Promise<String> in
                FirebaseApp.configure()
                let remoteConfig = RemoteConfig.remoteConfig()
                self.setNotification()
                return self.apiManager.getAppName(remoteConfig: remoteConfig)
            }.done { (str) in
                layout.loaded = true
                layout.tv_title.text = str
                layout.afterAnimation = {
                    self.demonstrator.toMainSheet()
                }
            }.catch { (error) in
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    layout.popup_alert.show()
                }
                print(error.localizedDescription)
            }
            
            
        }
        
        
        private func setNotification() {
        
            if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self

              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                LDApplication.application!.registerUserNotificationSettings(settings)
            }

            LDApplication.application!.registerForRemoteNotifications()
            Messaging.messaging().delegate = self
            LDApplication.receiveRemoteNotification = { userInfo in
                
                if let messageID = userInfo["gcm.message_id"] {
                  print("Message ID: \(messageID)")
                }
                print(userInfo)
            }
            
            
            
        }
        
        public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
            print("Token: ",fcmToken)
        }
        
        public func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
            print("Message: ",remoteMessage.messageID)
        }
        
    }
    
}
