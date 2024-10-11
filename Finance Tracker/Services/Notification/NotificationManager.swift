//
//  NotificationManager.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 13.08.2024.
//

import Foundation
import UserNotifications

// MARK: - NotificationManager Class
final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Shared Instance
    static let shared = NotificationManager()
    
    private override init() {
        super.init()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Notification Methods
    func sendNotification(content: UNMutableNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }
}
