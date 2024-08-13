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
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = ReminderViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("Notes", text: $notes)
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            viewModel.saveReminder(title: title, date: date, notes: notes, context: modelContext) { success in
                                if success {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                }
                            }
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.headline)
                        }
                        .padding(.top)
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .font(.headline)
                        }
                        .padding(.top)
                    }
                    .padding()
                }
            }
            .navigationTitle("Add Reminder")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.requestNotificationAuthorization()
        }
    }
}

