import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context

    @State private var selectedDate = Date()

    var body: some View {
        VStack {
           
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            
            Section(header: Text("\(DateFormatter.dateFormatter.string(from: selectedDate))")) {
                List {
                    ForEach(filteredFinances) { finance in
                        HStack {
                            Text(finance.category?.categoryName ?? "Bilinmiyor")
                            Spacer()
                            Text("\(finance.amount, specifier: "%.2f")")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
             
                Text("Toplam: \(totalAmount, specifier: "%.2f")")
                    .font(.headline)
                    .padding()
            }
        }
    }

   
    private var filteredFinances: [Finance] {
        allFinances.filter { finance in
            let date = finance.date
            return Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
    }

        private var totalAmount: Double {
        filteredFinances.reduce(0) { $0 + $1.amount }
    }
}


#Preview {
    CalendarView()
}

