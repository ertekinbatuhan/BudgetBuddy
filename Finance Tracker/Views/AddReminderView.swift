import SwiftUI
import UserNotifications
import GoogleMobileAds

struct AddReminderView: View {
    
    @State private var title = ""
    @State private var date = Date()
    @State private var notes = ""
    @State private var isNotificationRequested = false
    @State private var showDatePicker = false
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = ReminderViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Hatırlatıcı Başlığı")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextField("Hatırlatıcı başlığını girin", text: $title)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(8)
                                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 8)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("REMINDERS_DATE_HOUR")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Button(action: {
                                    showDatePicker = true
                                }) {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            HStack {
                                Text("Tarih Seç")
                                Spacer()
                                Text(date, style: .date)
                                Text(date, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(8)
                            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 8)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Notlar")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextEditor(text: $notes)
                                .frame(height: 120)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(8)
                                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 8)
                        
                        Button(action: {
                            viewModel.saveReminder(title: title, date: date, notes: notes, context: modelContext) { success in
                                if success {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                }
                            }
                        }) {
                            Text("REMINDERS_SAVE_BUTTON")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.headline)
                        }
                        .padding()
                    }
                    .padding()
                }
                
                BannerView()
                    .frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
            }
            .navigationTitle("REMINDERS_ADD_BUTTON")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showDatePicker) {
                DatePickerView(selectedDate: $date, isPresented: $showDatePicker)
            }
        }
        .onAppear {
            if !isNotificationRequested {
                viewModel.requestNotificationAuthorization()
                isNotificationRequested = true
            }
        }
    }
}


