//
//  AppDelegate.swift
//  SwiftYoutuberApp01
//
//  Created by 中塚富士雄 on 2020/09/07.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let hours = 19
    let minute = 00
    
    var notificatinGranted = true
    
    var isFirst = true
    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //許可を促すアラートを出す
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]){
            
        (granted, error) in
            
            self.notificatinGranted = granted
            //if error != nilと同じ⇩
            if let error = error{
                
                print("error")
                
            }
        }
        
        
        isFirst = false
        
        setNotification()
        
        return true
    }

    func setNotification(){
        
        var notificationTime = DateComponents()
        var trigger:UNNotificationTrigger
        
        notificationTime.hour = hours
        notificationTime.minute = minute
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "19時になりました"
        content.body = "収録情報に更新をかけました！"
        
        content.sound = .default
        
        //通知スタイル
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    //バックグランドでも通知を出す
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        setNotification()
        
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

