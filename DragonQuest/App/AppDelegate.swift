//
//  AppDelegate.swift
//  DragonQuest
//
//  App Delegate for notification handling
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Notification delegate'i ayarla
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    
    // Uygulama açıkken bildirim geldiğinde
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Bildirim gösterilsin
        completionHandler([.banner, .sound, .badge])
    }
    
    // Bildirime tıklandığında
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        
        // Task ID varsa, ilgili göreve git
        if let taskIdString = userInfo["taskId"] as? String,
           let taskId = UUID(uuidString: taskIdString) {
            // TODO: Navigate to task detail
            print("Navigate to task: \(taskId)")
        }
        
        completionHandler()
    }
}


