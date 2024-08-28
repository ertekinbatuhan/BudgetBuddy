import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context

    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            DatePicker("Bir Tarih Seçin", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Section(header: Text("\(DateFormatter.dateFormatter.string(from: selectedDate))")) {
                List {
                    ForEach(filteredFinances) { finance in
                        HStack {
                            financeIcon(for: finance.financeType)
                            Text(finance.category?.categoryName ?? "Bilinmiyor")
                            Spacer()
                            Text("\(finance.amount, specifier: "%.2f")")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                HStack {
                    Text("Toplam:")
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

    private func financeIcon(for type: FinanceType?) -> some View {
        switch type {
        case .income:
            return Image(systemName: "arrow.up.circle.fill") 
                .foregroundColor(.green)
        case .expense:
            return Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(.red)
        default:
            return Image(systemName: "questionmark.circle")
                .foregroundColor(.gray)
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

