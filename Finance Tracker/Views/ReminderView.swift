//
//  ReminderView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 13.08.2024.
//

import SwiftUI
import SwiftData
import Lottie

struct ReminderView: View {
    
    @Query(sort: [SortDescriptor(\Reminder.date, order: .reverse)], animation: .snappy) private var reminders: [Reminder]
    @Environment(\.modelContext) private var context: ModelContext
    @State private var showAddReminder = false
    @ObservedObject private var viewModel = ReminderViewModel()

    private var groupedReminders: [Date: [Reminder]] {
        Dictionary(grouping: viewModel.filteredReminders(reminders), by: { Calendar.current.startOfDay(for: $0.date) })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if reminders.isEmpty {
                    GeometryReader { geometry in
                        VStack {
                            LottieView(animation: .named("notfound")).looping()
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                                .shadow(radius: 10)
                            
                            Text("No reminders yet")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    }
                } else {
                    List {
                        ForEach(groupedReminders.keys.sorted(), id: \.self) { date in
                            Section(header: Text(DateFormatter.dateFormatter.string(from: date))) {
                                ForEach(groupedReminders[date] ?? []) { reminder in
                                    HStack {
                                        Rectangle()
                                            .fill(Color.random())
                                            .frame(width: 8)
                                            .frame(maxHeight: .infinity)
                                            .cornerRadius(12.0)

                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(reminder.title)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.primary)
                                                    .frame(maxWidth: .infinity, alignment: .leading)

                                                HStack(spacing: 4) {
                                                    Image(systemName: "clock.fill")
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)

                                                    Text(reminder.date, style: .time)
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                            }

                                            if !reminder.notes.isEmpty {
                                                Text(reminder.notes)
                                                    .font(.body)
                                                    .foregroundColor(.primary)
                                                    .lineLimit(nil)
                                                    .padding(.top, 4)
                                            }
                                        }
                                        .presentationDetents([.height(180)])
                                        .padding()
                                        .cornerRadius(12)
                                    }
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            viewModel.deleteReminder(reminder, context: context)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .background(Color(UIColor.systemGray6))
                }
            }
            .navigationTitle("Reminders")
            .searchable(text: $viewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddReminder = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showAddReminder) {
               // AddReminderView()
            }
        }
    }
}

#Preview {
    ReminderView()
}
