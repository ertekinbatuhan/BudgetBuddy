//
//  ReminderViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 13.08.2024.
//

import SwiftUI
import SwiftData
import UserNotifications

protocol ReminderViewModelProtocol {
    var searchText: String { get set }
    func saveReminder(title: String?, date: Date?, notes: String?, context: ModelContext, completion: @escaping (Bool) -> Void)
    func deleteReminder(_ reminder: Reminder?, context: ModelContext)
    func filteredReminders(_ reminders: [Reminder]) -> [Reminder]
    func requestNotificationAuthorization()
}

class ReminderViewModel: ObservableObject, ReminderViewModelProtocol {
    
    @Published var searchText = ""

    func filteredReminders(_ reminders: [Reminder]) -> [Reminder] {
        if searchText.isEmpty {
            return reminders
        } else {
            return reminders.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.notes.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func saveReminder(title: String?, date: Date?, notes: String?, context: ModelContext, completion: @escaping (Bool) -> Void) {
        
        guard let title = title, !title.isEmpty,
              let date = date,
              let notes = notes, !notes.isEmpty else {
            completion(false)
            return
        }
        
        let newReminder = Reminder(title: title, date: date, notes: notes)
        
        do {
            context.insert(newReminder)
            try context.save()
          
            scheduleNotification(for: newReminder)
            
            completion(true)
        } catch {
            print("Failed to save reminder: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func deleteReminder(_ reminder: Reminder?, context: ModelContext) {
        guard let reminder = reminder else {
            print("Reminder is nil, cannot delete.")
            return
        }
        
        context.delete(reminder)
        do {
            try context.save()
        } catch {
            print("There was a problem when deleting: \(error.localizedDescription)")
        }
    }
    
    private func scheduleNotification(for reminder: Reminder?) {
        guard let reminder = reminder else {
            print("Reminder is nil, cannot schedule notification.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = reminder.notes
        content.sound = .default
           
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
           
        NotificationManager.shared.sendNotification(content: content, trigger: trigger)
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }
}
