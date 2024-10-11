import SwiftUI
import SwiftData

struct CalendarView: View {
    
    // MARK: - Data Queries
    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    // MARK: - Environment Variables
    @Environment(\.modelContext) private var context
    // MARK: - UI State
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            DatePicker("REMINDERS_DATE_SELECT", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Section(header: Text("\(DateFormatter.dateFormatter.string(from: selectedDate))")) {
                List {
                    ForEach(filteredFinances) { finance in
                        HStack {
                            FinanceIconView(type: finance.financeType)
                            Text(finance.category?.categoryName ?? "Bilinmiyor")
                            Spacer()
                            Text("\(finance.amount, specifier: "%.2f")")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                HStack {
                    Text("GENERAL_TOTAL")
                        .font(.headline)
                    Text("\(totalAmount, specifier: "%.2f") ₺")
                        .font(.title2)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .center)
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

