//
//  Finance_TrackerApp.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI
import SwiftData
import GoogleMobileAds
/*
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
 
 */

@main
struct Finance_TrackerApp: App {
  //  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
       
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
       }
    
    var body: some Scene {
        WindowGroup {
          TabBar()
            
         //   TestBannerView()
          
        }
        .modelContainer(for: [Finance.self, Reminder.self , Category.self])
    }
}
