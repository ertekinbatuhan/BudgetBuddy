//
//  DatePickerView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import SwiftUI

// MARK: - DatePickerView
// A view for selecting a date and time.
struct DatePickerView: View {
    // MARK: - Binding Properties
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "REMINDERS_DATE_SELECT",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                Button("REMINDERS_SAVE_BUTTON") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
                .padding()
            }
            .navigationTitle("REMINDERS_DATE_SELECT")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
