//
//  AddReminderView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 14.08.2024.
//

import SwiftUI
import UserNotifications

struct AddReminderView: View {
    
    @State private var title = ""
    @State private var date = Date()
    @State private var notes = ""
    @State private var isNotificationRequested = false // Bildirim yetkisi kontrolü
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = ReminderViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("REMINDER_DETAILS")) {
                        TextField("REMINDER_TITLE", text: $title)
                        DatePicker("REMINDER_DATE", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        TextField("REMINDER_NOTES", text: $notes).padding()
                    }
                    
                    VStack {
                        Button(action: {
                            viewModel.saveReminder(title: title, date: date, notes: notes, context: modelContext) { success in
                                if success {
                                   presentationMode.wrappedValue.dismiss()
                                } else {
                                
                                }
                            }
                        }) {
                            Text("REMINDER_SAVE")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.headline)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("REMINDER_ADDREMINDER")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            
            if !isNotificationRequested {
                viewModel.requestNotificationAuthorization()
                isNotificationRequested = true
            }
        }
    }
}
